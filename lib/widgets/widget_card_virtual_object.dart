import 'package:datafusion/pages/page_virtual_object.dart';
import 'package:datafusion/res.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../main.dart';
import 'widget_app_card.dart';

class VirtualObjectCard extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var temps = simulation.object.surfaceTemps;
    var rows = temps.m;
    var columns = temps.n;
    return AppCard(
      icon: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SvgPicture.asset(Res.cube),
      ),
      title: Text('جسم مجازی'),
      subtitle: Align(
        alignment: AlignmentDirectional.centerStart,
        child: Text('${rows}x$columns'),
      ),
      pageBuilder: (c) => VirtualObjectPage(),
    );
  }
}
