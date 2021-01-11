import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news_app_restapi/models/newsInfo.dart';
const apikey = '1d931649c1004edd8d2202b5762c1be3';

class ApiManager {
  Future<NewsModel> getNews() async {
    var client = http.Client();
    var newsModel;
    try {
      var response = await client.get('http://newsapi.org/v2/everything?domains=wsj.com&apiKey=$apikey');
      if (response.statusCode == 200) {
        var jsonString = response.body;
        var jsonMap = json.decode(jsonString);
        newsModel = NewsModel.fromJson(jsonMap);
        return newsModel;
      }
    } catch (Exception) {
      return null;
    }
  }
}
