
import 'package:animations/animations.dart';
import 'package:datafusion/application/accuracy_checker.dart';
import 'package:datafusion/kalman/kalman_stream_transformer.dart';
import 'package:datafusion/models/virtual_temp_sensor.dart';
import 'package:datafusion/widgets/widget_virtual_temp_display.dart';
import 'package:flutter/material.dart';
import 'package:linalg/linalg.dart';

class TempSensorDisplay2D extends StatefulWidget {
  final VirtualTempSensor2D sensor;

  const TempSensorDisplay2D({Key key, this.sensor}) : super(key: key);

  @override
  TempSensorDisplay2DState createState() => TempSensorDisplay2DState();
}

class TempSensorDisplay2DState extends State<TempSensorDisplay2D> {
  Stream<Matrix> stream;
  Stream<Matrix> _kalman_stream;
  Stream<Matrix> _ragular_stream;
  bool kalmanFilter = false;
  double avgAccuracy = 0.0;
  int updates = 0;

  @override
  void initState() {
    super.initState();
    _ragular_stream = widget.sensor.measureTemps().asBroadcastStream();
    _kalman_stream = _ragular_stream
        .transform(KalmanStreamTransformer()).asBroadcastStream();
    stream = _ragular_stream;
  }

  void turnKalmanFilterOn() {
    if (kalmanFilter) return;
    stream = _kalman_stream;
    setState(() {
      kalmanFilter = true;
    });
  }

  void turnKalmanFilterOff() {
    if (!kalmanFilter) return;
    stream = _ragular_stream;
    setState(() {
      kalmanFilter = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: OpenContainer(
        closedBuilder: (context, action){
          return Card(
            child: Table(
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
                        child: Text(
                          'Name',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Center(
                      child: Text(
                        'Accuracy',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Center(
                      child: Text(
                        'Avg Accuracy',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Center(
                      child: Text(
                        'Kalman Filter',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
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
                    StreamBuilder<double>(
                        stream: stream.transform(
                            AccuracyStreamTransform(widget.sensor.object)),
                        builder: (context, snapshot) {
                          return Center(
                            child: Text(
                                '${((snapshot?.data ?? 1.0) * 100).toStringAsFixed(3)}%'),
                          );
                        }),
                    StreamBuilder<double>(
                        stream: stream.transform(
                          AccuracyStreamTransform(widget.sensor.object),
                        ),
                        builder: (context, snapshot) {
                          avgAccuracy += snapshot?.data ?? 1.0;
                          return Center(
                            child: Text(
                                '${((avgAccuracy / ++updates) * 100).toStringAsFixed(3)}%'),
                          );
                        }),
                    Column(
                      children: <Widget>[
                        Switch(
                            value: kalmanFilter,
                            onChanged: (value) {
                              if (value)
                                turnKalmanFilterOn();
                              else
                                turnKalmanFilterOff();
                            }),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          );
        },
        openBuilder: (context, action){
          return Scaffold(
            appBar: AppBar(
              title: Text(widget.sensor.name),
            ),
            body: Column(
              children: <Widget>[
                SizedBox(
                  height: 250,
                  width: 400,
                  child: VirtualTempDisplay(
                    temps: stream,
                    min: widget.sensor.object.minTemp,
                    max: widget.sensor.object.maxTemp,
                  ),
                ),
                Column(
                  children: <Widget>[
                    ListTile(
                      title: Text('Name'),
                      subtitle: Text(widget.sensor.name),
                    ),
                    ListTile(
                      title: Text('Accuracy'),
                      subtitle: StreamBuilder<double>(
                          stream: stream.transform(
                              AccuracyStreamTransform(widget.sensor.object)),
                          builder: (context, snapshot) {
                            return Text(
                                '${((snapshot?.data ?? 1.0) * 100).toStringAsFixed(3)}%');
                          }),
                    ),
                    ListTile(
                      title: Text('Avg Accuracy'),
                      subtitle: StreamBuilder<double>(
                          stream: stream.transform(
                            AccuracyStreamTransform(widget.sensor.object),
                          ),
                          builder: (context, snapshot) {
                            avgAccuracy += snapshot?.data ?? 1.0;
                            return Text(
                                '${((avgAccuracy / ++updates) * 100).toStringAsFixed(3)}%');
                          }),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
