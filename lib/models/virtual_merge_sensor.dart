
import 'dart:async';

import 'package:datafusion/models/virtual_object_2d.dart';
import 'package:datafusion/models/virtual_temp_sensor.dart';
import 'package:linalg/matrix.dart';
import 'package:rxdart/rxdart.dart';

class VirtualMergedTempSensor2D extends VirtualTempSensor2D{

  final List<VirtualTempSensor2D> sensors;

  VirtualMergedTempSensor2D(this.sensors, VirtualObject2D object) : super(double.nan, object, 'سنسور ادغام'){
    addListener((){
      updateTempsStream();
      checkAccuracy();
    });
  }

  @override
  Stream<Matrix> measureTemps(){
    if(sensors.isEmpty) return StreamController<Matrix>.broadcast().stream;
    return Rx.merge(sensors.map((s) => s.temps));
  }

  @override
  void calculateAccuracy(Matrix output) {
    return super.calculateAccuracy(output);
  }

}