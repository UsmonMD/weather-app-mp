import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/backend/hive/favorite_item.dart';
import 'package:weather_app/backend/hive/hive_box.dart';
import 'package:weather_app/backend/provider/weather_provider.dart';
import 'package:weather_app/frontend/style/app_colors.dart';
import 'package:weather_app/frontend/style/app_style.dart';

class FavoriteList extends StatelessWidget {
  const FavoriteList({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ValueListenableBuilder(
        valueListenable:
            Hive.box<FavoriteItem>(HiveBox.favoriteBox).listenable(),
        builder: (context, Box<FavoriteItem> value, _) {
          return ListView.separated(
            padding: const EdgeInsets.all(0),
            itemBuilder: (context, i) {
              return FavoriteCard(
                index: i,
                value: value,
              );
            },
            separatorBuilder: (context, i) => const SizedBox(height: 16),
            itemCount: value.length,
          );
        },
      ),
    );
  }
}

class FavoriteCard extends StatelessWidget {
  const FavoriteCard({
    super.key,
    required this.index,
    required this.value,
  });

  final int index;
  final Box<FavoriteItem> value;

  @override
  Widget build(BuildContext context) {
    final model = context.watch<WeatherProvider>();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: AppColors.white,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CurrentFavoriteItems(
            index: index,
            value: value,
          ),
          CurrentWeatherTemp(
            index: index,
            value: value,
          ),
          IconButton(
            onPressed: () {
              model.delete(index);
            },
            icon: Icon(
              Icons.delete,
              size: 25,
              color: AppColors.red,
            ),
          ),
        ],
      ),
    );
  }
}

class CurrentFavoriteItems extends StatelessWidget {
  const CurrentFavoriteItems({
    super.key,
    required this.index,
    required this.value,
  });
  final int index;
  final Box<FavoriteItem> value;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Текущее место',
          style: AppStyle.fontStyle.copyWith(
            fontSize: 12,
            color: AppColors.white,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          value.getAt(index)?.cityName ?? 'Error',
          style: AppStyle.fontStyle.copyWith(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: AppColors.white,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value.getAt(index)?.timeZone ?? 'Error',
          style: AppStyle.fontStyle.copyWith(
            fontSize: 12,
            color: AppColors.white,
          ),
        ),
      ],
    );
  }
}

class CurrentWeatherTemp extends StatelessWidget {
  const CurrentWeatherTemp({
    super.key,
    required this.index,
    required this.value,
  });
  final int index;
  final Box<FavoriteItem> value;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.network('${value.getAt(index)?.icon}'),
        Text(
          '${value.getAt(index)?.temp} °C',
          style: TextStyle(
            color: AppColors.white,
          ),
        ),
      ],
    );
  }
}
