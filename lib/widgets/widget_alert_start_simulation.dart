import 'package:datafusion/main.dart';
import 'package:datafusion/widgets/widget_simulation_controll.dart';
import 'package:flutter/material.dart';



class StartSimulationAlert extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(animation: simulation.simulationFirstStart, builder: (context, widget){
      return simulation.simulationFirstStart.value ? Container() : widget;
    },
      child: Padding(
        padding: const EdgeInsetsDirectional.only(start: 12.0),
        child: Row(
          children: <Widget>[
            Icon(Icons.error),
            SizedBox(width: 8),
            RichText(
              text: TextSpan(
                text: 'برای شروع شبیه سازی دکمه',
                style: Theme.of(context).textTheme.body1,
                children: [
                  WidgetSpan(
                    alignment: PlaceholderAlignment.middle,
                    child: SimulationControllButton(),
                  ),
                  TextSpan(text: ' را بزنید.'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
