import 'dart:async';

import 'package:datafusion/kalman/kalman_filter.dart';
import 'package:flutter/cupertino.dart';
import 'package:linalg/linalg.dart';

class KalmanStreamTransformer extends StreamTransformerBase<Matrix, Matrix> {
  List<List<DiscreteKalmanFilter>> _filters;
  Stopwatch _stopwatch = Stopwatch();
  bool working;

  KalmanStreamTransformer([this.working = false]);

  @override
  Stream<Matrix> bind(Stream<Matrix> stream) async* {
    await for (var matrix in stream) {
      _stopwatch.stop();
      if(working) {
        try {
          if (_filters == null) {
            constructFilters(matrix);
            yield matrix;
          } else {
            updateFilters(matrix);
            var state = getState(matrix.m, matrix.n);
            yield state;
          }
        } catch (e) {
          print(e.toString());
        }
      } else {
        yield matrix;
      }
      _stopwatch.reset();
      _stopwatch.start();
    }
  }

  void constructFilters(Matrix source) {
    _filters = List.generate(source.m, (i) {
      return List.generate(source.n, (j) {
        var x0 = Matrix([
          [source[0][0]],
          [0.0],
        ]);

        var p0 = Matrix.eye(2);

        var filter = DiscreteKalmanFilter(x0, p0);

        return filter;
      });
    });
  }

  void updateFilters(Matrix update) {
    for (var i = 0; i < update.m; i++) {
      for (var j = 0; j < update.n; j++) {
        var filter = _filters[i][j];
        var dt = _stopwatch.elapsedMilliseconds.toDouble() / 1000;
        filter.predict(
          Matrix([
            [1, dt],
            [0, 1]
          ]),
          Matrix.eye(2),
          Matrix.eye(2),
        );

        filter.update(
          Matrix(
            [
              [update[i][j]],
              [0],
            ],
          ),
          Matrix.eye(2),
          Matrix.eye(2).map((d) => d * 1000),
        );
      }
    }
  }

  Matrix getState(int m, int n) {
    var state = Matrix.fill(m, n);
    for (var i = 0; i < m; i++) {
      for (var j = 0; j < n; j++) {
        state[i][j] = _filters[i][j].state[0][0];
      }
    }
    return state;
  }
}
