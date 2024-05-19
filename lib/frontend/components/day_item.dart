import 'package:flutter/material.dart';
import 'package:weather_app/frontend/style/app_colors.dart';
import 'package:weather_app/frontend/style/app_style.dart';

class DayItem extends StatelessWidget {
  const DayItem({
    super.key,
    required this.day,
    required this.dailyIcon,
    required this.dayTemp,
    required this.nightTemp,
  });

  final String day, dailyIcon;
  final int dayTemp, nightTemp;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 4,
          child: Text(
            day,
            style: AppStyle.fontStyle.copyWith(
              color: AppColors.white,
              fontWeight: FontWeight.w100,
            ),
          ),
        ),
        Expanded(
          flex: 0,
          child: Image.network(
            dailyIcon,
            width: 30,
          ),
        ),
        const Expanded(child: SizedBox()),
        Expanded(
          flex: 2,
          child: Text(
            '$dayTemp °C',
            style: AppStyle.fontStyle.copyWith(
              color: AppColors.white,
              fontWeight: FontWeight.w100,
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            '$nightTemp °C',
            style: AppStyle.fontStyle.copyWith(
              color: AppColors.white,
              fontWeight: FontWeight.w100,
            ),
          ),
        ),
      ],
    );
  }
}
