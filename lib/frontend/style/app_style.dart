import 'package:flutter/material.dart';
import 'package:weather_app/frontend/style/app_colors.dart';

abstract class AppStyle {
  static TextStyle fontStyle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.normal,
    color: AppColors.black,
  );
}
