import 'package:flutter/material.dart';

class Dot extends StatelessWidget {

  final Color color;

  const Dot(this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 8,
      height: 8,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(1000),
        color: color,
      ),
    );
  }
}
