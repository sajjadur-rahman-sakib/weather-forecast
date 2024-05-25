import 'package:flutter/material.dart';
import 'package:sakib/model/weather_model.dart';
import 'package:sakib/service/api_service.dart';
import 'package:sakib/ui/components/future_forecast.dart';
import 'package:sakib/ui/components/hourly_weather.dart';
import 'package:sakib/ui/components/todays_weather.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ApiService apiService = ApiService();
  final TextEditingController _textEditingController = TextEditingController();
  String searchText = "auto:ip";

  _showTextInputDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Search Location"),
            content: TextField(
              controller: _textEditingController,
              decoration: const InputDecoration(
                  hintText: "search by city, zip, lat, lang"),
            ),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Cancel")),
              ElevatedButton(
                  onPressed: () {
                    if (_textEditingController.text.isEmpty) {
                      return;
                    }

                    Navigator.pop(context, _textEditingController.text);
                  },
                  child: const Text("Ok"))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          "Weather",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
        ),
        actions: [
          IconButton(
              onPressed: () async {
                _textEditingController.clear();
                String text = await _showTextInputDialog(context);

                setState(() {
                  searchText = text;
                });
              },
              icon: const Icon(Icons.search)),
          IconButton(
              onPressed: () {
                searchText = "auto:ip";

                setState(() {});
              },
              icon: const Icon(Icons.my_location))
        ],
        centerTitle: true,
        backgroundColor: Colors.white24,
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: FutureBuilder(
          builder: (context, snapshot) {
            if (snapshot.hasData) {
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
                      style: TextStyle(color: Colors.white, fontSize: 22),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 150,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: weatherModel
                            ?.forecast?.forecastday?[0].hour?.length,
                        itemBuilder: (context, index) {
                          Hour? hour = weatherModel
                              ?.forecast?.forecastday?[0].hour?[index];

                          return HourlyWeatherListItem(
                            hour: hour,
                          );
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "Next 7 Days Weather",
                      style: TextStyle(color: Colors.white, fontSize: 22),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: ListView.builder(
                          itemCount:
                              weatherModel?.forecast?.forecastday?.length,
                          itemBuilder: (context, index) {
                            Forecastday? forecastday =
                                weatherModel?.forecast?.forecastday?[index];

                            return FutureForecastListItem(
                              forecastday: forecastday,
                            );
                          }),
                    )
                  ],
                ),
              );
            }
            if (snapshot.hasError) {
              return const Center(
                child: Text("Error Occurred"),
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
          future: apiService.getWeatherData(searchText),
        ),
      ),
    );
  }
}
