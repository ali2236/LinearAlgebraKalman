import 'package:datafusion/models/temp_sensor.dart';
import 'package:datafusion/pages/page_temp_sensor.dart';
import 'package:datafusion/widgets/widget_app_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../res.dart';

class SensorCard extends StatelessWidget {
  final TempSensor sensor;

  const SensorCard({Key key, this.sensor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppCard(
      icon: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 22.0,
          horizontal: 11.0,
        ),
        child: SvgPicture.asset(Res.sensor),
      ),
      title: ' سنسور دو بعدی ' + '(${sensor.id})',
      subtitle: Row(
        // TODO: toggle filter
        children: <Widget>[
          SvgPicture.asset(Res.filter_off),
          Text('فیلتر کالمن'),
        ],
      ),
      pagebuilder: (c) => TempSensorPage(sensor: sensor),
    );
  }
}
