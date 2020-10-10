// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:hinergi_kwh/controller/totalCost.dart';
import 'package:hinergi_kwh/service/apiService.dart';
import 'package:hinergi_kwh/view/buttonDate.dart';
import 'package:hinergi_kwh/view/summaryView.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'package:loading/loading.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:intl/intl.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class homeScreen extends StatelessWidget {
  List selectData = ["", ""];

  Color _colorGauge = Colors.green;
  double maxKwh = 3; // budget satuan budget kwh
  double limitKwh = 3 * 0.7; //limit warning kwh

  double hargaKwh = 930;

  homeScreen();

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: Size(750, 1334), allowFontScaling: false);
    // return dateSelector(context);
    return StreamBuilder(
        stream: Stream.periodic(Duration(seconds: 5)).asyncMap(
            (i) => getThinkspeakData()), // i is null here (check periodic docs)
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var dataMasuk = snapshot.data["feeds"];

            List lengthDataToday = snapshot.data["feeds"];
            double startKwhToday = double.parse(dataMasuk[0]["field4"]);
            double lastKwhToday =
                double.parse(dataMasuk[lengthDataToday.length - 1]["field4"]);
            Map summaryData = dataMasuk[lengthDataToday.length - 1];

            if (startKwhToday > lastKwhToday) {
              startKwhToday = 0;
            }
            double kwhNow = lastKwhToday - startKwhToday;

            String tempTimeStartToday = dataMasuk[0]["created_at"]
                .toString()
                .split("+")[0]
                .replaceAll("T", " ");
            String tempTimeLastToday = dataMasuk[lengthDataToday.length - 1]
                    ["created_at"]
                .toString()
                .split("+")[0]
                .replaceAll("T", " ");

            DateTime timeStartToday =
                new DateFormat("yyyy-MM-dd hh:mm:ss").parse(tempTimeStartToday);
            DateTime timeLastToday =
                new DateFormat("yyyy-MM-dd hh:mm:ss").parse(tempTimeLastToday);

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
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Start : " +
                            timeStartToday.toString().split(".")[0] +
                            " KWH : " +
                            startKwhToday.toStringAsFixed(3)),
                      ],
                    ),
                    subtitle: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Last : " +
                            timeLastToday.toString().split(".")[0] +
                            " KWH : " +
                            lastKwhToday.toStringAsFixed(3)),
                      ],
                    ),
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
                              widget: Center(
                                child: Container(
                                  width: ScreenUtil().setWidth(300),
                                  height: ScreenUtil().setHeight(400),
                                  // color: Colors.blueGrey,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Card(
                                        child: ListTile(
                                          title: Center(
                                              child: Text(
                                                  kwhNow.toStringAsFixed(3) +
                                                      " KWH",
                                                  style: TextStyle(
                                                    color: Colors.blue,
                                                    fontSize:
                                                        ScreenUtil().setSp(42),
                                                  ))),
                                        ),
                                      ),
                                      Card(
                                        child: ListTile(
                                          title: Center(
                                              child: Text(
                                                  GetPrice()
                                                      .getPriceKwh(kwhNow),
                                                  style: TextStyle(
                                                    color: Colors.blue,
                                                    fontSize:
                                                        ScreenUtil().setSp(42),
                                                  ))),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              )
                              // widget: Text(
                              //   kwhNow.toStringAsFixed(3) + " KWH",
                              //   style: TextStyle(
                              //       fontWeight: FontWeight.bold, fontSize: 20),
                              // )

                              )
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

                summaryView(summaryData),
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
        );
  }
}
