import 'package:datafusion/main.dart';
import 'package:datafusion/models/virtual_merge_sensor.dart';
import 'package:datafusion/pages/page_merge_sensor.dart';
import 'package:datafusion/widgets/widget_accuracy_dot.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../res.dart';
import 'widget_app_card.dart';

class MergedSensorCard extends StatefulWidget {
  @override
  _MergedSensorCardState createState() => _MergedSensorCardState();
}

class _MergedSensorCardState extends State<MergedSensorCard> {

  @override
  Widget build(BuildContext context) {
    var sensor = simulation.mergedTempSensor;
    return AppCard(
      icon: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 16.0,
          horizontal: 24.0,
        ),
        child: SvgPicture.asset(Res.merge, color: Colors.grey[800]),
      ),
      title: Row(
        children: <Widget>[
          Text(sensor.name),
          SizedBox(width: 4),
          Text(
            '(' + '${sensor.sensors.length}' + ' ورودی' + ')',
            style: Theme.of(context).textTheme.caption,
          ),
        ],
      ),
      subtitle: GestureDetector(
        onTap: () {
          setState(() {
            sensor.kalmanFilter = !sensor.kalmanFilter;
          });
        },
        child: Row(
          children: <Widget>[
            SvgPicture.asset(
                sensor.kalmanFilter ? Res.filter_on : Res.filter_off),
            SizedBox(width: 4.0),
            Text('فیلتر کالمن'),
          ],
        ),
      ),
      corner: AnimatedBuilder(
          animation: sensor.avgAccuracy,
          builder: (context, _) {
            return Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4),
              child:
                  Text((sensor.avgAccuracy.value * 100).toStringAsPrecision(5) + '%'),
            );
          }),
      dot: AccuracyDot(accuracy: sensor.avgAccuracy),
      pageBuilder: (c) => MergedSensorPage(),
    );
  }
}
