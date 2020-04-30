import 'package:datafusion/widgets/widget_matrix_builder.dart';
import 'package:datafusion/widgets/widget_matrix_cell.dart';
import 'package:flutter/material.dart';
import 'package:linalg/linalg.dart';

class VirtualTempDisplay extends StatelessWidget {

  final Stream<Matrix> temps;
  final double min, max;

  const VirtualTempDisplay({Key key, this.temps, this.min, this.max}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var accent = Theme.of(context).accentColor;
    return StreamBuilder<Matrix>(
        stream: temps,
        builder: (context, snapshot) {
          return MatrixBuilder(
            matrix: snapshot?.data ?? Matrix.eye(1),
            cellBuilder: (value) =>
                MatrixCell(
                  value: value,
                  min: min,
                  max: max,
                  gradient: LinearGradient(
                    begin: AlignmentDirectional.centerStart,
                    end: AlignmentDirectional.centerEnd,
                    colors: [
                      accent,
                      Colors.indigo[500],
                      Colors.red[500],
                      Colors.white
                    ],
                  ),
                ),
          );
        }
    );
  }
}
