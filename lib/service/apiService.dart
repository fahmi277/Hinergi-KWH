import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:hinergi_kwh/controller/getTimeData.dart';
import 'package:hinergi_kwh/service/apiKey.dart';
import 'package:shared_preferences/shared_preferences.dart';


Future<Map> getThinkspeakData(Map timeValue) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  try {
    var dio = Dio();

    String channelId = prefs.getString('channelId') ?? '1154780';
    String apiKey = prefs.getString('apiKey') ?? 'SPZVVOM0D4YO6TX0';

    String startTime = timeValue["startTime"];
    String endTime = timeValue["endTime"];

    // String channelId = dataApi().channelID;
    // String apiKey = dataApi().apiKey;
    // String baseUrl = "https://api.thingspeak.com/channels/";
    // String feedUrl = "/feeds/last.json?api_key=";
    // String timezoneUrl = "&timezone=Asia%2FJakarta";

    // String url = baseUrl + channelId + feedUrl + apiKey + timezoneUrl;

    // print(GetTimedata().timeData["startTime"]);
    // print(GetTimedata().timeData["endTime"]);
    // channel id = 1154780
    // api key = SPZVVOM0D4YO6TX0

    // String url = "https://api.thingspeak.com/channels/" +
    //     channelId +
    //     "/feeds.json?end=" +
    //     GetTimedata().timeData["endTime"] +
    //     "&apikey=" +
    //     apiKey +
    //     "&start=" +
    //     GetTimedata().timeData["startTime"] +
    //     "&timezone=Asia%2FJakarta";

    String url = "https://api.thingspeak.com/channels/" +
        channelId +
        "/feeds.json?end=" +
        endTime +
        "&apikey=" +
        apiKey +
        "&start=" +
        startTime +
        "&timezone=Asia%2FJakarta";

    Response response = await dio.get(url);
    // print(response.data);
    // Map valueMap = json.decode(response.data);

    // List valueList = valueMap["feeds"];

    return response.data;
  } catch (e) {
    print("null");
    return null;
  }
}
