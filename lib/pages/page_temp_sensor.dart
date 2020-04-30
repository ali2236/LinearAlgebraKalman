import 'package:datafusion/application/accuracy_checker.dart';
import 'package:datafusion/models/temp_sensor.dart';
import 'package:datafusion/widgets/widget_accuracy_chart.dart';
import 'package:datafusion/widgets/widget_virtual_temp_display.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class TempSensorPage extends StatefulWidget {
  final TempSensor sensor;

  const TempSensorPage({Key key, this.sensor}) : super(key: key);

  @override
  _TempSensorPageState createState() => _TempSensorPageState();
}

class _TempSensorPageState extends State<TempSensorPage> {
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: simulation,
        builder: (context, _) {
          return Scaffold(
            appBar: AppBar(
              title: Hero(
                tag: 'جسم مجازی',
                child: Text('جسم مجازی'),
              ),
              titleSpacing: 4.0,
            ),
            body: ListView(
              children: <Widget>[
                SizedBox(
                  height: 250,
                  child: VirtualTempDisplay(
                    temps: widget.sensor.temps,
                    min: simulation.object.minTemp,
                    max: simulation.object.maxTemp,
                  ),
                ),
                ListTile(
                  title: Text('فیلتر کالمن'),
                  subtitle: Text('افزایش دقت با تلفیق داده'),
                  trailing: Switch(
                    value: widget.sensor.kalmanFilter,
                    onChanged: (value) => widget.sensor.kalmanFilter = value,
                  ),
                ),
                ListTile(
                  title: Text('میزان نویز سنسور'),
                  subtitle: Text('داده ها تا حداکثر این مقدار نویز دارند'),
                  trailing: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(widget.sensor.errorRate.toString()),
                  ),
                ),
                ListTile(
                  title: Text('میزان دقت سنسور'),
                  subtitle: Text('دقت سنسور در این لحظه'),
                  trailing: AnimatedBuilder(
                      animation: widget.sensor.accuracy,
                      builder: (context, _) {
                        var acc = widget.sensor.accuracy.value;
                        return Text('${(acc * 100).toStringAsFixed(2)}%');
                      }),
                ),
                ListTile(
                  title: Text('متوسط دقت سنسور'),
                  subtitle: Text('دقت سنسور از ابتدا'),
                  trailing: AnimatedBuilder(
                      animation: widget.sensor.avgAccuracy,
                      builder: (context, _) {
                        var acc = widget.sensor.avgAccuracy.value;
                        return Text('${(acc * 100).toStringAsFixed(2)}%');
                      }),
                ),
                ListTile(
                  title: Text('نمودار دقت'),
                ),
                AccuracyChart(
                  accuracy: widget.sensor.accuracy,
                ),
              ],
            ),
          );
        });
  }
}
