import 'package:datafusion/widgets/widget_dialog_add_sensor.dart';
import 'package:flutter/material.dart';

class SensorsAddBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Stack(
        children: <Widget>[
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: Text(
              'سنسور ها',
              style: TextStyle(
                color: Theme.of(context).accentColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Align(
            alignment: AlignmentDirectional.centerEnd,
            child: AddSensorButton(),
          )
        ],
      ),
    );
  }
}

class AddSensorButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (c) => AddSensorDialog(),
        );
      },
      child: SizedBox(
        width: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Text('سنسور جدید', style: TextStyle(fontSize: 13.0)),
            Icon(Icons.add),
          ],
        ),
      ),
    );
  }
}
