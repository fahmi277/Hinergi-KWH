import 'package:dio/dio.dart';
import 'package:hinergi_kwh/service/apiKey.dart';

//https://api.thingspeak.com/channels/1154780/feeds/last.json?api_key=SPZVVOM0D4YO6TX0&timezone=Asia%2FJakarta

// main() async {

// }

Future<Map> getThinkspeakData() async {
  var dio = Dio();

  String channelId = dataApi().channelID;
  String apiKey = dataApi().apiKey;
  String baseUrl = "https://api.thingspeak.com/channels/";
  String feedUrl = "/feeds/last.json?api_key=";
  String timezoneUrl = "&timezone=Asia%2FJakarta";

  String url = baseUrl + channelId + feedUrl + apiKey + timezoneUrl;
  Response response = await dio.get(url);
  print(response.data);

  return response.data;
}
