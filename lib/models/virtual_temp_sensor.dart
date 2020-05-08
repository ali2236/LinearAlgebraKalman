import 'dart:async';
import 'dart:math';

import 'package:datafusion/application/accuracy_checker.dart';
import 'package:datafusion/kalman/kalman_stream_transformer.dart';
import 'package:datafusion/models/temp_sensor.dart';
import 'package:datafusion/models/virtual_object_2d.dart';
import 'package:linalg/linalg.dart';

class VirtualTempSensor2D extends TempSensor {

  final VirtualObject2D object;
  AccuracyStreamTransform accuracyCalculator;
  double totalAccuracy = 0.0;
  var filter = KalmanStreamTransformer(false);

  @override
  bool get kalmanFilter => filter.working;

  @override
  set kalmanFilter(bool value) {
    if(value==filter.working) return;
    filter.working = value;
    notifyListeners();
  }

  VirtualTempSensor2D(double errorRate, this.object, [String name]) : super(name ?? 'سنسور دو بعدی', errorRate){
    accuracyCalculator = AccuracyStreamTransform(object);
    updateTempsStream();
    _startAccuracyCheck();
  }

  void updateTempsStream(){
    temps = measureTemps().transform(filter).asBroadcastStream(onListen: (sub){
      object.emit();
    });
  }

  void _startAccuracyCheck(){
    addListener(checkAccuracy);
    checkAccuracy();
  }

  StreamSubscription _subscription;
  void checkAccuracy(){
    if(_subscription!=null){
      _subscription.cancel();
    }
    _subscription = temps.listen((data){
      calculateAccuracy(data);
    });
  }

  Stream<Matrix> measureTemps() async*{
    var random = Random();
    var objectTemps = object.temps;
    await for(var source in objectTemps){
      var rows = source.m;
      var columns = source.n;
      var noised = _addConstantNoise(source, rows, columns, random);
      _addRandomNoise(noised, rows, columns, random);
      yield noised;
    }
  }

  Matrix _addConstantNoise(Matrix source, int rows, int columns, Random random){
    var delta = _randomDelta(random);
    var result = Matrix.fill(rows, columns, delta);
    for (int i = 0; i < rows; i++) { //
      for (int j = 0; j < columns; j++) { // bColumn
        result[i][j] += source[i][j];
      }
    }
    return result;
  }

  void _addRandomNoise(Matrix noised, int rows, int columns, Random random){
    var k = random.nextInt((rows*columns) ~/ 10);
    for (int c = 0; c < k; c++) {
      var i = random.nextInt(rows);
      var j = random.nextInt(columns);
      var delta = _randomDelta(random);

      noised[i][j] += delta;
    }
  }

  double _randomDelta(Random random){
    if(errorRate==0.0) return 0.0;
    var sign = random.nextBool() ? 1 : -1;
    var amount = random.nextDouble() * errorRate;
    var delta = sign * amount;
    return delta;
  }


  void calculateAccuracy(Matrix output){
    var _accuracy = accuracyCalculator.calculateAccuracy(output);
    accuracy.value = _accuracy;
    totalAccuracy += _accuracy;
    avgAccuracy.value = totalAccuracy / ++updates;
  }

}