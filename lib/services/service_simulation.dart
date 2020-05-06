import 'package:datafusion/models/virtual_merge_sensor.dart';
import 'package:datafusion/models/virtual_object_2d.dart';
import 'package:datafusion/models/virtual_temp_sensor.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SimulationService extends ChangeNotifier {
  SharedPreferences _sharedPreferences;
  VirtualObject2D _object;

  List<VirtualTempSensor2D> sensors;
  VirtualMergedTempSensor2D mergedTempSensor;

  var emitRate = 100;
  var _started = false;
  var _kalmanVariance = 100.0;

  ValueNotifier<bool> simulationFirstStart = ValueNotifier(false);

  VirtualObject2D get object => _object;
  double get minTemp => _sharedPreferences.getDouble('min_temp') ?? 273.0;
  double get maxTemp => _sharedPreferences.getDouble('max_temp') ?? 400.0;
  int get rows => _sharedPreferences.getInt('rows') ?? 5;
  int get columns =>  _sharedPreferences.getInt('columns') ?? 5;
  bool get started => _started;
  double get kalmanVariance => _kalmanVariance;

  set minTemp (value) => _set('min_temp', value);
  set maxTemp (value) => _set('max_temp', value);
  set rows (value) => _set('rows', value);
  set columns (value) => _set('columns', value);
  set kalmanVariance (value) {
    _kalmanVariance = value;
    _sharedPreferences.setDouble('kaman_variance', value);
    notifyListeners();
  }
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
      _sharedPreferences ??= await SharedPreferences.getInstance();

    try {

      _kalmanVariance = _sharedPreferences.getDouble('kaman_variance') ?? _kalmanVariance;

      _object = VirtualObject2D.generate(columns, rows, minTemp, maxTemp);

      sensors = [];

      mergedTempSensor = VirtualMergedTempSensor2D(sensors, object);

      notifyListeners();
    } catch (e){
      print(e);
      await _sharedPreferences.clear();
      return run();
    }
  }

  void addSensor2D(double errorRate){
    sensors.add(VirtualTempSensor2D(errorRate, object));
    mergedTempSensor.notifyListeners();
    notifyListeners();
  }

  void removeSensor2D(VirtualTempSensor2D sensor) {
    sensors.remove(sensor);
    mergedTempSensor.notifyListeners();
    notifyListeners();
  }
}