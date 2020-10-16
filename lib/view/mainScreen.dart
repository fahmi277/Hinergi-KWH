// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:hinergi_kwh/view/historyView.dart';
import 'package:hinergi_kwh/view/settingScreen.dart';
import 'homeScreen.dart';
import 'settingScreen.dart';
import 'package:hinergi_kwh/model/setting.dart';

class mainScreen extends StatefulWidget {
  @override
  _mainScreenState createState() => _mainScreenState();
}

class _mainScreenState extends State<mainScreen> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    homeScreen(),
    BuildCalenderView(),
    settingScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          // appBar: AppBar(
          //   title: Text("Hinergi"),
          // ),
          
          body: _children[_currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            onTap: onTabTapped,
            currentIndex:
                _currentIndex, // this will be set when a new tab is tapped
            items: [
              BottomNavigationBarItem(
                icon: new Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.calendar_today_sharp), label: 'Calendar'),
              BottomNavigationBarItem(
                icon: new Icon(Icons.settings),
                label: 'Setting',
              ),
            ],
          )),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
      print(_currentIndex);
    });
  }
}
