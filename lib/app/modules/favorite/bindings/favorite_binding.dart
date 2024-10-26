import 'package:favorite/app/modules/favorite/controllers/favorite_controller.dart';
import 'package:get/get.dart';

class FavoritesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FavoritesController>(
      () => FavoritesController(),
    );
  }
}