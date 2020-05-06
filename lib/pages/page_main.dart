import 'package:datafusion/pages/page_about.dart';
import 'package:datafusion/pages/page_information.dart';
import 'package:datafusion/pages/page_report.dart';
import 'package:datafusion/pages/page_settings.dart';
import 'package:datafusion/widgets/widget_lak.dart';
import 'package:flutter/material.dart';

import 'page_home.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  var selectedIndex = 0;

  var pages = [
    HomePage(),
    ReportPage(),
    InformationPage(),
    SettingsPage(),
    AboutPage(),
  ];

  @override
  Widget build(BuildContext context) {
    var i = 0;
    var j = 0;
    return WillPopScope(
      onWillPop: () async {
        if (selectedIndex == 0) {
          return true;
        } else {
          setState(() {
            selectedIndex = 0;
          });
          return false;
        }
      },
      child: Scaffold(
        drawer: Drawer(
          child: MediaQuery.removePadding(
            removeTop: true,
            context: context,
            child: ListView(
              children: <Widget>[
                DrawerHeader(
                  decoration: BoxDecoration(
                    color: Theme.of(context).accentColor,
                  ),
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: LAK(
                      fontSize: 30,
                    ),
                  ),
                ),
                ListTile(
                  selected: selectedIndex == i++,
                  title: Text('صفحه اصلی'),
                  leading: Icon(Icons.home),
                  onTap: _goto(j++),
                ),
                ListTile(
                  selected: selectedIndex == i++,
                  title: Text('گزارش نهایی'),
                  leading: Icon(Icons.book),
                  onTap: _goto(j++),
                ),
                ListTile(
                  selected: selectedIndex == i++,
                  title: Text('دانشنامه'),
                  leading: Icon(Icons.library_books),
                  onTap: _goto(j++),
                ),
                ListTile(
                  selected: selectedIndex == i++,
                  title: Text('تنظیمات'),
                  leading: Icon(Icons.settings),
                  onTap: _goto(j++),
                ),
                ListTile(
                  selected: selectedIndex == i++,
                  title: Text('درباره'),
                  leading: Icon(Icons.info),
                  onTap: _goto(j++),
                ),
              ],
            ),
          ),
        ),
        body: pages[selectedIndex],
      ),
    );
  }

  VoidCallback _goto(int index) {
    return () {
      setState(() {
        selectedIndex = index;
      });
      Navigator.of(context).pop();
    };
  }
}
