import 'package:datafusion/widgets/widget_sensors_add_bar.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class AddSensorAlert extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: simulation,
      builder: (context, _) {
        return simulation.sensors.isNotEmpty
            ? Container()
            : Container(
              margin: EdgeInsets.only(top: 8.0),
              child: Padding(
                  padding: const EdgeInsetsDirectional.only(start: 12.0),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: 'برای اضافه کردن سنسور دکمه',
                      style: Theme.of(context).textTheme.body1.copyWith(fontSize: 12.0),
                      children: [
                        WidgetSpan(
                          alignment: PlaceholderAlignment.middle,
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Container(
                              margin: EdgeInsets.all(8.0),
                              padding: EdgeInsets.all(2.0),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.black54,
                                ),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: AddSensorButton(),
                            ),
                          ),
                        ),
                        TextSpan(text: '  را بزنید.'),
                      ],
                    ),
                  ),
                ),
            );
      },
    );
  }
}
