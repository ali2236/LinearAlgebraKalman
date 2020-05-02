
import 'package:datafusion/kalman/kalman_stream_transformer.dart';
import 'package:datafusion/models/virtual_temp_sensor.dart';
import 'package:linalg/matrix.dart';
import 'package:rxdart/rxdart.dart';

class VirtualMergedTempSensor2D extends VirtualTempSensor2D{

  final List<VirtualTempSensor2D> sensors;

  VirtualMergedTempSensor2D(this.sensors) : super(double.nan, sensors?.first?.object, 'سنسور ادغام'){

  }


  @override
  Stream<Matrix> measureTemps(){
    return Rx.merge(sensors.map((s) => s.measureTemps()));
  }

}