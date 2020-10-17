// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hinergi_kwh/controller/getTimeData.dart';
import 'package:hinergi_kwh/controller/totalCost.dart';
import 'package:hinergi_kwh/model/setting.dart';
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
  Setting seter = Setting();
  Setting setting = Setting();
  double hargaKwh = 930;

  homeScreen();

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: Size(750, 1334), allowFontScaling: false);
    // return dateSelector(context);
    return FutureBuilder<Setting>(
        future: seter.getSetting(),
        builder: (context, AsyncSnapshot<Setting> snapshot) {
          if (snapshot.hasData) {
            setting.tarifPerKwh = snapshot.data.tarifPerKwh;
            setting.budgetMax = snapshot.data.budgetMax;
            setting.kwhMax = snapshot.data.kwhMax;

            // add range date selector //
            Map timeValue = GetTimedata().timeValue(DateTime.now());
            return StreamBuilder(
                stream: Stream.periodic(Duration(seconds: 5)).asyncMap((i) =>
                    getThinkspeakData(
                        timeValue)), // i is null here (check periodic docs)
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var dataMasuk = snapshot.data["feeds"];

                    List lengthDataToday = snapshot.data["feeds"];
                    double startKwhToday = double.parse(dataMasuk[0]["field4"]);
                    double lastKwhToday = double.parse(
                        dataMasuk[lengthDataToday.length - 1]["field4"]);

                    double realtimeKwh = double.parse(
                        dataMasuk[lengthDataToday.length - 1]["field3"]);
                    realtimeKwh; // /= 1000;
                    Map summaryData = dataMasuk[lengthDataToday.length - 1];

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
                    DateTime timeLastToday =
                        new DateFormat("yyyy-MM-dd hh:mm:ss")
                            .parse(tempTimeLastToday);

                    // change color
                    // double warning = GetPrice().getKwhPerBudget(
                    //         setting.budgetMax, setting.tarifPerKwh) *
                    //     0.5;
                    // if (kwhNow >= warning) {
                    //   _colorGauge = Colors.red;
                    // } else {
                    //   _colorGauge = Colors.green;
                    // }

                    return Stack(
                      children: [
                        // Card(
                        //   child: Text(snapshot.data['created_at']),
                        //   // child: ListTile(
                        //   //   title: Text(snapshot.data['created_at']),
                        //   //   // subtitle: Text(snapshot.data['created_at']),
                        //   // ),
                        // ),
                        Padding(
                          padding:
                              EdgeInsets.only(top: ScreenUtil().setHeight(230)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Penggunaan Energi Saat Ini",
                                  style: GoogleFonts.quantico(
                                      color: Colors.blue,
                                      fontSize: ScreenUtil().setSp(32))),
                            ],
                          ),
                        ),
                        Center(
                            child: Container(
                          width: ScreenUtil().setWidth(800),
                          height: ScreenUtil().setHeight(700),
                          child: SfRadialGauge(
                            // title:
                            //     GaugeTitle(text: 'Penggunaan Energi Saat Ini'),
                            axes: <RadialAxis>[
                              RadialAxis(
                                  axisLineStyle: AxisLineStyle(
                                    thickness: 0.2,
                                    thicknessUnit: GaugeSizeUnit.factor,
                                  ),
                                  minimum: 0,
                                  maximum: 1300,
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
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Center(
                                                    child: Text(
                                                        realtimeKwh
                                                                .toStringAsFixed(
                                                                    1) +
                                                            " W",
                                                        style: GoogleFonts
                                                            .quantico(
                                                                color:
                                                                    Colors.blue,
                                                                fontSize:
                                                                    ScreenUtil()
                                                                        .setSp(
                                                                            42)))),
                                                // Center(
                                                //     child: Text(
                                                //         GetPrice().getPriceKwh(
                                                //             kwhNow,
                                                //             setting
                                                //                 .tarifPerKwh),
                                                //         style: GoogleFonts
                                                //             .quantico(
                                                //                 color:
                                                //                     Colors.blue,
                                                //                 fontSize:
                                                //                     ScreenUtil()
                                                //                         .setSp(
                                                //                             42)))),
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
                                        value: 1300 * 0.75,
                                        color: Colors.red,
                                        markerType: MarkerType.invertedTriangle,
                                        markerWidth: 20,
                                        markerHeight: 20,
                                        markerOffset: -20,
                                        text: "BUDGET"),
                                    RangePointer(
                                        value: realtimeKwh,
                                        width: 35,
                                        // double.parse(
                                        //     (energy.toStringAsFixed(0))),
                                        color: _colorGauge,
                                        dashArray: <double>[8, 2])
                                  ])
                            ],
                          ),
                        )),

                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  bottom: ScreenUtil().setHeight(30)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  textDisplay("Penggunaan hari ini\n" +
                                      kwhNow.toStringAsFixed(2) +
                                      " KWH  " +
                                      GetPrice().getPriceKwh(
                                          kwhNow, setting.tarifPerKwh)),
                                  // Text(dateUpdate),
                                ],
                              ),
                            ),
                          ],
                        ),

                        summaryView(summaryData),
                      ],
                    );
                    // return Text(
                    //   "Data : " + snapshot.data['field1'].toString(),
                    //   style: TextStyle(color: Colors.green),
                    // );
                  } else {
                    try {
                      return Container(
                        // color: Colors.lightBlue,
                        child: Center(
                          child: Loading(
                              indicator: BallPulseIndicator(),
                              size: 100.0,
                              color: Colors.lightBlue),
                        ),
                      );
                    } catch (e) {}
                    // return Text("datax");

                  }
                }
                // builder should also handle the case when data is not fetched yet
                );
          } else {
            return Text("data");
            // return Container(
            //   // color: Colors.lightBlue,
            //   child: Center(
            //     child: Loading(
            //         indicator: BallPulseIndicator(),
            //         size: 100.0,
            //         color: Colors.lightBlue),
            //   ),
            // );
          }
        });
  }
}
