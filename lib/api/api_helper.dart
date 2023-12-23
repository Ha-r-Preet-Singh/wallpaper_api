import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:wallpaper_api_intro_46/api/app_exception.dart';
import 'package:wallpaper_api_intro_46/model/data_wallpaper_model.dart';
class ApiHelper {

  Future<dynamic>? getApi(String url,{Map<String,String>? mHeaders})async {

    try{
      var res = await http.get(Uri.parse(url),
          headers:
          mHeaders ??
              {
                "Authorization":
                "ccEI7ea5vTWvcypWjTBtmnSVnyGSW9pUpX910XJEbYsJI0We4U08zfRt"
              });

      return returnMyResponse(res);

    }on SocketException{
      throw FetchDataExceptions(mBody: "Internet Error");
    }


    // if(res.statusCode==200){
    //   return jsonDecode(res.body);
    //
    // }else{
    //   return null;
    // }


  }





  dynamic returnMyResponse(http.Response res){
    switch(res.statusCode){
      case 200:
        var mData = jsonDecode(res.body);
        print(mData);
        return mData;
      case 400:
        throw BadRequestException(mBody: res.body.toString());

      case 401:
      case 402:
      case 407:
        throw UnAuthorisedException(mBody: res.body.toString());
      case 500:
      default:
        throw ServerException(mBody: "Error while communicating to server");
    }




  }

}