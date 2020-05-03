import 'package:datafusion/models/temp_sensor.dart';
import 'package:datafusion/pages/page_temp_sensor.dart';
import 'package:datafusion/widgets/widget_app_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../res.dart';

class SensorCard extends StatefulWidget {
  final TempSensor sensor;

  const SensorCard({Key key, this.sensor}) : super(key: key);

  @override
  _SensorCardState createState() => _SensorCardState();
}

class _SensorCardState extends State<SensorCard> {
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
      title: Text(widget.sensor.name),
      subtitle: GestureDetector(
        onTap: () {
          setState(() {
            widget.sensor.kalmanFilter = !widget.sensor.kalmanFilter;
          });
        },
        child: Row(
          children: <Widget>[
            SvgPicture.asset(
                widget.sensor.kalmanFilter ? Res.filter_on : Res.filter_off),
            SizedBox(width: 4.0),
            Text('فیلتر کالمن'),
          ],
        ),
      ),
      corner: AnimatedBuilder(
          animation: widget.sensor.avgAccuracy,
          builder: (context, _) {
            return Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4),
              child: Text(
                (widget.sensor.avgAccuracy.value * 100).toStringAsPrecision(5) +
                    '%',
              ),
            );
          }),
      pageBuilder: (c) => TempSensorPage(sensor: widget.sensor),
    );
  }
}
