import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/backend/provider/weather_provider.dart';
import 'package:weather_app/frontend/components/current_region_item.dart';
import 'package:weather_app/frontend/components/favorite_list.dart';
import 'package:weather_app/frontend/style/app_colors.dart';
import 'package:weather_app/frontend/style/app_style.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<WeatherProvider>();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: AppColors.white,
            size: 26,
          ),
        ),
        title: SizedBox(
          width: 312,
          height: 35,
          child: TextField(
            controller: model.searchController,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: AppColors.white),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              fillColor: AppColors.inputColor,
              filled: true,
              hintText: 'Введите город/регион',
              hintStyle: AppStyle.fontStyle.copyWith(
                fontSize: 14,
                color: AppColors.white,
              ),
              contentPadding: const EdgeInsets.symmetric(
                vertical: 5,
                horizontal: 15,
              ),
            ),
            style: TextStyle(color: AppColors.white),
            cursorColor: AppColors.white,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              model.setCurrentCity(context);
            },
            icon: Icon(
              Icons.search,
              size: 34,
              color: AppColors.white,
            ),
          ),
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: SearchBody(model: model),
    );
  }
}

class SearchBody extends StatelessWidget {
  const SearchBody({super.key, required this.model});

  final WeatherProvider model;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage(
            model.setBg(),
          ),
        ),
      ),
      padding: const EdgeInsets.only(top: 70, left: 16, right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          const CurrentRegionItem(),
          const SizedBox(height: 20),
          Center(
            child: Text(
              'Избранное',
              textAlign: TextAlign.center,
              style: AppStyle.fontStyle.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: AppColors.white,
              ),
            ),
          ),
          const SizedBox(height: 16),
          const FavoriteList(),
        ],
      ),
    );
  }
}
