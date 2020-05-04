import 'package:flutter/material.dart';

import '../main.dart';

class SimulationControllButton extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: simulation,
        builder: (context, _) {
          return IconButton(
              icon: Icon(
                simulation.started ? Icons.pause : Icons.play_arrow,
              ),
              onPressed: () {
                simulation.started = !simulation.started;
                simulation.simulationFirstStart.value = true;
              });
        });
  }
}
