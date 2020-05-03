import 'package:datafusion/pages/page_about.dart';
import 'package:datafusion/pages/page_information.dart';
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
    InformationPage(),
    AboutPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: MediaQuery.removePadding(
          removeTop: true,
          context: context,
          child: ListView(
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.tealAccent[700],
                ),
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: LAK(
                    fontSize: 30,
                  ),
                ),
              ),
              ListTile(
                selected: selectedIndex == 0,
                title: Text('صفحه اصلی'),
                leading: Icon(Icons.home),
                onTap: _goto(0),
              ),
              ListTile(
                selected: selectedIndex == 1,
                title: Text('دانشنامه'),
                leading: Icon(Icons.library_books),
                onTap: _goto(1),
              ),
              ListTile(
                selected: selectedIndex == 2,
                title: Text('درباره'),
                leading: Icon(Icons.info),
                onTap: _goto(1),
              ),
            ],
          ),
        ),
      ),
      body: pages[selectedIndex],
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
