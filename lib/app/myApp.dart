import 'package:flutter/material.dart';
import 'package:hinergi_kwh/view/mainScreen.dart';
import 'package:hinergi_kwh/view/loadScreen.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SQFLITE DEMO',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // fontFamily: "Poppins",
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MainScreen1(),
    );
  }
}
