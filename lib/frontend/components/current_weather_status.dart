import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/backend/provider/weather_provider.dart';
import 'package:weather_app/frontend/style/app_colors.dart';

import 'package:weather_app/frontend/style/app_style.dart';

class CurrentWeatherStatus extends StatelessWidget {
  const CurrentWeatherStatus({super.key});

  @override
  Widget build(BuildContext context) {
    final currentStatus = context.watch<WeatherProvider>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.network(
          currentStatus.iconData(),
          fit: BoxFit.cover,
        ),
        const SizedBox(width: 25),
        Text(
          currentStatus.getCurrentStatus(),
          style: AppStyle.fontStyle.copyWith(
            fontSize: 16,
            color: AppColors.white,
            fontWeight: FontWeight.w100,
          ),
        ),
      ],
    );
  }
}
