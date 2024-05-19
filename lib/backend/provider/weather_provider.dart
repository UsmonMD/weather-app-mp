import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/backend/api/api.dart';
import 'package:weather_app/backend/hive/favorite_item.dart';
import 'package:weather_app/backend/hive/hive_box.dart';
import 'package:weather_app/backend/models/coords.dart';
import 'package:weather_app/backend/models/weather_data.dart';
import 'package:weather_app/frontend/resources/app_bg.dart';
import 'package:weather_app/frontend/routes/app_routes.dart';
import 'package:weather_app/frontend/style/app_colors.dart';

class WeatherProvider extends ChangeNotifier {
  //хранения координат
  Coord? _coords;
  Coord? get coords => _coords;

  //Хранение данных о погоде
  WeatherData? _weatherData;
  WeatherData? get weatherData => _weatherData;

  //текущие данные о погоде
  Current? _current;

  //контроллер ввода
  final searchController = TextEditingController();

  final pref = SharedPreferences.getInstance();

  //Главная функция для запуска во FutureBuilder
  Future<WeatherData?> setUp({String? cityName}) async {
    // (await pref).clear();
    cityName = (await pref).getString('city_name');
    _coords = await Api.getCoords(cityName: cityName ?? 'Tashkent');
    _weatherData = await Api.getWeather(_coords);
    _current = _weatherData?.current;
    setCurrentTime();
    setCurrentTemp();
    setMaxTemp();
    setMinTemp();
    setWeekDays();
    getCurrentCity();

    return _weatherData;
  }

  //установка текущего города
  void setCurrentCity(BuildContext context, {String? cityName}) async {
    if (searchController.text != '') {
      cityName = searchController.text;
      // (await pref).clear();
      (await pref).setString('city_name', cityName);
      await setUp(cityName: (await pref).getString('city_name'))
          .then((value) => context.go(AppRoutes.home))
          .then((value) => searchController.clear());
      notifyListeners();
    }
  }

  String currenCity = '';
  Future<String> getCurrentCity() async {
    // (await pref).clear();
    currenCity = (await pref).getString('city_name') ?? 'Ташкент';
    return currenCity;
  }

  String? currentBg;

  String setBg() {
    int id = _current?.weather?[0].id ?? 0;

    if (id == 0 || _current?.sunset == null || _current?.dt == null) {
      currentBg = AppBg.shinyDay;
    }

    try {
      if (_current!.sunset < _current!.dt) {
        if (id >= 200 && id <= 531) {
          currentBg = AppBg.rain;
          AppColors.black = Colors.white;
        } else if (id >= 600 && id <= 622) {
          currentBg = AppBg.snow;
          AppColors.black = Colors.white;
        } else if (id >= 701 && id <= 781) {
          currentBg = AppBg.night;
          AppColors.black = Colors.white;
        } else if (id == 800) {
          currentBg = AppBg.night;
          AppColors.black = Colors.white;
        } else if (id >= 801 && id <= 804) {
          currentBg = AppBg.night;
          AppColors.black = Colors.white;
        }
      } else {
        if (id >= 200 && id <= 531) {
          currentBg = AppBg.rain;
        } else if (id >= 600 && id <= 622) {
          currentBg = AppBg.snow;
        } else if (id >= 701 && id <= 781) {
          currentBg = AppBg.day;
        } else if (id == 800) {
          currentBg = AppBg.day;
        } else if (id >= 801 && id <= 804) {
          currentBg = AppBg.day;
        }
      }
    } catch (e) {
      return AppBg.day;
    }

    return currentBg ?? AppBg.shinyDay;
  }

  //текущее время

  String? currentTime;

  String setCurrentTime() {
    final getTime = (_current?.dt ?? 0) + (_weatherData?.timezoneOffset ?? 0);
    // print(getTime);
    final setTime = DateTime.fromMillisecondsSinceEpoch(getTime * 1000);
    // print(setTime);

    currentTime = DateFormat('HH:mm a').format(setTime);

    return currentTime ?? 'Error';
  }

  //текущий статус погоды
  String currentStatus = 'Ошибка';

  String getCurrentStatus() {
    currentStatus = _current?.weather?[0].description ?? currentStatus;
    return capitalize(currentStatus);
  }

  String capitalize(String str) => str[0].toUpperCase() + str.substring(1);

  //иконка в зависимости от описания погоды

  final String _iconUrl = 'https://openweathermap.org/img/wn/';
  String iconData() {
    return '$_iconUrl${_current?.weather?[0].icon}.png';
  }

  //текущая температура
  int kelvin = -273;

  int currentTemp = 0;

  int setCurrentTemp() {
    currentTemp = ((_current?.temp ?? -kelvin) + kelvin).round();
    return currentTemp;
  }

  //max temp
  int maxTemp = 0;

  int setMaxTemp() {
    maxTemp = ((_weatherData?.daily?[0].temp?.max ?? -kelvin) + kelvin).round();
    return maxTemp;
  }

  //min temp

  int minTemp = 0;
  int setMinTemp() {
    minTemp = ((_weatherData?.daily?[0].temp?.min ?? -kelvin) + kelvin).round();

    return minTemp;
  }

  //установка дней недели
  final List<String> date = [];
  List<Daily> daily = [];

  void setWeekDays() {
    daily = _weatherData?.daily ?? [];
    for (var i = 0; i < daily.length; i++) {
      if (i == 0 && daily.isNotEmpty) {
        date.clear();
      }

      if (i == 0) {
        date.add('Сегодня');
      } else {
        var timeNum = daily[i].dt * 1000;
        var itemDate = DateTime.fromMillisecondsSinceEpoch(timeNum);
        date.add(capitalize(DateFormat('EEEE', 'ru').format(itemDate)));
      }
    }
  }

  //иконки на неделю

  String setdailyIcons(int index) {
    final String getIcon = '${_weatherData?.daily?[index].weather?[0].icon}';
    final String setIcon = '$_iconUrl$getIcon.png';
    return setIcon;
  }

  //daily temp for weekday
  int dailyTemp = 0;
  int setDailyTemp(int index) {
    dailyTemp =
        ((_weatherData?.daily?[index].temp?.max ?? -kelvin) + kelvin).round();
    return dailyTemp;
  }

  //night temp for weekday

  int nightTemp = 0;
  int setNightTemp(int index) {
    nightTemp =
        ((_weatherData?.daily?[index].temp?.min ?? -kelvin) + kelvin).round();
    return nightTemp;
  }

  //weather grid data
  final List<dynamic> weatherValues = [];

  dynamic setValues(int index) {
    weatherValues.add(_current?.windSpeed ?? 0);
    weatherValues.add(((_current?.feelsLike ?? -kelvin) + kelvin).round());
    weatherValues.add(_current?.humidity ?? 0);
    weatherValues.add((_current?.visibility ?? 0) / 1000);
    return weatherValues[index];
  }

  //время восхода
  String sunRise = '';
  String setSunRise() {
    final getSunTime =
        (_current?.sunrise ?? 0) + (_weatherData?.timezoneOffset ?? 0);
    final setSunRise = DateTime.fromMillisecondsSinceEpoch(getSunTime * 1000);
    sunRise = DateFormat('HH:mm a').format(setSunRise);
    return sunRise;
  }

  //время заката
  String sunSet = '';
  String setSunSet() {
    final getSunTime =
        (_current?.sunset ?? 0) + (_weatherData?.timezoneOffset ?? 0);
    final setSunSet = DateTime.fromMillisecondsSinceEpoch(getSunTime * 1000);
    sunSet = DateFormat('HH:mm a').format(setSunSet);

    return sunSet;
  }

  var box = Hive.box<FavoriteItem>(HiveBox.favoriteBox);
  //добавление в избранное
  Future<void> setFavorite(BuildContext context, {String? cityName}) async {
    box
        .add(
          FavoriteItem(
            timeZone: _weatherData?.timezone ?? 'Error',
            cityName: cityName ?? 'Ташкент',
            bg: currentBg ?? AppBg.shinyDay,
            icon: iconData(),
            temp: currentTemp,
          ),
        )
        .then(
          (value) => ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Город $cityName добавлен в избранное',
              ),
            ),
          ),
        );
  }

  //метод удаления из избранного
  Future<void> delete(int index) async {
    box.deleteAt(index);
  }
}
