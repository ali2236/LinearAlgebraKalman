import 'package:flutter/material.dart';

class LAK extends StatelessWidget {

  final double fontSize;

  const LAK({Key key, this.fontSize = 40}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Text(
        'LINEAR\nALGEBRA\nKALMAN',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: fontSize,
          color: Colors.white,
        ),
      ),
    );
  }
}
