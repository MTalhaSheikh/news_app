import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_app/constants/strings.dart';
import 'package:news_app/models/news_model.dart';

class API_Manger{

  Future<NewsModel> getNews() async{
    // pehle client bnaen gy jis k through request kren gy
    var client = http.Client();
    var newsModel;

    try{
      // get k ander api ka path enter kiyaa hee
      var response = await client.get(Strings.newsUrl);
      // ager "response.statusCode == 200" he to is ka mtlb he k data read kr liya he
      if(response.statusCode == 200){
        var jsonString = response.body;
        var jsonMap = json.decode(jsonString);

        // API se data get krne k bd os ko map kren gy newsModel class me
        newsModel = NewsModel.fromJson(jsonMap);
      }
    }catch(Exception){
      return newsModel;
    }

    return newsModel;
  }
}