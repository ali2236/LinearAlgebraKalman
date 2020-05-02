import 'package:datafusion/pages/page_loading.dart';
import 'package:datafusion/widgets/widget_card_sensor.dart';
import 'package:datafusion/widgets/widget_icon_drawer.dart';
import 'package:datafusion/widgets/widget_card_merged_sensor.dart';
import 'package:datafusion/widgets/widget_sensors_add_bar.dart';
import 'package:datafusion/widgets/widget_card_virtual_object.dart';
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
    return AnimatedBuilder(
      animation: simulation,
      builder: (context, _){
        return Scaffold(
          appBar: AppBar(
            leading: DrawerIcon(context),
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
                          simulation.started = !simulation.started;
                        });
                  }),
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
      },
    );
  }
}
