import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

Widget buildCalender() {
  return Scaffold(
    body: Container(
        child: SfCalendar(
      view: CalendarView.month,
      dataSource: MeetingDataSource(_getDataSource()),
      initialSelectedDate: DateTime(2020, 10, 11),
      monthViewSettings: MonthViewSettings(
        appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
        showAgenda: true,
      ),
    )),
  );
}

List<Meeting> _getDataSource() {
  var meetings = <Meeting>[];
  final DateTime today = DateTime.now();
  final DateTime startTime =
      DateTime(today.year, today.month, today.day);
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
