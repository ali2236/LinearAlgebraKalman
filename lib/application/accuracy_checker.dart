import 'dart:async';

import 'package:datafusion/models/virtual_object_2d.dart';
import 'package:linalg/linalg.dart';

class AccuracyStreamTransform extends StreamTransformerBase<Matrix, double> {

  final VirtualObject2D object;

  AccuracyStreamTransform(this.object);

  @override
  Stream<double> bind(Stream<Matrix> stream) async*{
    await for(var temp in stream){
      var accuracy = _calculateAccuracy(object.surfaceTemps, temp);
      yield accuracy;
    }
  }

  double _calculateAccuracy(Matrix source, Matrix noised){
    var rows = source.m;
    var columns = source.n;
    var min = object.minTemp;
    var max = object.maxTemp;
    var total = 0.0;

    for (int i = 0; i < rows; i++) {
      for (int j = 0; j < columns; j++) {
        var percent = 1 - ((source[i][j] - min)/(max - min) - (noised[i][j] - min)/(max - min)).abs();
        total += percent;
      }
    }

    return (total / (rows * columns));
  }

}