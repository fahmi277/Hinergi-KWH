import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget summaryView(Map summaryData) {
  double voltage = double.parse(summaryData["field1"]);
  double current = double.parse(summaryData["field2"]);
  double power = double.parse(summaryData["field3"]);
  double pf = double.parse(summaryData["field5"]);
  double widthCard = 150;
  final europeanCountries = [
    'Albania',
    'Andorra',
    'Armenia',
    'Austria',
    'Azerbaijan',
    'Belarus',
    'Belgium',
    'Bosnia and Herzegovina',
    'Bulgaria',
    'Croatia',
    'Cyprus',
    'Czech Republic',
    'Denmark',
    'Estonia',
    'Finland',
    'France',
    'Georgia',
    'Germany',
    'Greece',
    'Hungary',
    'Iceland',
    'Ireland',
    'Italy',
    'Kazakhstan',
    'Kosovo',
    'Latvia',
    'Liechtenstein',
    'Lithuania',
    'Luxembourg',
    'Macedonia',
    'Malta',
    'Moldova',
    'Monaco',
    'Montenegro',
    'Netherlands',
    'Norway',
    'Poland',
    'Portugal',
    'Romania',
    'Russia',
    'San Marino',
    'Serbia',
    'Slovakia',
    'Slovenia',
    'Spain',
    'Sweden',
    'Switzerland',
    'Turkey',
    'Ukraine',
    'United Kingdom',
    'Vatican City'
  ];
  final List<int> numbers = [1, 2, 3, 5, 8, 13, 21, 34, 55];
  // return Container(
  //   padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
  //   height: 200,
  //   child: ListView.builder(
  //       scrollDirection: Axis.horizontal,
  //       itemCount: numbers.length,
  //       itemBuilder: (context, index) {
  //         return Container(
  //           width: MediaQuery.of(context).size.width * 0.6,
  //           child: Card(
  //             color: Colors.blue,
  //             child: Container(
  //               child: Center(
  //                   child: Text(
  //                 numbers[index].toString(),
  //                 style: TextStyle(color: Colors.white, fontSize: 36.0),
  //               )),
  //             ),
  //           ),
  //         );
  //       }),
  // );
  return Column(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            width: ScreenUtil().setWidth(widthCard),
            height: ScreenUtil().setHeight(100),
            child: Card(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Voltage"),
                Text(voltage.toStringAsFixed(0)),
              ],
            )),
          ),
          Container(
            width: ScreenUtil().setWidth(widthCard),
            height: ScreenUtil().setHeight(100),
            child: Card(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Current"),
                Text(current.toStringAsFixed(2)),
              ],
            )),
          ),
          Container(
            width: ScreenUtil().setWidth(widthCard),
            height: ScreenUtil().setHeight(100),
            child: Card(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Power"),
                Text(power.toStringAsFixed(2)),
              ],
            )),
          ),
          Container(
            width: ScreenUtil().setWidth(widthCard),
            height: ScreenUtil().setHeight(100),
            child: Card(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("PF"),
                Text(pf.toStringAsFixed(2)),
              ],
            )),
          ),
        ],
      )
    ],
  );
}
