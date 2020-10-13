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

      set.channelId = prefs.getString('channelId') ?? 0;
      set.apiKey = prefs.getString('apiKey') ?? 0;
      set.tarifPerKwh = prefs.getDouble('tarif') ?? 0;
      set.budgetMax = prefs.getDouble('budget') ?? 0;
      set.kwhMax = prefs.getDouble('kwhmax') ?? 0;
      return set;
    } catch (e) {
      Setting set = Setting();
      set.apiKey = 'non set';
      set.channelId = 'non set';
      set.tarifPerKwh = 0;
      set.budgetMax = 0;
      set.kwhMax = 0;
      return set;
    }
  }
}
