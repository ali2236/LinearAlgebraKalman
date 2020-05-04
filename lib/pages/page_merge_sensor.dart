import 'package:datafusion/models/virtual_merge_sensor.dart';
import 'package:datafusion/widgets/widget_accuracy_chart.dart';
import 'package:datafusion/widgets/widget_simulation_controll.dart';
import 'package:datafusion/widgets/widget_virtual_temp_display.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class MergedSensorPage extends StatefulWidget {
  @override
  _MergedSensorPageState createState() => _MergedSensorPageState();
}

class _MergedSensorPageState extends State<MergedSensorPage> {

  VirtualMergedTempSensor2D sensor;
  @override
  void initState() {
    super.initState();
    sensor = simulation.mergedTempSensor;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: simulation,
        builder: (context, _) {
          return Scaffold(
            appBar: AppBar(
              title: Hero(
                tag: sensor.name,
                child: Text(sensor.name),
              ),
              titleSpacing: 4.0,
              actions: <Widget>[
                SimulationControllButton(),
              ],
            ),
            body: ListView(
              children: <Widget>[
                SizedBox(
                  height: 250,
                  child: VirtualTempDisplay(
                    temps: sensor.temps,
                    min: simulation.object.minTemp,
                    max: simulation.object.maxTemp,
                  ),
                ),
                ListTile(
                  title: Text('فیلتر کالمن'),
                  subtitle: Text('افزایش دقت با تلفیق داده'),
                  trailing: Switch(
                    value: sensor.kalmanFilter,
                    onChanged: (value) {
                      setState(() {
                        sensor.kalmanFilter = value;
                      });
                    },
                  ),
                ),
                ListTile(
                  title: Text('تعداد سنسور های ورودی'),
                  subtitle: Text('داده های این سنسور از سنسورهای دیگر می آیند'),
                  trailing: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(sensor.sensors.length.toString()),
                  ),
                ),
                ListTile(
                  title: Text('میزان دقت سنسور'),
                  subtitle: Text('دقت سنسور در این لحظه'),
                  trailing: AnimatedBuilder(
                      animation: sensor.accuracy,
                      builder: (context, _) {
                        var acc = sensor.accuracy.value;
                        return Text('${(acc * 100).toStringAsFixed(2)}%');
                      }),
                ),
                ListTile(
                  title: Text('متوسط دقت سنسور'),
                  subtitle: Text('دقت سنسور از ابتدا'),
                  trailing: AnimatedBuilder(
                      animation: sensor.avgAccuracy,
                      builder: (context, _) {
                        var acc = sensor.avgAccuracy.value;
                        return Text('${(acc * 100).toStringAsFixed(2)}%');
                      }),
                ),
                ListTile(
                  title: Text('نمودار دقت'),
                ),
                AccuracyChart(
                  accuracy: sensor.accuracy,
                ),
              ],
            ),
          );
        });
  }
}
