import 'package:flutter/material.dart';
import 'package:hinergi_kwh/controller/BLoC.dart';
import 'package:hinergi_kwh/controller/getTimeData.dart';
import 'package:hinergi_kwh/service/apiService.dart';

class jsonView extends StatefulWidget {
  @override
  _jsonViewState createState() => _jsonViewState();
}

class _jsonViewState extends State<jsonView> {
  Map timeValue =
      GetTimedata().timeValue(DateTime.now().add(Duration(days: -7)));
  // GetTimedata().timeValue(DateTime.now());
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("View Class"),
        ),
        body: Center(
          child: StreamBuilder(
              stream: Stream.periodic(Duration(seconds: 5)).asyncMap((i) =>
                  getThinkspeakData(
                      timeValue)), // i is null here (check periodic docs)
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data != null) {
                    return Text("data ada");
                  }
                } else {
                  return Text("data tidak ada");
                }
              }),
        ),
      ),
    );
  }
}
