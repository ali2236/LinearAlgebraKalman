import 'package:datafusion/main.dart';
import 'package:datafusion/widgets/widget_matrix_builder.dart';
import 'package:datafusion/widgets/widget_matrix_cell.dart';
import 'package:flutter/material.dart';
import 'package:linalg/linalg.dart';

class VirtualTempDisplay extends StatelessWidget {

  final Stream<Matrix> temps;
  final Matrix temp;
  final double min, max;

  const VirtualTempDisplay({Key key, this.temps, this.min, this.max, this.temp}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var accent = Theme.of(context).accentColor;
    return StreamBuilder<Matrix>(
        stream: temps,
        builder: (context, snapshot) {
          var data = snapshot?.data ?? temp;
          if(data==null){
            simulation.object.asyncEmit();
            data = Matrix.eye(1);
          }
          return body(accent, data);
        }
    );
  }

  Widget body(Color accent, Matrix data){
    return MatrixBuilder(
      matrix: data,
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
}
