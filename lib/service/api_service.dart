import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:sakib/constants/constants.dart';
import '../model/weather_model.dart';

class ApiService {

  Future<WeatherModel> getWeatherData(String searchText) async {

    String url = "$baseUrl&q=$searchText&days=7";

    try {

      Response response = await get(Uri.parse(url));

      if(response.statusCode == 200) {

        Map<String,dynamic> json = jsonDecode(response.body);
        WeatherModel weatherModel = WeatherModel.fromJson(json);

        return weatherModel;

      }
      else {
        throw ("No Data Found");
      }

    }
    catch(e) {

      if (kDebugMode) {
        print(e.toString());
      }
      throw e.toString();

    }

  }

}
