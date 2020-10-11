import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Setting {
  int budgetMax = 0;
  int tarifPerKwh = 0;
  String channelId;
  String apiKey;

  Setting({this.channelId,this.apiKey,this.tarifPerKwh,this.budgetMax});

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

  Future<Setting> getSetting() async{
    try{
      Setting set = Setting();
      SharedPreferences prefs = await SharedPreferences.getInstance();

      set.channelId = prefs.getString('channelId') ?? 0;
      set.apiKey = prefs.getString('apiKey') ?? 0;
      set.tarifPerKwh = prefs.getInt('tarif') ?? 0;
      set.budgetMax = prefs.getInt('budget') ?? 0;
      return set;
    } catch(e){
      Setting set = Setting();
      set.apiKey = 'non set';
      set.channelId = 'non set';
      set.tarifPerKwh = 0;
      set.budgetMax = 0;
      return set;
    }
   
  }
}