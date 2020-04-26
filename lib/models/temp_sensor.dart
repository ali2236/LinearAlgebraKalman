import 'package:datafusion/models/sensor.dart';
import 'package:linalg/linalg.dart';

abstract class TempSensor extends Sensor {
  TempSensor(String name) : super(name);
  double get accuracy;
  Stream<Matrix> measureTemps();
}