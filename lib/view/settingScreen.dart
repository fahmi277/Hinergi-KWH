import 'package:flutter/material.dart';
import 'package:hinergi_kwh/view/buttonDate.dart';

class settingScreen extends StatelessWidget {
  settingScreen();

  @override
  Widget build(BuildContext context) {
    return dateSelector(context);
    // return Container(MyTextFormField(
    //         hintText: 'Email',
    //         isEmail: true,
    //         validator: (String value) {
    //           if (!validator.isEmail(value)) {
    //             return 'Please enter a valid email';
    //           }
    //           return null;
    //         },
    //         onSaved: (String value) {
    //           model.email = value;
    //         },
    //       ),)
  }
}
