import 'package:flutter/material.dart';
import 'package:linalg/linalg.dart';

class MatrixBuilder extends StatelessWidget {
  final Matrix matrix;
  final Widget Function(double value) cellBuilder;

  const MatrixBuilder({Key key, this.matrix, this.cellBuilder})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(matrix.m, (i) {
        return Expanded(
          child: Row(
            children: List.generate(matrix.n, (j) {
              return Expanded(child: cellBuilder(matrix[i][j]));
            }),
          ),
        );
      }),
    );
  }
}
