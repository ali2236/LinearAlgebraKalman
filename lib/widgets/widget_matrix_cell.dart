import 'package:flutter/material.dart';

class MatrixCell extends StatelessWidget {

  final double value;
  final double min;
  final double max;
  final LinearGradient gradient;

  const MatrixCell({Key key, this.value, this.min, this.max, this.gradient}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var percent = (value - min) / (max - min);
    return Container(
      color: gradient.colors.first,
      child: Center(
        child: Text(value.toString()),
      ),
    );
  }
}
