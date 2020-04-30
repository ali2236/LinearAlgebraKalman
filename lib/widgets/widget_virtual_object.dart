import 'package:datafusion/models/virtual_object_2d.dart';
import 'package:datafusion/res.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'widget_app_card.dart';

class VirtualObjectCard extends StatefulWidget {

  final VirtualObject2D object2d;

  const VirtualObjectCard({Key key,@required this.object2d}) : super(key: key);

  @override
  _VirtualObjectCardState createState() => _VirtualObjectCardState();
}

class _VirtualObjectCardState extends State<VirtualObjectCard> {
  @override
  Widget build(BuildContext context) {
    var temps = widget.object2d.surfaceTemps;
    var rows = temps.m;
    var columns = temps.n;
    return AppCard(
      icon: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SvgPicture.asset(Res.cube),
      ),
      title: 'جسم مجازی',
      subtitle: Align(
        alignment: AlignmentDirectional.centerStart,
        child: Text('${rows}x$columns'),
      ),
    );
  }
}
