import 'package:datafusion/main.dart';
import 'package:datafusion/models/virtual_temp_sensor.dart';
import 'package:flutter/material.dart';

class AddSensorDialog extends StatefulWidget {
  @override
  _AddSensorDialogState createState() => _AddSensorDialogState();
}

class _AddSensorDialogState extends State<AddSensorDialog> {
  double errorRate = 30.0;

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text('سنسور جدید'),
      children: <Widget>[
        Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text('دقت سنسور'),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: DropdownButton<double>(
                    value: errorRate,
                    onChanged: (value) {
                      setState(() {
                        errorRate = value;
                      });
                    },
                    items: List<DropdownMenuItem<double>>.generate(100, (i) {
                      var value = i.toDouble();
                      return DropdownMenuItem<double>(
                        value: value,
                        child: Text(value.toString()),
                      );
                    }),
                  ),
                ),
              ),
            ),
          ],
        ),
        ButtonBar(
          alignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton.icon(
              color: Theme.of(context).accentColor,
              label: Text('اضافه کردن'),
              icon: Icon(Icons.add),
              textColor: Colors.white,
              onPressed: (){
                simulation.addSensor2D(errorRate);
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ],
    );
  }
}
