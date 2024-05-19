import 'package:go_router/go_router.dart';
import 'package:weather_app/frontend/pages/home_page.dart';
import 'package:weather_app/frontend/pages/search_page.dart';
import 'package:weather_app/frontend/routes/app_routes.dart';

abstract class AppNavigator {
  static final GoRouter _routes = GoRouter(
    routes: [
      GoRoute(
        path: AppRoutes.home,
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: AppRoutes.search,
        builder: (context, state) => const SearchPage(),
      ),
    ],
  );

 static GoRouter get routes => _routes;
}


