// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/backend/provider/weather_provider.dart';
import 'package:weather_app/frontend/resources/app_icons.dart';
import 'package:weather_app/frontend/style/app_colors.dart';
import 'package:weather_app/frontend/style/app_style.dart';

class DayPositionItem extends StatelessWidget {
  const DayPositionItem({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<WeatherProvider>();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 160,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: AppColors.transparent,
          border: Border.all(
            width: 0.5,
            color: AppColors.white,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            RowItem(
              icon: AppIcons.sunrise,
              text: 'Восход ${model.setSunRise()}',
            ),
            RowItem(
              icon: AppIcons.sunset,
              text: 'Закат ${model.setSunSet()}',
            ),
          ],
        ),
      ),
    );
  }
}

class RowItem extends StatelessWidget {
  const RowItem({
    super.key,
    required this.icon,
    required this.text,
  });

  final String text, icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SvgPicture.asset(
          icon,
          color: AppColors.white,
        ),
        const SizedBox(height: 18),
        Text(
          text,
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
