import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:weather_app/backend/hive/favorite_item.dart';
import 'package:weather_app/backend/hive/hive_box.dart';

import 'package:weather_app/weather_app.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ),
  );

  await Hive.initFlutter();
  Hive.registerAdapter(FavoriteItemAdapter());
  await Hive.openBox<FavoriteItem>(HiveBox.favoriteBox);

  await dotenv.load(fileName: '.env');
  runApp(const WeatherApp());
}
 