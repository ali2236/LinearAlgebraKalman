
import 'package:datafusion/widgets/widget_app_card.dart';
import 'package:datafusion/widgets/widget_merged_sensor.dart';
import 'package:datafusion/widgets/widget_sensors_add_bar.dart';
import 'package:datafusion/widgets/widget_virtual_object.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
          IconButton(
              icon: Icon(Icons.play_arrow),
              onPressed: () {
                // TODO: Start Simulation
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
          VirtualObjectCard(
            object2d: context.simulation.object,
          ),
          Divider(),
          MergedSensorCard(),
          SizedBox(height: 2),
          SensorsAddBar(),
          Divider(height: 1),
          AppCard(
            icon: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 22.0,
                horizontal: 11.0,
              ),
              child: SvgPicture.asset(Res.sensor),
            ),
            title: 'سنسور دو بعدی',
            subtitle: Align(
              alignment: AlignmentDirectional.centerStart,
              child: Row(
                children: <Widget>[
                  SvgPicture.asset(Res.filter_off),
                  Text('فیلتر کالمن'),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
