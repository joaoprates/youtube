import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:youtube/model/Video.dart';

const KEY_YOUTUBE_API = "AIzaSyC2pBVhzvo9LXT2qxc7Gy734fHPuA07zPw";
const ID_CHANNEL = "UCVHFbqXqoYvEWM1Ddxl0QDg";
const URL_BASE = "https://www.googleapis.com/youtube/v3/";

class Api {

  Future<List<Video>> search(String search) async {
    http.Response response = await http.get(
        URL_BASE + "search"
            "?part=snippet"
            "&type=video"
            "&maxResults=20"
            "&order=date"
            "&key=$KEY_YOUTUBE_API"
            "&channelId=$ID_CHANNEL"
            "&q=$search"
    );
    if( response.statusCode == 200 ){

      Map<String, dynamic> dadosJson = json.decode( response.body );

      List<Video> videos = dadosJson["items"].map<Video>(
              (map){
            return Video.fromJson(map);
            //return Video.converterJson(map);
          }
      ).toList();

      return videos;

      print("result: " + dadosJson["items"][2]["snippet"]["title"].toString() );
    }else{
    }
  }

}

