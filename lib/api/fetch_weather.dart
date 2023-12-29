import 'dart:convert';

import 'package:weatherapp_starter_project/model/weather_data.dart';
import 'package:http/http.dart' as http;
import 'package:weatherapp_starter_project/model/weather_data_current.dart';
import 'package:weatherapp_starter_project/model/weather_data_daily.dart';
import 'package:weatherapp_starter_project/model/weather_data_hourly.dart';
import 'package:weatherapp_starter_project/utils/api_url.dart';

class FetchWeatherAPI {
  WeatherData? weatherData;

  // procecssing the data from response -> to json
  Future<WeatherData> processData(lat, lon) async {
    var response = await http.get(Uri.parse(apiURL(lat, lon)));
    var jsonString = jsonDecode(response.body);
    var jsonHourly = ''' [
              {"dt": 1637438400, "temp": 22.5, "weather": [{"id": 800, "main": "Clear", "description": "clear sky", "icon": "01d"}]},
              {"dt": 1637442000, "temp": 23.0, "weather": [{"id": 801, "main": "Clouds", "description": "few clouds", "icon": "02d"}]},
              {"dt": 1637453200, "temp": 24.2, "weather": [{"id": 802, "main": "raining", "description": "thunder strom", "icon": "01n"}]},
              {"dt": 1637435400, "temp": 26.5, "weather": [{"id": 803, "main": "cloudy", "description": "Heavy rain", "icon": "02n"}]},
              {"dt": 1637436200, "temp": 21.5, "weather": [{"id": 804, "main": "cloudy", "description": "Cloudy", "icon": "03d"}]},
              {"dt": 1637436200, "temp": 30.5, "weather": [{"id": 805, "main": "cloudy", "description": "Cloudy", "icon": "03n"}]},
              {"dt": 1637436200, "temp": 22.5, "weather": [{"id": 806, "main": "cloudy", "description": "Cloudy", "icon": "04d"}]},
              {"dt": 1637436200, "temp": 30.5, "weather": [{"id": 807, "main": "cloudy", "description": "Cloudy", "icon": "04n"}]},
              {"dt": 1637436200, "temp": 20.5, "weather": [{"id": 808, "main": "cloudy", "description": "Cloudy", "icon": "09d"}]},
              {"dt": 1637436200, "temp": 17.5, "weather": [{"id": 810, "main": "cloudy", "description": "Cloudy", "icon": "09n"}]},
              {"dt": 1637436200, "temp": 20.5, "weather": [{"id": 811, "main": "cloudy", "description": "Cloudy", "icon": "10d"}]},
              {"dt": 1637436200, "temp": 30.5, "weather": [{"id": 812, "main": "cloudy", "description": "Cloudy", "icon": "10n"}]},
              {"dt": 1637436200, "temp": 14.5, "weather": [{"id": 813, "main": "cloudy", "description": "Cloudy", "icon": "11d"}]},
              {"dt": 1637436200, "temp": 23.5, "weather": [{"id": 814, "main": "cloudy", "description": "Cloudy", "icon": "11n"}]},
              {"dt": 1637436200, "temp": 20.5, "weather": [{"id": 815, "main": "cloudy", "description": "Cloudy", "icon": "13d"}]},
              {"dt": 1637436200, "temp": 25.0, "weather": [{"id": 816, "main": "cloudy", "description": "Cloudy", "icon": "13n"}]},
              {"dt": 1637436200, "temp": 22.5, "weather": [{"id": 817, "main": "cloudy", "description": "Cloudy", "icon": "50d"}]},
              {"dt": 1637436200, "temp": 20.8, "weather": [{"id": 818, "main": "cloudy", "description": "Cloudy", "icon": "50n"}]}
            ]
          ''';
    var jsonDaily = ''' [
              {"dt": 1637438400, "temp": {"day": 22.5, "night": 18.0}, "weather": [{"id": 800, "main": "Clear", "description": "clear sky", "icon": "01d"}]},
              {"dt": 1637524800, "temp": {"day": 23.0, "night": 17.5}, "weather": [{"id": 801, "main": "Clouds", "description": "few clouds", "icon": "02d"}]},
              {"dt": 1637624801, "temp": {"day": 14.0, "night": 18.5}, "weather": [{"id": 802, "main": "Clear", "description": "clear sky", "icon": "03d"}]},
              {"dt": 1637724800, "temp": {"day": 25.0, "night": 17.0}, "weather": [{"id": 803, "main": "Clouds", "description": "few clouds", "icon": "04d"}]},
              {"dt": 1637824800, "temp": {"day": 27.0, "night": 16.5}, "weather": [{"id": 804, "main": "Clouds", "description": "clear sky", "icon": "09d"}]},
              {"dt": 1637924800, "temp": {"day": 28.0, "night": 20.5}, "weather": [{"id": 805, "main": "Clouds", "description": "few clouds", "icon": "10d"}]},
              {"dt": 1702696222, "temp": {"day": 23.0, "night": 25.0}, "weather": [{"id": 806, "main": "Clouds", "description": "clear sky", "icon": "11d"}]}
              ]''';
    var jsonCurrent = '''{
              "dt": 1637365919,
              "sunrise": 1637350000,
              "sunset": 1637390000,
              "temp": 25.0,
              "feels_like": 26.0,
              "pressure": 1015,
              "humidity": 60,
              "dew_point": 18.0,
              "uvi": 5.0,
              "clouds": 0,
              "visibility": 10000,
              "wind_speed": 3.5,
              "wind_deg": 180,
              "weather": [{"id": 800, "main": "Clear", "description": "clear sky", "icon": "01d"}]
            }''';
    jsonString['current'] = jsonDecode(jsonCurrent);
    jsonString['hourly'] = jsonDecode(jsonHourly);
    jsonString['daily'] = jsonDecode(jsonDaily);
    weatherData = WeatherData(
        WeatherDataCurrent.fromJson(jsonString),
        WeatherDataHourly.fromJson(jsonString),
        WeatherDataDaily.fromJson(jsonString));

    return weatherData!;
  }
}
