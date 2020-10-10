import 'package:shared_preferences/shared_preferences.dart';

class sharedPreferencesService {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<List> setSharedPreferences(List dateRange) async {
    print("data from date picker : " + dateRange.toString());
    SharedPreferences prefs = await _prefs;

    List statusReport = [false, false];

    prefs.setString("startDate", dateRange[0].toString()).then((bool success) {
      statusReport[0] = success;
    });
    prefs.setString("endDate", dateRange[1].toString()).then((bool success) {
      statusReport[1] = success;
    });

    // if (statusReport.isEmpty) {
    //   return [false, false];
    // }
    return statusReport;
  }

  Future<List> getSharedPrefered() async {
    SharedPreferences prefs = await _prefs;
    List statusReport = ["", ""];

    try {
      String startDate = prefs.getString("startDate");
      String endDate = prefs.getString("endDate");

      statusReport[0] = startDate;
      statusReport[1] = endDate;
    } catch (e) {
      print("empty");
      // statusReport.add("");
      // statusReport.add("");
    }
    return statusReport;
  }
}
