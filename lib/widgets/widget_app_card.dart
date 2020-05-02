import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

class AppCard extends StatelessWidget {
  final Widget icon;
  final Widget title;
  final Widget subtitle;
  final Widget corner;
  final WidgetBuilder pageBuilder;

  const AppCard({
    Key key,
    @required this.icon,
    @required this.title,
    @required this.subtitle,
    this.corner,
    this.pageBuilder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: OpenContainer(
        closedElevation: 4.0,
        transitionDuration: Duration(milliseconds: 500),
        closedShape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        closedBuilder: (context, action) {
          return Container(
            child: Row(
              children: <Widget>[
                icon,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    title,
                    SizedBox(height: 4.0),
                    DefaultTextStyle(
                      style: Theme.of(context).textTheme.caption,
                      child: subtitle,
                    ),
                  ],
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      SizedBox(
                        height: 48,
                      ),
                      corner ?? Container(),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
        openBuilder: pageBuilder == null
            ? (c, a) {
                return Container();
              }
            : (c, a) => pageBuilder(c),
      ),
    );
  }
}
