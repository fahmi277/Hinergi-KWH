import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget summaryView(Map summaryData) {
  double voltage = double.parse(summaryData["field1"]);
  double current = double.parse(summaryData["field2"]);
  double power = double.parse(summaryData["field3"]);
  double pf = double.parse(summaryData["field5"]);

  String dateUpdate = summaryData['created_at'];
  dateUpdate = dateUpdate.split("T")[1].split("+")[0];
  // print(dateUpdate);

  double widthCard = 150;
  return Column(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            width: ScreenUtil().setWidth(widthCard + 180),
            height: ScreenUtil().setHeight(100),
            child: Card(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Update"),
                Text(dateUpdate),
              ],
            )),
          ),
          // Container(
          //   width: ScreenUtil().setWidth(widthCard + 180),
          //   height: ScreenUtil().setHeight(100),
          //   child: Card(
          //       child: Column(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: [
          //       Text("End"),
          //       Text(current.toStringAsFixed(2)),
          //     ],
          //   )),
          // ),
        ],
      ),
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
