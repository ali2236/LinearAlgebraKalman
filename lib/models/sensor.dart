import 'package:flutter/cupertino.dart';

abstract class Sensor extends ChangeNotifier {
  bool enabled = true;
  final String name;
  final int id;
  static int _count = 1;
  Sensor(this.name) : id = _count++;
}