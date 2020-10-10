// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:hinergi_kwh/service/apiService.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'package:loading/loading.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:intl/intl.dart';

class mainScreen extends StatefulWidget {
  @override
  _mainScreenState createState() => _mainScreenState();
}

double maxKwh = 3; // budget satuan budget kwh
double limitKwh = 3 * 0.7; //limit warning kwh

Color _colorGauge = Colors.green;

class _mainScreenState extends State<mainScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
            title: Text("Hinergi"),
          ),
          body: StreamBuilder(
              stream: Stream.periodic(Duration(seconds: 5)).asyncMap((i) =>
                  getThinkspeakData()), // i is null here (check periodic docs)
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var dataMasuk = snapshot.data["feeds"];
                  List lengthDataToday = snapshot.data["feeds"];
                  double startKwhToday = double.parse(dataMasuk[0]["field4"]);
                  double lastKwhToday = double.parse(
                      dataMasuk[lengthDataToday.length - 1]["field4"]);

                  if (startKwhToday > lastKwhToday) {
                    startKwhToday = 0;
                  }
                  double kwhNow = lastKwhToday - startKwhToday;

                  String tempTimeStartToday = dataMasuk[0]["created_at"]
                      .toString()
                      .split("+")[0]
                      .replaceAll("T", " ");
                  String tempTimeLastToday =
                      dataMasuk[lengthDataToday.length - 1]["created_at"]
                          .toString()
                          .split("+")[0]
                          .replaceAll("T", " ");

                  DateTime timeStartToday =
                      new DateFormat("yyyy-MM-dd hh:mm:ss")
                          .parse(tempTimeStartToday);
                  DateTime timeLastToday = new DateFormat("yyyy-MM-dd hh:mm:ss")
                      .parse(tempTimeLastToday);

                  // change color
                  double warning = limitKwh * 0.5;
                  if (kwhNow >= warning) {
                    _colorGauge = Colors.red;
                  } else {
                    _colorGauge = Colors.green;
                  }

                  return Stack(
                    children: [
                      Card(
                        // child: Text(snapshot.data['created_at']),
                        child: ListTile(
                          title: Text("Start : " +
                              timeStartToday.toString().split(".")[0] +
                              " KWH : " +
                              startKwhToday.toStringAsFixed(1)),
                          subtitle: Text("Last : " +
                              timeLastToday.toString().split(".")[0] +
                              " KWH : " +
                              lastKwhToday.toStringAsFixed(1)),
                          // subtitle: Text(snapshot.data['created_at']),
                        ),
                      ),
                      // Card(
                      //   child: Text(snapshot.data['created_at']),
                      //   // child: ListTile(
                      //   //   title: Text(snapshot.data['created_at']),
                      //   //   // subtitle: Text(snapshot.data['created_at']),
                      //   // ),
                      // ),
                      Center(
                          child: SfRadialGauge(
                        axes: <RadialAxis>[
                          RadialAxis(
                              minimum: 0,
                              maximum: maxKwh,
                              startAngle: 120,
                              endAngle: -30,
                              annotations: <GaugeAnnotation>[
                                GaugeAnnotation(
                                    axisValue: 50,
                                    positionFactor: 0.1,
                                    widget: Text(
                                      kwhNow.toStringAsFixed(2) + " KWH",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ))
                              ],
                              pointers: <GaugePointer>[
                                MarkerPointer(
                                    value: limitKwh,
                                    color: Colors.red,
                                    markerType: MarkerType.text,
                                    text: "BUDGET"),
                                RangePointer(
                                    value: kwhNow,
                                    // double.parse(
                                    //     (energy.toStringAsFixed(0))),
                                    color: _colorGauge,
                                    dashArray: <double>[8, 2])
                              ])
                        ],
                      )),
                    ],
                  );
                  // return Text(
                  //   "Data : " + snapshot.data['field1'].toString(),
                  //   style: TextStyle(color: Colors.green),
                  // );
                } else {
                  return Container(
                    // color: Colors.lightBlue,
                    child: Center(
                      child: Loading(
                          indicator: BallPulseIndicator(),
                          size: 100.0,
                          color: Colors.lightBlue),
                    ),
                  );
                }
              }
              // builder should also handle the case when data is not fetched yet
              ),
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
                icon: new Icon(Icons.settings),
                label: 'Setting',
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person), label: 'Profile')
            ],
          )),
    );
  }

  int _currentIndex = 0;
  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
