import 'package:fast_noise/fast_noise.dart';
import 'package:scidart/numdart.dart';

class VirtualObject2D {
  final int width;
  final int height;
  final Array2d surfaceTemps;
  VirtualObject2D(this.width, this.height, this.surfaceTemps);

  Stream<Array2d> get temps => null;

  factory VirtualObject2D.generate(int width, int height, double minTemp, double maxTemp){
    var arr2d = noise2(width, height,
        seed: DateTime.now().millisecondsSinceEpoch,
        noiseType: NoiseType.Perlin,
        octaves: 5,
        gain: 0.002,
        frequency: 0.07,
        cellularReturnType: CellularReturnType.Distance2Add);

    var temps = Array2d(arr2d
        .map((l) => Array(l
        .map((d) =>
    ((d * (maxTemp - minTemp)).abs() + minTemp))
        .toList()))
        .toList());

    return VirtualObject2D(width, height, temps);
  }
}