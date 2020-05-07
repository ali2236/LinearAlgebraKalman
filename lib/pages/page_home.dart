import 'package:datafusion/pages/page_loading.dart';
import 'package:datafusion/widgets/widget_alert_add_sensor.dart';
import 'package:datafusion/widgets/widget_alert_start_simulation.dart';
import 'package:datafusion/widgets/widget_card_sensor.dart';
import 'package:datafusion/widgets/widget_icon_drawer.dart';
import 'package:datafusion/widgets/widget_card_merged_sensor.dart';
import 'package:datafusion/widgets/widget_sensors_add_bar.dart';
import 'package:datafusion/widgets/widget_card_virtual_object.dart';
import 'package:datafusion/widgets/widget_simulation_controll.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../main.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: DrawerIcon(context),
        title: Text('تلفیق داده'),
        titleSpacing: 4.0,
        actions: <Widget>[
          SimulationControllButton(),
          IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (c) => LoadingPage(),
                ));
              }),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.only(top: 6),
        children: <Widget>[
          StartSimulationAlert(),
          VirtualObjectCard(),
          Divider(),
          MergedSensorCard(),
          SizedBox(height: 2),
          SensorsAddBar(),
          Divider(height: 1),
          AddSensorAlert(),
          Column(
            children: simulation.sensors.map((sensor) {
              return SensorCard(sensor: sensor);
            }).toList(),
          ),
        ],
      ),
    );
  }
}
