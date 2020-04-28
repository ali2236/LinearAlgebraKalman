import 'dart:async';

import 'package:datafusion/kalman/kalman_filter.dart';
import 'package:linalg/linalg.dart';

class KalmanStreamTransformer extends StreamTransformerBase<Matrix, Matrix>{

  final double maxTemp;
  DiscreteKalmanFilter filter;

  KalmanStreamTransformer(this.maxTemp);

  @override
  Stream<Matrix> bind(Stream<Matrix> stream) async*{
    await for(var matrix in stream){
      try {
        if (filter == null) {
          filter = DiscreteKalmanFilter(matrix,
              Matrix.fill(matrix.m, matrix.n, maxTemp));
          yield matrix;
        } else {
          filter.predictState(matrix);
          var state = filter.state;
          yield state;
        }
      } catch(e){
        print(e.toString());
      }
    }
  }



}