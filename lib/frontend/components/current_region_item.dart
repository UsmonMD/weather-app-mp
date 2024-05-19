import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/backend/provider/weather_provider.dart';
import 'package:weather_app/frontend/routes/app_routes.dart';
import 'package:weather_app/frontend/style/app_colors.dart';
import 'package:weather_app/frontend/style/app_style.dart';

class CurrentRegionItem extends StatelessWidget {
  const CurrentRegionItem({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<WeatherProvider>();
    return InkWell(
      onTap: () {
        context.go(AppRoutes.home);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            width: 1,
            color: AppColors.white,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CurrentTimeZone(
              currentCity: model.currenCity,
              currentZone: model.weatherData?.timezone,
            ),
            CurrenRegionTemp(
              icon: model.iconData(),
              currentTemp: model.setCurrentTemp(),
            ),
          ],
        ),
      ),
    );
  }
}

class CurrentTimeZone extends StatelessWidget {
  const CurrentTimeZone({
    super.key,
    required this.currentCity,
    required this.currentZone,
  });

  final String? currentCity, currentZone;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Текущее место',
          style:
              AppStyle.fontStyle.copyWith(fontSize: 12, color: AppColors.white),
        ),
        const SizedBox(height: 6),
        Text(
          '$currentCity',
          style: AppStyle.fontStyle.copyWith(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: AppColors.white,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          '$currentZone',
          style: AppStyle.fontStyle.copyWith(
            fontSize: 12,
            color: AppColors.white,
          ),
        ),
      ],
    );
  }
}

class CurrenRegionTemp extends StatelessWidget {
  const CurrenRegionTemp({
    super.key,
    required this.currentTemp,
    required this.icon,
  });

  final String icon;
  final int currentTemp;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.network(icon),
        const SizedBox(width: 10),
        Text(
          '$currentTemp °С',
          style: AppStyle.fontStyle.copyWith(
            fontSize: 18,
            color: AppColors.white,
          ),
        ),
      ],
    );
  }
}
