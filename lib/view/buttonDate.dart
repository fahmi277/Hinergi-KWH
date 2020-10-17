import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRagePicker;
import 'package:hinergi_kwh/service/apiSharedPreferences.dart';
import 'package:intl/intl.dart';

Widget dateSelector(BuildContext context) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          MaterialButton(
              color: Colors.green,
              onPressed: () async {
                print("touch green");
                var dataGet =
                    await sharedPreferencesService().getSharedPrefered();
                print(dataGet);
              }),
          MaterialButton(
              color: Colors.deepOrangeAccent,
              onPressed: () async {
                print("object");
                print("touch date");

                try {
                  final List<DateTime> picked =
                      await DateRagePicker.showDatePicker(
                          context: context,
                          initialFirstDate: new DateTime.now(),
                          initialLastDate:
                              (new DateTime.now()).add(new Duration(days: 1)),
                          firstDate: new DateTime(2015),
                          lastDate: new DateTime(2021));
                  if (picked != null && picked.length == 2) {
                    String timeStart =
                        new DateFormat("yyyy-MM-dd").format(picked[0]);
                    String timeEnd =
                        new DateFormat("yyyy-MM-dd").format(picked[1]);
                    print(timeStart);
                    print(timeEnd);
                    List returnDate = [timeStart, timeEnd];
                    sharedPreferencesService().setSharedPreferences(returnDate);
                  }
                } catch (e) {
                  print(e.toString());
                }
              },
              child: new Text("Pick date range")),
        ],
      )
    ],
  );
}
