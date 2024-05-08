import 'package:flutter/material.dart';
import 'package:sakib/model/weather_model.dart';
import 'package:sakib/service/api_service.dart';
import 'package:sakib/ui/components/hourly_weather.dart';
import 'package:sakib/ui/components/todays_weather.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  ApiService apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.black,

      appBar: AppBar(
        title: const Text(
          "Weather",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
        foregroundColor: Colors.white,
      ),

      body: SafeArea(
        child: FutureBuilder(
          builder: (context,snapshot) {

            if(snapshot.hasData) {

              WeatherModel? weatherModel = snapshot.data;

              return SizedBox(
                width: double.infinity,
                child: Column(
                  children: [

                    TodaysWeather(
                      weatherModel: weatherModel,
                    ),

                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "Weather by Hours",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 22
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),

                    SizedBox(
                      height: 150,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: weatherModel?.forecast?.forecastday?[0].hour?.length,
                        itemBuilder: (context, index) {

                          Hour? hour = weatherModel?.forecast?.forecastday?[0].hour?[index];

                          return HourlyWeatherListItem(
                            hour: hour,
                          );

                        },
                      ),
                    )

                  ],
                ),
              );
            }
            if(snapshot.hasError) {
              return const Center(
                child: Text("Error Occurred"),
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );

          },
          future: apiService.getWeatherData("Dumki"),

        ),
      ),

    );
  }
}
