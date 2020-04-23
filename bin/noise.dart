import 'dart:math';

import 'package:fast_noise/fast_noise.dart';
import 'package:scidart/numdart.dart';

void main() {
  var size = 3;
  var arr2d = noise2(
      size,
      size,
    seed: DateTime.now().millisecondsSinceEpoch,
    noiseType: NoiseType.Perlin,
      octaves: 5,
      gain: 0.002,
      frequency: 0.07,
      cellularReturnType: CellularReturnType.Distance2Add
  );

  double min_temp = 273;
  double max_temp = 400;

  var arr = Array2d(
      arr2d.map((l) => Array(l.map((d) => ((d * (max_temp - min_temp)).abs() + min_temp).floorToDouble()).toList())).toList());
  print(arr);
}
