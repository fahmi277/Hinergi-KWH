import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:hinergi_kwh/service/apiKey.dart';

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

Future<Map> getThinkspeakData() async {
  try {
    var dio = Dio();

    // String channelId = dataApi().channelID;
    // String apiKey = dataApi().apiKey;
    // String baseUrl = "https://api.thingspeak.com/channels/";
    // String feedUrl = "/feeds/last.json?api_key=";
    // String timezoneUrl = "&timezone=Asia%2FJakarta";

    // String url = baseUrl + channelId + feedUrl + apiKey + timezoneUrl;
    String url =
        "https://api.thingspeak.com/channels/1154780/feeds.json?api_key=SPZVVOM0D4YO6TX0&timezone=Asia%2FJakarta";
    // "https://api.thingspeak.com/channels/1154780/fields/4?api_key=SPZVVOM0D4YO6TX0&timezone=Asia%2FJakarta";
    // String url = "https://api.thingspeak.com/channels/1154780/fields/4?end=2020-10-11%2000:00:00&apikey=SPZVVOM0D4YO6TX0&start=2020-10-10%2000:00:00";
    Response response = await dio.get(url);
    print(response.data.runtimeType);
    // Map valueMap = json.decode(response.data);

    // List valueList = valueMap["feeds"];

    return response.data;
  } catch (e) {
    return null;
  }
}
