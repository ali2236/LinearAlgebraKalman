import 'dart:math';

import 'package:datafusion/models/virtual_temp_sensor.dart';
import 'package:datafusion/widgets/widget_virtual_temp_display.dart';
import 'package:flutter/material.dart';
import 'package:linalg/linalg.dart';

class TempSensorDisplay2D extends StatefulWidget {
  final VirtualTempSensor2D sensor;

  const TempSensorDisplay2D({Key key, this.sensor}) : super(key: key);

  @override
  _TempSensorDisplay2DState createState() => _TempSensorDisplay2DState();
}

class _TempSensorDisplay2DState extends State<TempSensorDisplay2D> {
  Stream<Matrix> stream;
  bool kalmanFilter = false;
  double avgAccuracy = 0.0;
  int updates = 0;

  @override
  void initState() {
    super.initState();
    stream = widget.sensor.measureTemps().asBroadcastStream();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350,
      child: Column(
        children: <Widget>[
          Table(
            border: TableBorder.all(
              color: Colors.black54,
            ),
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: [
              TableRow(
                children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Name',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ),
                  Center(
                    child: Text('Accuracy',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  Center(
                    child: Text('Avg Accuracy',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  Center(
                    child: Text('Kalman Filter',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
              TableRow(
                children: [
                  Center(
                      child: Text(
                    widget.sensor.name + " (${widget.sensor.id})",
                    textAlign: TextAlign.center,
                  )),
                  StreamBuilder<Matrix>(
                      stream: stream,
                      builder: (context, snapshot) {
                        return Center(
                            child: Text(
                                '${(widget.sensor.accuracy * 100).toStringAsFixed(3)}%'));
                      }),
                  StreamBuilder<Matrix>(
                      stream: stream,
                      builder: (context, snapshot) {
                        avgAccuracy += widget.sensor.accuracy;
                        return Center(
                            child: Text(
                                '${((avgAccuracy / ++updates) * 100).toStringAsFixed(3)}%'));
                      }),
                  Column(
                    children: <Widget>[
                      Switch(
                          value: kalmanFilter,
                          onChanged: (value) {
                            setState(() {
                              kalmanFilter = value;
                            });
                          }),
                    ],
                  ),
                ],
              ),
            ],
          ),
          Expanded(
            child: VirtualTempDisplay(
              temps: stream,
              min: widget.sensor.object.minTemp,
              max: widget.sensor.object.maxTemp,
            ),
          ),
        ],
      ),
    );
  }
}
