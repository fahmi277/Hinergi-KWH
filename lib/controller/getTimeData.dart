import 'package:intl/intl.dart';

class GetTimedata {
  //  String timeStart =new DateFormat("yyyy-MM-dd").format(DateTime.now());

  Map timeValue(DateTime time) {
    Map timeData = {
      "startTime": new DateFormat("yyyy-MM-dd").format(time),
      "endTime": new DateFormat("yyyy-MM-dd")
          .format(time.add(new Duration(days: 1)))
    };

    print(timeData);
    return timeData;
  }

  String getCalenderSelector(String calender) {
    return calender;
  }
}
