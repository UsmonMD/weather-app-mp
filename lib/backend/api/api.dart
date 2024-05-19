import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:weather_app/backend/models/coords.dart';
import 'package:weather_app/backend/models/weather_data.dart';

abstract class Api {
  static final apiKey = dotenv.get('API_KEY');
  // Ссылка для получения координат
//https://api.openweathermap.org/data/2.5/weather?q=London&appid=49cc8c821cd2aff9af04c9f98c36eb74
  static final dio = Dio();

  static Future<Coord> getCoords({String cityName = 'Tashkent'}) async {
    final response = await dio.get(
        'https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey&lang=ru');

    try {
      final coords = Coord.fromJson(response.data);
      return coords;
    } catch (_) {
      final coords = Coord.fromJson(response.data);
      return coords;
    }
  }

  // Ссылка для получения погоды
//https://api.openweathermap.org/data/2.5/onecall?lat=55.7522&lon=37.6156&exclude=hourly,minutely&appid=49cc8c821cd2aff9af04c9f98c36eb74

  static Future<WeatherData?> getWeather(Coord? coords) async {
    if (coords != null) {
      final lat = coords.lat.toString();
      final lon = coords.lon.toString();
      final response = await dio.get(
          'https://api.openweathermap.org/data/2.5/onecall?lat=$lat&lon=$lon&exclude=hourly,minutely&appid=$apiKey&lang=ru');
      // print(response.data);
      final weatherData = WeatherData.fromJson(response.data);
      return weatherData;
    }
    return null;
  }
}
