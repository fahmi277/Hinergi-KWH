import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

Widget textDisplay(String text) {
  return Text(text,
      style: GoogleFonts.quantico(
          color: Colors.black, fontSize: ScreenUtil().setSp(40)));
}

Widget summaryView(Map summaryData) {
  double voltage = double.parse(summaryData["field1"]);
  double current = double.parse(summaryData["field2"]);
  double power = double.parse(summaryData["field3"]);
  double pf = double.parse(summaryData["field5"]);

  String dateUpdate = summaryData['created_at'];
  dateUpdate = dateUpdate.split("T")[1].split("+")[0];
  // print(dateUpdate);

  double widthCard = 150;
  return Stack(
    children: [
      Padding(
        padding: EdgeInsets.only(bottom: ScreenUtil().setHeight(30)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                textDisplay("Penggunaan hari ini ")
                // Text(dateUpdate),
              ],
            ),
          ],
        ),
      ),
      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: ScreenUtil().setWidth(widthCard + 50),
                height: ScreenUtil().setHeight(100),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Update"),
                    Text(dateUpdate),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
