import 'package:flutter/material.dart';
import 'package:flutter_weather_bg_null_safety/flutter_weather_bg.dart';
import 'package:intl/intl.dart';
import 'package:sakib/model/weather_model.dart';


class TodaysWeather extends StatelessWidget {

  final WeatherModel? weatherModel;

  const TodaysWeather({super.key, this.weatherModel});

  @override
  Widget build(BuildContext context) {

    return Stack(

      children: [

        WeatherBg(
          weatherType: WeatherType.heavyRainy,
          width: double.infinity,
          height: MediaQuery.sizeOf(context).height/2.8,
        ),

        SizedBox(
          width: double.infinity,
          height: MediaQuery.sizeOf(context).height/2.8,

          child: Column(
            children: [

              Container(

                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white10,
                  borderRadius: BorderRadius.circular(10),
                ),

                child: Column(
                  children: [
                    Text(
                      weatherModel?.location?.name ?? "",
                      style: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.white
                      ),
                    ),
                    Text(
                      DateFormat.yMMMMEEEEd().format(DateTime.parse(
                          weatherModel?.current?.lastUpdated.toString() ?? ""
                      )),
                      style: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.white
                      ),
                    ),
                  ],
                ),
              ),

              Row(
                children: [

                  SizedBox(
                    width: MediaQuery.sizeOf(context).width/30,
                  ),

                  Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white10,
                    ),
                    child: Image.network(
                        "https:${weatherModel?.current?.condition?.icon ?? ""}"
                    ),
                  ),

                  const Spacer(),

                  Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [

                          Text(
                            weatherModel?.current?.tempC?.round().toString() ?? "",
                            style: const TextStyle(
                              fontSize: 80,
                              fontWeight: FontWeight.bold,
                              color: Colors.pink,
                            ),
                          ),

                          const Text(
                            "o",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.pink,

                            ),
                          )

                        ],
                      ),

                      Text(
                        weatherModel?.current?.condition?.text ?? "",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Colors.white,
                        ),
                      )

                    ],
                  ),

                  SizedBox(
                    width: MediaQuery.sizeOf(context).width/30,
                  ),

                ],
              ),

              Container(

                margin: const EdgeInsets.all(8),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white10,
                  borderRadius: BorderRadius.circular(30),
                ),

                child: Column(
                  children: [

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [

                        Column(
                          children: [

                            const Text(
                              "Feels Like",
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w300
                              ),
                            ),
                            Text(
                              "${weatherModel?.current?.feelslikeC?.round()} °",
                              style: const TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w300
                              ),
                            )

                          ],
                        ),
                        Column(
                          children: [

                            const Text(
                              "Wind",
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w300
                              ),
                            ),
                            Text(
                              "${weatherModel?.current?.windKph?.round()} km/h",
                              style: const TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w300
                              ),
                            )

                          ],
                        ),

                      ],
                    ),

                    SizedBox(
                      height: MediaQuery.sizeOf(context).height/200,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [

                        Column(
                          children: [

                            const Text(
                              "Humidity",
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w300
                              ),
                            ),
                            Text(
                              "${weatherModel?.current?.humidity} %",
                              style: const TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w300
                              ),
                            )

                          ],
                        ),
                        Column(
                          children: [

                            const Text(
                              "Visibility",
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w300
                              ),
                            ),
                            Text(
                              "${weatherModel?.current?.visKm?.round()} km",
                              style: const TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w300
                              ),
                            )

                          ],
                        ),

                      ],
                    )

                  ],
                ),
              )

            ],
          ),
        ),

      ],

    );

  }
}
