import 'package:intl/intl.dart';

class GetTimedata {
  //  String timeStart =new DateFormat("yyyy-MM-dd").format(DateTime.now());

  Map timeData = {
    "startTime": new DateFormat("yyyy-MM-dd").format(DateTime.now()),
    "endTime": new DateFormat("yyyy-MM-dd")
        .format(new DateTime.now().add(new Duration(days: 1)))
  };

  String getCalenderSelector(String calender) {
    return calender;
  }
}
