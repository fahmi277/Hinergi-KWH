// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:hinergi_kwh/view/historyView.dart';
import 'package:hinergi_kwh/view/scannerScreen.dart';
import 'package:hinergi_kwh/view/settingScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'homeScreen.dart';
import 'settingScreen.dart';
import 'package:hinergi_kwh/model/setting.dart';

class mainScreen extends StatefulWidget {
  @override
  _mainScreenState createState() => _mainScreenState();
}

class _mainScreenState extends State<mainScreen> {
  Setting seter = Setting();
  
  int _currentIndex = 0;
  final List<Widget> _children = [
    homeScreen(),
    BuildCalenderView(),
    scannerScreen(),
    settingScreen(),
  ];

  @override
  Widget build(BuildContext context) {

    return FutureBuilder<Setting>(
              future: seter.getSetting(),
              builder: (context, AsyncSnapshot<Setting> snapshot) {
                  String chId = "";
                  String apiKey = "";
                  if (snapshot.hasData) {
                    chId = snapshot.data.channelId;
                    apiKey = snapshot.data.apiKey;
                    if(chId.isEmpty || apiKey.isEmpty){
                      _currentIndex = 2;
                    }
                      
                  }
                 
                  return MaterialApp(
                      debugShowCheckedModeBanner: false,
                      home: Scaffold(
                          // appBar: AppBar(
                          //   title: Text("Hinergi"),
                          // ),

                          body: _children[_currentIndex],
                          bottomNavigationBar: BottomNavigationBar(
                            type: BottomNavigationBarType.fixed,
                            onTap: onTabTapped,
                            currentIndex:
                                _currentIndex, // this will be set when a new tab is tapped
                            items: [
                              BottomNavigationBarItem(
                                icon: new Icon(Icons.home),
                                label: 'Home',
                              ),
                              BottomNavigationBarItem(
                                icon: Icon(Icons.calendar_today_sharp), 
                                label: 'Calendar'
                              ),
                              BottomNavigationBarItem(
                                icon: new Icon(Icons.qr_code),
                                label: 'Scanner',
                              ),
                              BottomNavigationBarItem(
                                icon: new Icon(Icons.settings),
                                label: 'Setting',
                              ),
                            ],
                          )),
                    );
                }
              );
    
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
      print(_currentIndex);
    });
  }
}
