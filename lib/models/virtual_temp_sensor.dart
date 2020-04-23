import 'dart:math';

import 'package:datafusion/models/temp_sensor.dart';
import 'package:datafusion/models/world_object_2d.dart';
import 'package:scidart/numdart.dart';


class VirtualTempSensor2D extends TempSensor {

  final double errorRate;
  final VirtualObject2D object;

  VirtualTempSensor2D(this.errorRate, this.object);

  @override
  Stream<Array2d> measureTemps() async*{
    var random = Random();
    var temps = object.temps;
    await for(var temp in temps){
      var rows = temp.row;
      var columns = temp.column;
      var noised = addConstantNoise(temp, rows, columns, random);
      addRandomNoise(noised, rows, columns, random);
      yield noised;
    }
  }

  Array2d addConstantNoise(Array2d source, int rows, int columns, Random random){

    var result = Array2d.fixed(rows, columns, initialValue: randomDelta(random));
    for (int i = 0; i < rows; i++) { //
      for (int j = 0; j < columns; j++) { // bColumn
        result[i][j] += source[i][j];
      }
    }
    return result;
  }

  void addRandomNoise(Array2d noised, int rows, int columns, Random random){
    var k = random.nextInt(rows*columns ~/ 10);
    for (int c = 0; c < k; c++) {
      var i = random.nextInt(rows) + 1;
      var j = random.nextInt(columns) + 1;
      var delta = randomDelta(random);

      noised[i][j] += delta;
    }
  }

  double randomDelta(Random random){
    var sign = random.nextBool() ? 1 : -1;
    var amount = random.nextDouble() * errorRate;
    var delta = sign * amount;
    return delta;
  }

}