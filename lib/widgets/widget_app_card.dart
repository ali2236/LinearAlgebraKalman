import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppCard extends StatelessWidget {
  final Widget icon;
  final Widget title;
  final Widget subtitle;
  final Widget corner;
  final Widget dot;
  final WidgetBuilder pageBuilder;
  final bool animated;

  const AppCard({
    Key key,
    @required this.icon,
    @required this.title,
    @required this.subtitle,
    this.corner,
    this.pageBuilder,
    this.animated = true,
    this.dot,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: OpenContainer(
        closedElevation: 4.0,
        tappable: false,
        transitionDuration: Duration(milliseconds: 500),
        closedShape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        closedBuilder: (context, action) {
          return Stack(
            children: <Widget>[
              Container(
                child: InkWell(
                  onTap: () {
                    if (animated) {
                      action();
                    } else {
                      if (pageBuilder != null) {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: pageBuilder));
                      }
                    }
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      icon,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: 15.0),
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
                            if (dot != null)
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: dot,
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              PositionedDirectional(
                end: 0,
                bottom: 0,
                child: corner != null ? corner : Container(),
              ),
            ],
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
