import 'package:flutter/material.dart';
import 'package:hinergi_kwh/model/setting.dart';
import 'package:hinergi_kwh/view/MyTextFormField.dart';
import 'package:hinergi_kwh/view/buttonDate.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:validators/validators.dart' as validator;

class settingScreen extends StatelessWidget {
  Setting setting = Setting();
  settingScreen();

  setSetting(Setting set) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('channelId', set.channelId);
    prefs.setString('apiKey', set.apiKey);
    prefs.setInt('tarif', set.tarifPerKwh);
    prefs.setInt('butget', set.budgetMax);
  }

  setChannelId(String data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('channelId', data);
  }

  setApiKey(String data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('apiKey', data);
  }

  setTarif(int data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('tarif', data);
  }

  setButget(int data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('butget', data);
  }

  getSetting() async {
    Setting set = Setting();
    SharedPreferences prefs = await SharedPreferences.getInstance();

    set.channelId = prefs.getString('channelId') ?? 0;
    set.apiKey = prefs.getString('apiKey') ?? 0;
    set.tarifPerKwh = prefs.getInt('tarif') ?? 0;
    set.budgetMax = prefs.getInt('budget') ?? 0;
    return set;
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(children: <Widget>[
          MyTextFormField(
            hintText: 'Channel Id',
            isEmail: false,
            validator: (String value) {
              if (validator.isNull(value)) {
                return 'Please enter a valid number';
              }
              return null;
            },
            onSaved: (String value) {
              setting.channelId = value;
            },
          ),
          MyTextFormField(
            hintText: 'ApiKey',
            isEmail: false,
            validator: (String value) {
              if (validator.isNull(value)) {
                return 'Please enter a valid number';
              }
              return null;
            },
            onSaved: (String value) {
              setting.apiKey = value;
            },
          ),
          MyTextFormField(
            hintText: 'Tarif per KWh',
            isEmail: false,
            validator: (String value) {
              if (!validator.isNumeric(value)) {
                return 'Please enter a valid number';
              }
              return null;
            },
            onSaved: (String value) {
              setting.tarifPerKwh = int.parse(value);
            },
          ),
          MyTextFormField(
            hintText: 'Budget Max',
            isEmail: false,
            validator: (String value) {
              if (!validator.isNumeric(value)) {
                return 'Please enter a valid number';
              }
              return null;
            },
            onSaved: (String value) {
              setting.budgetMax = int.parse(value);
            },
          ),
          RaisedButton(
            color: Colors.blueAccent,
            onPressed: () {
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();

                setSetting(setting);
                // Navigator.push(
                // context,
                // MaterialPageRoute(
                //     builder: (context) => Result(model: this.setting))

                // );
              }
            },
            child: Text(
              'Save',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          )
        ]));
  }

  // @override
  // Widget build(BuildContext context) {
  //   return dateSelector(context);
  //   // return Container(MyTextFormField(
  //   //         hintText: 'Email',
  //   //         isEmail: true,
  //   //         validator: (String value) {
  //   //           if (!validator.isEmail(value)) {
  //   //             return 'Please enter a valid email';
  //   //           }
  //   //           return null;
  //   //         },
  //   //         onSaved: (String value) {
  //   //           model.email = value;
  //   //         },
  //   //       ),)
  // }
}
