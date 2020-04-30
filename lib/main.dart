import 'package:datafusion/models/temp_sensor.dart';
import 'package:datafusion/models/virtual_merge_sensor.dart';
import 'package:datafusion/models/virtual_object_2d.dart';
import 'package:datafusion/models/virtual_temp_sensor.dart';
import 'package:datafusion/pages/page_loading.dart';
import 'package:datafusion/pages/page_main.dart';
import 'package:datafusion/services/service_simulation.dart';
import 'package:datafusion/widgets/widget_temps_sensor_display.dart';
import 'package:datafusion/widgets/widget_virtual_temp_display.dart';
import 'package:fanoos_project/fanoos_project.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() => runApp(MyApp());

var serviceContainer = ServiceContainer({
  SimulationService(),
});

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Data Fusion',
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
      supportedLocales: [Locale('fa')],
      locale: Locale('fa'),
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Color(0xff07D1BD),
        accentColor: Color(0xff07D1BD),
        fontFamily: 'Vazir',
        appBarTheme: AppBarTheme(
          brightness: Brightness.dark,
          iconTheme: IconThemeData(color: Colors.white),
          textTheme: TextTheme(
            title: TextStyle(
                color: Colors.white,
                fontFamily: 'Vazir',
                fontSize: 21,
                fontWeight: FontWeight.w600),
          ),
        ),
        dividerTheme: DividerThemeData(
          thickness: 0.5,
          color: Colors.grey[900],
          indent: 12,
          endIndent: 12,
        ),
      ),
      home: Services(
        container: serviceContainer,
        child: LoadingPage(),
      ),
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
  List<VirtualTempSensor2D> sensors = [];
  List<GlobalKey<TempSensorDisplay2DState>> _keys;
  var _merger_key = GlobalKey<TempSensorDisplay2DState>();

  @override
  void initState() {
    super.initState();
    startEmit();
    var count = 5;
    sensors = List.generate(count, (i) {
      return VirtualTempSensor2D(30, object);
    });

    _keys = List.generate(count, (i) => GlobalKey<TempSensorDisplay2DState>());
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
          ButtonBar(
            children: <Widget>[
              RaisedButton(
                child: Text('turn All Kalman Filters On'),
                onPressed: () {
                  _keys.forEach((key) {
                    key.currentState.turnKalmanFilterOn();
                  });
                  _merger_key.currentState.turnKalmanFilterOn();
                },
              ),
            ],
          ),
          TempSensorDisplay2D(
            key: _merger_key,
            sensor: VirtualMergedTempSensor2D(sensors),
          ),
          Column(
            children: List.generate(sensors.length, (i) {
              return TempSensorDisplay2D(
                key: _keys[i],
                sensor: sensors[i],
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
