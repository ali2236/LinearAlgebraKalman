import 'package:datafusion/application/data_fuser.dart';
import 'package:datafusion/kalman/kalman_filter.dart';
import 'package:linalg/matrix.dart';

class KalmanDataFuser implements DataFuser{

  @override
  Matrix fuse(Matrix a, Matrix b) {
    var filter = DiscreteKalmanFilter(a, b);
    return null;
  }



}