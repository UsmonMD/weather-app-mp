// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/backend/provider/weather_provider.dart';
import 'package:weather_app/frontend/resources/app_icons.dart';
import 'package:weather_app/frontend/style/app_colors.dart';
import 'package:weather_app/frontend/style/app_style.dart';

class GridItems extends StatelessWidget {
  const GridItems({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<WeatherProvider>();
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
      ),
      itemBuilder: (context, i) {
        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: BorderSide(
              width: 0.5,
              color: AppColors.white,
            ),
          ),
          color: AppColors.transparent,
          elevation: 0,
          child: Center(
            child: ListTile(
              leading: SvgPicture.asset(
                GridIcons.gridIcons[i],
                color: AppColors.white,
              ),
              title: Text(
                '${model.setValues(i)} ${GridUnits.gridUnits[i]}',
                style: AppStyle.fontStyle.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                  color: AppColors.white,
                ),
              ),
              subtitle: Text(
                GridDescription.gridDescription[i],
                style: AppStyle.fontStyle.copyWith(
                  fontSize: 10,
                  color: AppColors.white,
                ),
              ),
            ),
          ),
        );
      },
      itemCount: 4,
    );
  }
}

class GridIcons {
  static List<String> gridIcons = [
    AppIcons.speed,
    AppIcons.termometr,
    AppIcons.rainDrops,
    AppIcons.visible,
  ];
}

class GridDescription {
  static List<String> gridDescription = [
    'Скорость ветра',
    'Ощущается',
    'Влажность',
    'Видимость',
  ];
}

class GridUnits {
  static List<String> gridUnits = [
    'км/ч',
    '°С',
    '%',
    'км',
  ];
}
