import 'package:datafusion/models/temp_sensor.dart';
import 'package:datafusion/models/virtual_object_2d.dart';
import 'package:datafusion/models/virtual_temp_sensor.dart';
import 'package:datafusion/widgets/widget_sensor.dart';
import 'package:datafusion/widgets/widget_virtual_temp_display.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Data Fusion',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: MyHomePage(title: 'Data Fusion'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static var min = 273.0;
  static var max = 420.0;
  static var size = 5;
  var object = VirtualObject2D.generate(size, size, min, max);
  var sensor;

  @override
  void initState() {
    super.initState();
    startEmit();
    sensor = VirtualTempSensor2D(30, object);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Virtual Object 2D:',
              style: TextStyle(fontSize: 20),
            ),
          ),
          SizedBox(
            width: 200,
            height: 200,
            child: VirtualTempDisplay(
              temps: object.temps,
              min: min,
              max: max,
            ),
          ),
          Column(
            children: List.generate(1, (i){
              return TempSensorDisplay2D(
                sensor: sensor,
              );
            }),
          ),
        ],
      ),
    );
  }

  void startEmit() async {
    while (true) {
      await asyncEmit();
    }
  }

  Future<void> asyncEmit() async {
    object.emit();
    await Future.delayed(Duration(milliseconds: 100));
  }
}
