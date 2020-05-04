import 'package:datafusion/widgets/widget_dot.dart';
import 'package:flutter/material.dart';

final accuracyGradient = LinearGradient(colors: [
  Color(0xffF24D2B),
  Color(0xffE1E81A),
  Color(0xff54EB15),
]);

class AccuracyDot extends StatelessWidget {
  final ValueNotifier<double> accuracy;

  const AccuracyDot({Key key, @required this.accuracy}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: accuracy,
        builder: (context, _) {
          Color color;
          var offset = 0.75;
          if (accuracy.value > offset) {
            color = Color.lerp(
              accuracyGradient.colors[1],
              accuracyGradient.colors[2],
              (accuracy.value - offset) * 2,
            );
          } else {
            color = Color.lerp(
              accuracyGradient.colors[0],
              accuracyGradient.colors[1],
              accuracy.value * 2,
            );
          }
          return Dot(color);
        });
  }
}
