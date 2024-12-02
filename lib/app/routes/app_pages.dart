import 'package:get/get.dart';

import '../modules/home/bindings/location_binding.dart';
import '../modules/home/views/location_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => LocationView(),
      binding: LocationBinding(),
    ),
  ];
}
