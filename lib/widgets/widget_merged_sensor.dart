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
    return AppCard(
      icon: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 16.0,
          horizontal: 24.0,
        ),
        child: SvgPicture.asset(Res.merge),
      ),
      title: 'سنسور ادغام',
      subtitle: Align(
        alignment: AlignmentDirectional.centerStart,
        child: Text('n سنسور ورودی'),
      ),
    );
  }
}
