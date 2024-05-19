import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/backend/provider/weather_provider.dart';
import 'package:weather_app/frontend/routes/app_navigator.dart';

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context)=> WeatherProvider(),
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: AppNavigator.routes,
        //Каждый из этих делегатов нужен для поддержки локализации и правильного отображения стандартных элементов пользовательского интерфейса в зависимости от выбранного языка: общих, Material- и Cupertino-специфичных. Например, в Material- и Cupertino-компонентах есть стандартный виджет для выбора даты — соответствующие Material и Cupertino делегаты отвечают за перевод таких стандартных виджетов. Ещё один пример — при выделении текста появляется подсказка: «Вырезать / копировать / вставить», стандартные делегаты отвечают за перевод этого всплывающего окна.
        localizationsDelegates:const [
          GlobalCupertinoLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
      ),
    );
  }
}
