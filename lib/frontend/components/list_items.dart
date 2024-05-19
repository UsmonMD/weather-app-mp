import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/backend/provider/weather_provider.dart';
import 'package:weather_app/frontend/components/day_item.dart';

import 'package:weather_app/frontend/style/app_colors.dart';

class ListItems extends StatelessWidget {
  const ListItems({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<WeatherProvider>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: AppColors.transparent,
        ),
        height: 400,
        child: ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, i) {
            return DayItem(
              day: model.date[i],
              dailyIcon: model.setdailyIcons(i),
              dayTemp: model.setDailyTemp(i),
              nightTemp: model.setNightTemp(i),
            );
          },
          separatorBuilder: (context, i) => const SizedBox(height: 16),
          itemCount: model.date.length,
        ),
      ),
    );
  }
}
