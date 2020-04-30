import 'package:datafusion/models/virtual_object_2d.dart';
import 'package:datafusion/models/virtual_temp_sensor.dart';
import 'package:datafusion/widgets/widget_temps_sensor_display.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SimulationService extends ChangeNotifier {
  SharedPreferences _sharedPreferences;
  VirtualObject2D _object;

  List<VirtualTempSensor2D> sensors;

  List<GlobalKey<TempSensorDisplay2DState>> _keys;

  var mergerKey = GlobalKey<TempSensorDisplay2DState>();
  var emitRate = 100;
  var _started = false;


  VirtualObject2D get object => _object;
  double get minTemp => _sharedPreferences.getDouble('min_temp') ?? 273.0;
  double get maxTemp => _sharedPreferences.getDouble('max_temp') ?? 400.0;
  int get rows => _sharedPreferences.getInt('rows') ?? 5;
  int get columns =>  _sharedPreferences.getInt('columns') ?? 5;
  bool get started => _started;

  set minTemp (value) => _set('min_temp', value);
  set maxTemp (value) => _set('max_temp', value);
  set rows (value) => _set('rows', value);
  set columns (value) => _set('columns', value);
  set started (bool value) {
    _started = value;
    if(value){
      object.startEmit();
    } else {
      object.stopEmit();
    }
    notifyListeners();
  }

  void _set(String key, value) async{
    if(value is int){
      await _sharedPreferences.setInt(key, value);
    } else if(value is double){
      await _sharedPreferences.setDouble(key, value);
    }
    notifyListeners();
  }

  @override
  Future<void> run() async {
      _sharedPreferences = await SharedPreferences.getInstance();

    try {
      _object = VirtualObject2D.generate(columns, rows, minTemp, maxTemp);

      sensors = List.generate(1, (i) {
        return VirtualTempSensor2D(30, object);
      });

      notifyListeners();
    } catch (e){
      await _sharedPreferences.clear();
      return run();
    }
  }
}