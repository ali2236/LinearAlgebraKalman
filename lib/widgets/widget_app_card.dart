import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

class AppCard extends StatelessWidget {
  final Widget icon;
  final String title;
  final Widget subtitle;
  final Widget corner;

  const AppCard({
    Key key,
    @required this.icon,
    @required this.title,
    @required this.subtitle,
    this.corner,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: OpenContainer(
        closedElevation: 4.0,
        transitionDuration: Duration(milliseconds: 500),
        closedShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        closedBuilder: (context, action) {
          return Container(
            child: Row(
              children: <Widget>[
                icon,
                Column(
                  children: <Widget>[
                    Text(title),
                    subtitle,
                  ],
                ),
                Column(
                  children: <Widget>[
                    corner ?? Container(),
                  ],
                ),
              ],
            ),
          );
        },
        openBuilder: (c, a) {
          return Container();
        },
      ),
    );
  }
}
