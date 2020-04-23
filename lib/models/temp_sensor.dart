import 'package:datafusion/models/sensor.dart';
import 'package:scidart/numdart.dart';

abstract class TempSensor extends Sensor {
  Stream<Array2d> measureTemps();
}