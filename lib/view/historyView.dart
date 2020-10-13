import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

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
        showData(),
        Container(
            height: ScreenUtil().setHeight(600),
            child: SfCalendar(
              onTap: (CalendarTapDetails details) {
                print(details.date);
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

Widget showData() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [Text("data")],
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
