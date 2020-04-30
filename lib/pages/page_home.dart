import 'package:datafusion/widgets/widget_app_card.dart';
import 'package:datafusion/widgets/widget_card_sensor.dart';
import 'package:datafusion/widgets/widget_merged_sensor.dart';
import 'package:datafusion/widgets/widget_sensors_add_bar.dart';
import 'package:datafusion/widgets/widget_card_virtual_object.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../main.dart';
import '../services/service_simulation.dart';

import '../res.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            }),
        title: Text('تلفیق داده'),
        titleSpacing: 4.0,
        actions: <Widget>[
          AnimatedBuilder(
              animation: simulation,
              builder: (context, _) {
                return IconButton(
                    icon: Icon(
                        simulation.started ? Icons.pause : Icons.play_arrow),
                    onPressed: () {
                      // TODO: Start Simulation
                      simulation.started = !simulation.started;
                    });
              }),
          IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                // TODO: ReStart
              }),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.only(top: 6),
        children: <Widget>[
          VirtualObjectCard(),
          Divider(),
          MergedSensorCard(),
          SizedBox(height: 2),
          SensorsAddBar(),
          Divider(height: 1),
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
