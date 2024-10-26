import 'package:favorite/app/modules/favorite/bindings/favorite_binding.dart';
import 'package:favorite/app/modules/favorite/views/favorite_view.dart';
import 'package:get/get.dart';

part 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.FAVORITES;

  static final routes = [
    GetPage(
      name: Routes.FAVORITES,
      page: () => const FavoritesView(),
      binding: FavoritesBinding(),
    ),
  ];
}