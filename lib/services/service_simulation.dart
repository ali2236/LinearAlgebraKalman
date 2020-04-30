import 'package:datafusion/models/virtual_object_2d.dart';
import 'package:datafusion/models/virtual_temp_sensor.dart';
import 'package:datafusion/widgets/widget_temps_sensor_display.dart';
import 'package:fanoos_project/fanoos_project.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

extension Simulation on BuildContext {
  SimulationService get simulation => Services.get<SimulationService>(this);
}


class SimulationService extends AppService {
  SharedPreferences _sharedPreferences;
  VirtualObject2D _object;

  List<VirtualTempSensor2D> sensors;

  List<GlobalKey<TempSensorDisplay2DState>> _keys;

  var mergerKey = GlobalKey<TempSensorDisplay2DState>();

  VirtualObject2D get object => _object;
  double get min => _object.minTemp;
  double get max => _object.maxTemp;
  int get objectRows => _object.surfaceTemps.m;
  int get objectColumns => _object.surfaceTemps.n;

  set min (value) => _sharedPreferences.setDouble('min_temp', value);
  set max (value) => _sharedPreferences.setDouble('max_temp', value);
  set objectRows (value) => _sharedPreferences.setInt('rows', value);
  set objectColumns (value) => _sharedPreferences.setInt('columns', value);

  @override
  Future<void> run(ServiceContainer services) async{
    _sharedPreferences = await SharedPreferences.getInstance();

    var minTemp = _sharedPreferences.getDouble('min_temp');
    var maxTemp = _sharedPreferences.getDouble('max_temp');
    var rows = _sharedPreferences.getInt('rows');
    var columns = _sharedPreferences.getInt('columns');

    _object = VirtualObject2D.generate(columns, rows, minTemp, maxTemp);

    sensors = List.generate(1, (i) {
      return VirtualTempSensor2D(20, object);
    });

  }

}