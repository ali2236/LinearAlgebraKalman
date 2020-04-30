import 'dart:async';

import 'package:datafusion/main.dart';
import 'package:fast_noise/fast_noise.dart';
import 'package:linalg/matrix.dart';

class VirtualObject2D {
  final double minTemp;
  final double maxTemp;
  final Matrix surfaceTemps;

  VirtualObject2D(this.minTemp, this.maxTemp, this.surfaceTemps) {
    _controller = StreamController.broadcast(onListen: () {
      emit();
    });
  }

  Stream<Matrix> get temps => _controller.stream;

  StreamController<Matrix> _controller;

  factory VirtualObject2D.generate(
      int width, int height, double minTemp, double maxTemp) {

    var arr2d = noise2(width + 1, height + 1,
        seed: DateTime.now().millisecondsSinceEpoch,
        noiseType: NoiseType.Perlin,
        octaves: 5,
        gain: 0.002,
        frequency: 0.07,
        cellularReturnType: CellularReturnType.Distance2Add);

    var temps = Matrix(arr2d
        .skip(1)
        .map((l) => (l
            .skip(1)
            .map((d) => ((d * (maxTemp - minTemp)).abs() + minTemp))
            .toList()))
        .toList());

    return VirtualObject2D(minTemp, maxTemp, temps);
  }

  void emit() => _controller.sink.add(surfaceTemps);

  var _emit = true;

  void startEmit() async {
    while (_emit) {
      await asyncEmit();
    }
  }

  void stopEmit() {
    _emit = false;
  }

  Future<void> asyncEmit() async {
    emit();
    await Future.delayed(
      Duration(milliseconds: simulation.emitRate),
    );
  }
}
