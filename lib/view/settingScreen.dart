import 'package:flutter/material.dart';
import 'package:hinergi_kwh/model/setting.dart';
import 'package:hinergi_kwh/view/MyTextFormField.dart';
import 'package:hinergi_kwh/view/buttonDate.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:validators/validators.dart' as validator;

class settingScreen extends StatelessWidget {
  Setting setting = Setting();
  Setting seter = Setting();
  settingScreen();
  
  final _formKey = GlobalKey<FormState>();

  //  @override
  // void initState() {
  //   super.s;
  //   seter = Setting();
  // }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Setting>(
              future: seter.getSetting(),
              builder: (context, AsyncSnapshot<Setting> snapshot) {
                  if (snapshot.hasData) {
                    return SingleChildScrollView(
                            child : Form(
                              key: _formKey,
                              child: Column(
                                children: <Widget>[
                                  MyTextFormField(
                                    hintText: 'Masukkan Channel Id anda',
                                    labelText: 'Channel Id',
                                    value: snapshot.data.channelId,
                                    isEmail: false,
                                    icon: Icon(Icons.verified_user),
                                    validator: (String value) {
                                      if (validator.isNull(value)) {
                                        return 'Please enter a channel id';
                                      }
                                      return null;
                                    },
                                    onSaved: (String value) {
                                      setting.channelId = value;
                                    },
                                  ),
                                  MyTextFormField(
                                    hintText: 'Masukkan API Key anda',
                                    labelText: 'API Key',
                                    value: snapshot.data.apiKey,
                                    isEmail: false,
                                    icon: Icon(Icons.vpn_key_sharp),
                                    validator: (String value) {
                                      if (validator.isNull(value)) {
                                        return 'Please enter a api key';
                                      }
                                      return null;
                                    },
                                    onSaved: (String value) {
                                      setting.apiKey = value;
                                    },
                                  ),
                                  MyTextFormField(
                                    hintText: 'Masukkan tarif listrik',
                                    labelText: 'Tarif per KWh',
                                    value: snapshot.data.tarifPerKwh.toString(),
                                    isEmail: false,
                                    icon: Icon(Icons.money),
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
                                    hintText: 'Masukkan budget anda',
                                    labelText: 'Budget',
                                    value: snapshot.data.budgetMax.toString(),
                                    isEmail: false,
                                    icon: Icon(Icons.money_off_rounded),
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
                                  Container(
                                    alignment: Alignment.topRight,
                                    child: Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: RaisedButton(
                                                  color: Colors.blueAccent,
                                                  shape: StadiumBorder(),
                                                  onPressed: () {

                                                    if (_formKey.currentState.validate()) {
                                                      _formKey.currentState.save();
                                                    
                                                      setting.setSetting(setting);
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
                                    )
                                  ),
                                  
                                ]
                              )
                          )
                    );
                  }else{
                    return SingleChildScrollView(
                            child : Form(
                              key: _formKey,
                              child: Column(
                                children: <Widget>[
                                  MyTextFormField(
                                    hintText: 'Masukkan Channel Id anda',
                                    labelText: 'Channel Id',
                                    isEmail: false,
                                    icon: Icon(Icons.verified_user),
                                    validator: (String value) {
                                      if (validator.isNull(value)) {
                                        return 'Please enter a channel id';
                                      }
                                      return null;
                                    },
                                    onSaved: (String value) {
                                      setting.channelId = value;
                                    },
                                  ),
                                  MyTextFormField(
                                    hintText: 'Masukkan API Key anda',
                                    labelText: 'API Key',
                                    isEmail: false,
                                    icon: Icon(Icons.vpn_key_sharp),
                                    validator: (String value) {
                                      if (validator.isNull(value)) {
                                        return 'Please enter a api key';
                                      }
                                      return null;
                                    },
                                    onSaved: (String value) {
                                      setting.apiKey = value;
                                    },
                                  ),
                                  MyTextFormField(
                                    hintText: 'Masukkan tarif listrik',
                                    labelText: 'Tarif per KWh',
                                    isEmail: false,
                                    icon: Icon(Icons.money),
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
                                    hintText: 'Masukkan budget anda',
                                    labelText: 'Budget',
                                    isEmail: false,
                                    icon: Icon(Icons.money_off_rounded),
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
                                  Container(
                                    alignment: Alignment.topRight,
                                    child: Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: RaisedButton(
                                                  color: Colors.blueAccent,
                                                  shape: StadiumBorder(),
                                                  onPressed: () {

                                                    if (_formKey.currentState.validate()) {
                                                      _formKey.currentState.save();
                                                    
                                                      setting.setSetting(setting);
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
                                    )
                                  ),
                                  
                                ]
                              )
                          )
                    );
                  }
              },
    );
          
  }
}
