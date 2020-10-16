import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

Widget textDisplay(String text) {
  return Text(text,
      style: GoogleFonts.quantico(
          color: Colors.black, fontSize: ScreenUtil().setSp(40)));
}

Widget todayView(String kwhNow) {
  return Stack(
    children: [
      Padding(
        padding: EdgeInsets.only(bottom: ScreenUtil().setHeight(25)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                textDisplay("Penggunaan hari ini : " + kwhNow + " KWH")
                // Text(dateUpdate),
              ],
            ),
          ],
        ),
      ),
    ],
  );
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
      // Padding(
      //   padding: EdgeInsets.only(bottom: ScreenUtil().setHeight(30)),
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.end,
      //     children: [
      //       Row(
      //         mainAxisAlignment: MainAxisAlignment.center,
      //         children: [
      //           textDisplay("Penggunaan hari ini ")
      //           // Text(dateUpdate),
      //         ],
      //       ),
      //     ],
      //   ),
      // ),
      Padding(
          padding: EdgeInsets.only(top: ScreenUtil().setHeight(50)),
          child: Card(
            color: Colors.blue,
            child: ListTile(
              title: Text("HINERGI",
                  style: GoogleFonts.quantico(
                      color: Colors.white, fontSize: ScreenUtil().setSp(30))),
              trailing: Text("  Update\n$dateUpdate",
                  style: GoogleFonts.quantico(
                      color: Colors.white, fontSize: ScreenUtil().setSp(25))),
            ),
          )

          // Stack(
          //   // mainAxisAlignment: MainAxisAlignment.start,
          //   children: [
          //     Row(
          //       mainAxisAlignment: MainAxisAlignment.start,
          //       children: [
          //         Container(
          //           width: ScreenUtil().setWidth(widthCard + 50),
          //           height: ScreenUtil().setHeight(100),
          //           child: Column(
          //             mainAxisAlignment: MainAxisAlignment.center,
          //             children: [
          //               Text("HINERGI"),
          //               // Text(dateUpdate),
          //             ],
          //           ),
          //         ),
          //       ],
          //     ),
          //     Row(
          //       mainAxisAlignment: MainAxisAlignment.end,
          //       children: [
          //         Container(
          //           width: ScreenUtil().setWidth(widthCard + 50),
          //           height: ScreenUtil().setHeight(100),
          //           child: Column(
          //             mainAxisAlignment: MainAxisAlignment.center,
          //             children: [
          //               Text("Update"),
          //               Text(dateUpdate),
          //             ],
          //           ),
          //         ),
          //       ],
          //     ),
          //   ],
          // ),
          ),
    ],
  );
}
