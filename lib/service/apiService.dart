import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:hinergi_kwh/controller/getTimeData.dart';
import 'package:hinergi_kwh/model/thinkspeak.dart';
import 'package:hinergi_kwh/service/apiKey.dart';
import 'package:shared_preferences/shared_preferences.dart';

//https://api.thingspeak.com/channels/1154780/feeds/last.json?api_key=SPZVVOM0D4YO6TX0&timezone=Asia%2FJakarta

// main() async {
//   Options options =
//       Options(headers: {HttpHeaders.acceptHeader: "accept: application/json"});
//   //response = await dio.get("/test", queryParameters: {"id": 12, "name": "wendu"});

//   String channelId = dataApi().channelID;
//   String apiKey = dataApi().apiKey;

//   String baseUrl =
//       // "https://api.thingspeak.com/channels/1154780/fields/4.json?start=2020-10-09%2000:00:00&end=2020-10-10%2000:00:00&api_key=SPZVVOM0D4YO6TX0";

//       "https://api.thingspeak.com/channels/1154780/fields/4";

//   try {
//     // Response response;
//     var dio = Dio();
//     // Response response = await dio.get(baseUrl);

//     Response response = await dio.get(baseUrl, queryParameters: {
//       "start": "2020-10-09%2000:00:00",
//       "end": "2020-10-10%2000:00:00",
//       "apikey": apiKey.toString()
//     });

//     print(response.data["channel"]);
//     print(apiKey);
//   } catch (e) {
//     print(e.toString());
//   }
// }

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
    // print(response.runtimeType);
    var dataThinkspeak = Thinkspeak.fromJson(response.data);
    print(dataThinkspeak.feeds[1].createdAt);
    // print(url);
    // Map valueMap = json.decode(response.data);

    // List valueList = valueMap["feeds"];

    return response.data;
  } catch (e) {
    print("null");
    return null;
  }
}
