import 'package:datafusion/models/sensor.dart';
import 'package:flutter/cupertino.dart';
import 'package:linalg/linalg.dart';

abstract class TempSensor extends Sensor {
  TempSensor(String name, this.errorRate) : super(name);

  Stream<Matrix> temps;
  bool get kalmanFilter;
  set kalmanFilter(bool value);
  int updates = 0;
  final double errorRate;

  ValueNotifier<double> accuracy = ValueNotifier(1.0);
  ValueNotifier<double> avgAccuracy = ValueNotifier(1.0);


  Stream<Matrix> measureTemps();
}