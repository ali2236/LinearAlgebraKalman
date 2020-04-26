abstract class Sensor {
  bool enabled = true;
  final String name;
  final int id;
  static int _count = 1;
  Sensor(this.name) : id = _count++;
}