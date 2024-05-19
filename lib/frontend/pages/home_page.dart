import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/backend/provider/weather_provider.dart';
import 'package:weather_app/frontend/components/current_weather_status.dart';
import 'package:weather_app/frontend/components/day_position_item.dart';
import 'package:weather_app/frontend/components/grid_items.dart';
import 'package:weather_app/frontend/components/list_items.dart';
import 'package:weather_app/frontend/components/temprature_items.dart';
import 'package:weather_app/frontend/routes/app_routes.dart';
import 'package:weather_app/frontend/style/app_colors.dart';
import 'package:weather_app/frontend/style/app_style.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: Provider.of<WeatherProvider>(context).setUp(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              return const WeatherAppBody();
            default:
              return const Center(
                child: CupertinoActivityIndicator(
                  radius: 15,
                  color: Colors.orange,
                ),
              );
          }
        },
      ),
    );
  }
}

class WeatherAppBar extends StatelessWidget {
  const WeatherAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final dateModel = context.watch<WeatherProvider>();
    return SafeArea(
      child: ListTile(
        leading: const SizedBox(
          width: 70,
        ),
        title: TextButton.icon(
          onPressed: () {
            dateModel.setFavorite(context, cityName: dateModel.currenCity);
          },
          icon: const Icon(
            Icons.location_on,
            color: Color(0xFFEB3F4F),
          ),
          label: Text(
            '${dateModel.weatherData?.timezone}',
            style: AppStyle.fontStyle.copyWith(
              color: AppColors.white,
              fontWeight: FontWeight.w200,
            ),
          ),
        ),
        subtitle: Text(
          '${dateModel.date.last} ${dateModel.currentTime}',
          textAlign: TextAlign.center,
          style: AppStyle.fontStyle.copyWith(
            fontSize: 14,
            color: AppColors.white,
            fontWeight: FontWeight.w100,
          ),
        ),
        trailing: IconButton(
          onPressed: () {
            context.push(AppRoutes.search);
          },
          icon: Icon(
            Icons.search,
            color: AppColors.white,
            size: 35,
          ),
        ),
      ),
    );
  }

  // @override
  // Size get preferredSize => const Size(double.infinity, 60);
}

class WeatherAppBody extends StatelessWidget {
  const WeatherAppBody({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<WeatherProvider>();
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage(
            model.setBg(),
          ),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          const WeatherAppBar(),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const CurrentWeatherStatus(),
                  const SizedBox(height: 28),
                  //alt + 0176 = °
                  Text(
                    '${model.currentTemp}°С',
                    textAlign: TextAlign.center,
                    style: AppStyle.fontStyle.copyWith(
                      fontSize: 100,
                      color: AppColors.white,
                      fontWeight: FontWeight.w100,
                    ),
                  ),
                  const SizedBox(height: 40),
                  const TempratureItems(),
                  const SizedBox(height: 40),
                  const ListItems(),
                  const SizedBox(height: 20),
                  const SizedBox(
                    height: 410,
                    child: GridItems(),
                  ),
                  const SizedBox(height: 20),
                  const DayPositionItem(),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
