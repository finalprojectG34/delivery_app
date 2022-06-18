import 'package:delivery_app/src/app.dart';
import 'package:get/get.dart';

import '../../../data/repository/item_repository.dart';

class ItemListController extends GetxController {
  var isLoading = false.obs;
  var errorOccurred = false.obs;
  var itemList = Rx<List<Item>?>(null);
  final ItemRepository itemRepository;

  ItemListController({required this.itemRepository});

  Future<List<Item>?> getItems(int pageIndex, int pageSize) async {
    if (pageIndex < 1) {
      isLoading(true);
    }
    try {
      final items = await itemRepository.getFlashSaleItems(pageSize, pageIndex);
      itemList.value = items;
      return items;
    } catch (e) {
      errorOccurred(true);
    } finally {
      isLoading(false);
    }
    return null;
  }
}
