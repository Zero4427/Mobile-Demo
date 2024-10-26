import 'package:get/get.dart';
import '../../../data/models/product_model.dart';

class FavoritesController extends GetxController {
  final RxList<Product> products = <Product>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadProducts();
  }

  void loadProducts() {
    products.value = [
      Product(name: 'Splash some color', color: '', price: 900000),
      Product(name: 'Splash some color', color: 'Pink', price: 900000),
      Product(name: 'Splash some color', color: 'Yellow', price: 900000),
      Product(name: 'Splash some color', color: 'Black', price: 900000),
    ];
  }

  void removeProduct(int index) {
    products.removeAt(index);
    update();
    Get.snackbar(
      'Success',
      'Item removed from favorites',
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 2),
    );
  }

  void toggleFavorite(int index) {
    products[index].isFavorite = !products[index].isFavorite;
    products.refresh();
  }
}