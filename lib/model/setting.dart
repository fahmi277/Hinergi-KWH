import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Setting {
  double budgetMax = 0;
  double kwhMax = 0;
  double tarifPerKwh = 0;
  String channelId;
  String apiKey;

  Setting(
      {this.channelId,
      this.apiKey,
      this.tarifPerKwh,
      this.budgetMax,
      this.kwhMax});

  setSetting(Setting set) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('channelId', set.channelId);
    prefs.setString('apiKey', set.apiKey);
    prefs.setDouble('tarif', set.tarifPerKwh);
    prefs.setDouble('budget', set.budgetMax);
    prefs.setDouble('kwhmax', set.kwhMax);
    //start time
    prefs.setString("startTime", "2020-10-10");
  }

  setApiChannel(Setting set) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('channelId', set.channelId);
    prefs.setString('apiKey', set.apiKey);
     prefs.setDouble('tarif', 0);
    prefs.setDouble('budget', 0);
    prefs.setDouble('kwhmax', 0);
    prefs.setString("startTime", "2020-10-10");
  }

  setChannelId(String data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('channelId', data);
  }

  setApiKey(String data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('apiKey', data);
  }

  setTarif(double data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setDouble('tarif', data);
  }

  setButget(double data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setDouble('butget', data);
  }

  Future<Setting> getSetting() async {
    try {
      Setting set = Setting();
      SharedPreferences prefs = await SharedPreferences.getInstance();

      set.channelId = prefs.getString('channelId') ?? '';
      set.apiKey = prefs.getString('apiKey') ?? '';
      set.tarifPerKwh = prefs.getDouble('tarif') ?? 0;
      set.budgetMax = prefs.getDouble('budget') ?? 0;
      set.kwhMax = prefs.getDouble('kwhmax') ?? 0;
      return set;
    } catch (e) {
      print("error : "+e.toString());
      Setting set = Setting();
      set.apiKey = '';
      set.channelId = '';
      set.tarifPerKwh = 0;
      set.budgetMax = 0;
      set.kwhMax = 0;
      return set;
    }
  }
}
