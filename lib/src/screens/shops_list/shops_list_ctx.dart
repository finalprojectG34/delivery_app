import 'package:delivery_app/data/repository/shop_repository.dart';
import 'package:delivery_app/src/models/shop.dart';
import 'package:get/get.dart';

class ShopsListController extends GetxController {
  var isLoading = false.obs;
  var errorOccurred = false.obs;
  var shopsList = Rx<List<Shop>?>(null);
  final ShopRepository shopRepository;

  Rx<Shop> shop = const Shop().obs;

  ShopsListController({required this.shopRepository});

  Future<List<Shop>?> getShops(int pageIndex, int pageSize) async {
    if (pageIndex < 1) {
      isLoading(true);
    }
    try {
      final shops = await shopRepository.getShops(pageSize, pageIndex);
      shopsList.value = shops;
      return shops;
    } catch (e) {
      errorOccurred(true);
    } finally {
      isLoading(false);
    }
    return null;
  }

  getShopByRole(String role) async {
    isLoading(true);
    try {
      final shops = await shopRepository.getShopByRole(role);
      shopsList(shops);
    } catch (e) {
      print(e);
      errorOccurred(true);
    } finally {
      isLoading(false);
    }
  }

  getShopById(String shopId) async {
    isLoading(true);
    try {
      Shop newShop = await shopRepository.getShopById(shopId);
      shop(newShop);
    } catch (e) {
      print(e);
      errorOccurred(true);
    }
    isLoading(false);
  }
}
