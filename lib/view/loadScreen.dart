import 'package:flutter/material.dart';
import 'package:hinergi_kwh/database/dbHelpers.dart';
import 'package:hinergi_kwh/database/queries/dailyQuery.dart';
import 'package:hinergi_kwh/model/dailyModel.dart';

class MainScreen1 extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen1> {
  final DbHelper _helper = new DbHelper();
  List data = ["16102020", "1.65"];

  @override
  void initState() {
    super.initState();
    // _helper.openDB();
    // _helper.insert(DailyQuery.TABLE_NAME, data);
    // _helper.getData(DailyQuery.TABLE_NAME).then((value) {
    //   value.forEach((element) {
    //     Daily daily = Daily.fromJson(element);

    //     print(daily.toJson());
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SQFLITE Demo"),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            RaisedButton(onPressed: () {
              // Map data = {"id":"20202020"};
              // var data = Daily().toJson(data);

              _helper.insert(DailyQuery.TABLE_NAME, {"NAME": "1.56"});
              // _helper.getData(DailyQuery.TABLE_NAME).then((value) {
              //   //value.forEach((element) {
              //   // Daily daily = Daily.fromJson(element);

              //   print(value.toString());
              //   // });
              // });
            }),
            RaisedButton(
                child: Text("get"),
                onPressed: () {
                  // _helper.insert(DailyQuery.TABLE_NAME, {"16102020": "1.56"});
                  _helper.getData(DailyQuery.TABLE_NAME).then((value) {
                    //value.forEach((element) {
                    // Daily daily = Daily.fromJson(element);

                    print(value.toString());
                    // });
                  });
                }),
          ],
        ),
      ),
    );
  }
}
