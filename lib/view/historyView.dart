import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hinergi_kwh/controller/getTimeData.dart';
import 'package:hinergi_kwh/model/setting.dart';
import 'package:hinergi_kwh/service/apiService.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

// import 'package:fluttertoast/fluttertoast.dart';
DateTime selected = DateTime.now();
Map timeValue = {
  "startTime": selected.toString().split(" ")[0],
  "endTime": selected.add(Duration(days: 1)).toString().split(" ")[0]
};
StreamController<String> streamController = StreamController();

class BuildCalenderView extends StatefulWidget {
  @override
  _BuildCalenderViewState createState() => _BuildCalenderViewState();
}

class _BuildCalenderViewState extends State<BuildCalenderView> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: Size(750, 1334), allowFontScaling: false);

    return buildCalender(context);
  }
}

Widget buildCalender(BuildContext context) {
  return Scaffold(
    body: Stack(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Center(
              child: StreamBuilder(
                  stream: Stream.periodic(Duration(seconds: 1)).asyncMap((i) =>
                      getThinkspeakData(
                          timeValue)), // i is null here (check periodic docs)
                  builder: (context, snapshot) {
                    try {
                      if (snapshot.hasData) {
                        List dataList = snapshot.data["feeds"];
                        // print(dataList);
                        int panjangData = dataList.length;

                        var harian =
                            double.parse(dataList[panjangData - 1]['field4']) -
                                double.parse(dataList[0]['field4']);

                        double abonemen = harian * 950;

                        return Text(
                            "Penggunaan " +
                                timeValue['startTime'].toString() +
                                "\n" +
                                harian.toStringAsFixed(2) +
                                "KWH " +
                                abonemen.toStringAsFixed(0),
                            style: GoogleFonts.quantico(
                                color: Colors.blue,
                                fontSize: ScreenUtil().setSp(30)));
                      } else {
                        return Text("");
                      }
                    } catch (e) {
                      return Text("");
                    }
                  }),
            ),
          ],
        ),
        Container(
            height: ScreenUtil().setHeight(600),
            child: SfCalendar(
              onTap: (CalendarTapDetails details) async {
                // print(details.date);
                selected = details.date;

                // getSelectedData(details.date);
                timeValue = {
                  "startTime": details.date.toString().split(" ")[0],
                  "endTime": details.date
                      .add(Duration(days: 1))
                      .toString()
                      .split(" ")[0]
                };

                // var timeValue = await GetTimedata();
                // print(timeValue);
                // getData();
              },
              view: CalendarView.month,
              // dataSource: MeetingDataSource(_getDataSource()),
              initialSelectedDate: DateTime.now(),
              showNavigationArrow: true,
              monthViewSettings: MonthViewSettings(
                // numberOfWeeksInView: 2,
                appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
                // showAgenda: true,
              ),
            )),
      ],
    ),
  );
}

void getSelectedData(DateTime time) async {
  timeValue = {
    "startTime": time.toString().split(" ")[0],
    "endTime": time.add(Duration(days: 1)).toString().split(" ")[0]
  };

  var data = await getThinkspeakData(timeValue);
  List dataList = data["feeds"];
  int panjangData = dataList.length;
  if (dataList.length == 0) {
    Fluttertoast.showToast(
        msg: "Tidak ada Data",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  } else {
    var harian = double.parse(dataList[panjangData - 1]['field4']) -
        double.parse(dataList[0]['field4']);
    print(harian);
    Fluttertoast.showToast(
        msg: harian.toStringAsFixed(2) + " KWH",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0);
    // newMessage(1, 'You got a message!');
  }

  // print(timeValue);
}

void getData() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String startTime = prefs.getString("startTime");
  DateTime startDateTime = DateTime.parse(startTime);

  // Map timeValue = {
  //   "startTime": startDateTime,
  //   "endTime": DateTime.now().add(Duration(days: 1)).toString().split(".")[0]
  // };
}

Widget showData(DateTime time) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      // StreamBuilder(
      //     stream: Stream.periodic(Duration(seconds: 5)).asyncMap((event) => getThinkspeakData(){

      //     }),
      //     builder: (context, snapshot) {
      //       if (snapshot.hasData) {
      //         return Text(snapshot.data["feeds"]);
      //       } else {
      //         return Text("waiting data");
      //       }
      //     })
    ],
  );
}

// =============== add meeting are, irrelevant with this project =================//

List<Meeting> _getDataSource() {
  var meetings = <Meeting>[];
  final DateTime today = DateTime.now();
  final DateTime startTime = DateTime(today.year, today.month, today.day);
  final DateTime endTime =
      DateTime(today.year, today.month, today.day, 23, 59, 0);
  meetings
      .add(Meeting('1KWH', startTime, endTime, const Color(0xFF0F8644), false));
  return meetings;
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Meeting> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments[index].from;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments[index].to;
  }

  @override
  String getSubject(int index) {
    return appointments[index].eventName;
  }

  @override
  Color getColor(int index) {
    return appointments[index].background;
  }

  @override
  bool isAllDay(int index) {
    return appointments[index].isAllDay;
  }
}

class Meeting {
  Meeting(this.eventName, this.from, this.to, this.background, this.isAllDay);

  String eventName;
  DateTime from;
  DateTime to;
  Color background;
  bool isAllDay;
}

// =============== add meeting are, irrelevant with this project =================//
