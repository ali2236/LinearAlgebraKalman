import 'package:datafusion/widgets/widget_form_input_double.dart';
import 'package:datafusion/widgets/widget_icon_drawer.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: simulation,
        builder: (context, _) {
          return Scaffold(
            appBar: AppBar(
              leading: DrawerIcon(context),
              title: Text('تنظیمات'),
              titleSpacing: 4.0,
            ),
            body: ListView(
              children: <Widget>[
                SizedBox(height: 8.0),
                Form(
                  child: ListTile(
                    title: Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Row(
                        children: <Widget>[
                          Text('واریانس فیلتر کالمن'),
                          SizedBox(width: 4),
                          Text(
                            '('
                            'مقدار فعلی برابراست با: '
                            '${simulation.kalmanVariance.toString()}'
                            ')',
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ],
                      ),
                    ),
                    isThreeLine: true,
                    subtitle: DoubleFormInput(
                      label: 'واریانس',
                      initialValue: simulation.kalmanVariance,
                      onChange: (v) => simulation.kalmanVariance = v,
                      validator: (v) {
                        if (v < 0) return 'واریانس نباید منفی باشد';
                        if (v == 0) return 'واریانس نباید 0 باشد';
                        return null;
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.only(end: 8, top: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsetsDirectional.only(
                            start: 8, end: 8, top: 4),
                        child: Icon(
                          Icons.info,
                          color: Colors.black87,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          'واریانس انتخاب شده باید متناسب با مقدار نویز سنسور باشد. اگر سنسورهای شما نویز کم دارند، مقدار کمی انتخاب کنید و اگر سنسورها، نویز زیادی دارند، مقدار بالایی انتخاب کنید ولی در هر صورت حتی اگر مقدار مناسبی انتخاب نکردید، الگوریتم کالمن فیلتر به اندازه‌ای هوشمند است که با هر مقداری کار کند.',
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}
