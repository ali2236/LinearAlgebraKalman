import 'package:datafusion/models/sensor.dart';
import 'package:linalg/linalg.dart';

abstract class TempSensor extends Sensor {
  Stream<Matrix> measureTemps();
}