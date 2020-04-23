import 'package:scidart/numdart.dart';

class VirtualObject2D {
  final int width;
  final int height;
  final Array2d surfaceTemps;
  VirtualObject2D(this.width, this.height, this.surfaceTemps);

  Stream<Array2d> get temps => null;
}