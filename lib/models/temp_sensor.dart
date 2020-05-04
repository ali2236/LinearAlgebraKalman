import 'package:datafusion/models/sensor.dart';
import 'package:linalg/linalg.dart';

import 'updated_value.dart';

abstract class TempSensor extends Sensor {
  TempSensor(String name, this.errorRate) : super(name);

  Stream<Matrix> temps;
  bool get kalmanFilter;
  set kalmanFilter(bool value);
  int updates = 0;
  final double errorRate;

  UpdatedValue<double> accuracy = UpdatedValue(1.0);
  UpdatedValue<double> avgAccuracy = UpdatedValue(1.0);
}