import 'package:auto_route/auto_route.dart';
import 'package:rhyme/features/favorites/favorites.dart';
import 'package:rhyme/features/home/home.dart';
import 'package:rhyme/features/poems/poems.dart';
import 'package:rhyme/features/search/search.dart';
import 'package:rhyme/features/settings/settings.dart';

part 'router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: HomeRoute.page, path: '/'),
    AutoRoute(page: FavoriteRoute.page, path: '/favorites'),
    AutoRoute(page: SearchRoute.page, path: '/search'),
    AutoRoute(page: PoemsRoute.page, path: '/poems'),
    AutoRoute(page: SettingsRoute.page, path: '/settings'),
  ];
}
