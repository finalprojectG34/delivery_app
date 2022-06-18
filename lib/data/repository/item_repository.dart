import 'package:delivery_app/data/data_access/item_operation.dart';
import 'package:delivery_app/src/models/shop.dart';

import '../../src/app.dart';

class ItemRepository {
  final ItemOperation itemOperation;

  ItemRepository({required this.itemOperation});

  Future<List<Item>> getItems() async {
    return itemOperation.getItems();
  }

  Future<List<Item>> getFlashSaleItems(int pageIndex, int pageSize) async {
    // return itemOperation.getItems();
    return getMockItems();
  }

  Future<List<Category>> getCategory() async {
    return itemOperation.getCategory();
  }

  Future<bool> getUserShop(String userId) async {
    return itemOperation.getUserShop(userId);
  }

  Future<Item> addItem(variable) async {
    return itemOperation.addItem(variable);
  }

  Future<Shop> addShop({name, description, subCity, city, imageCover}) async {
    return itemOperation.addShop(
      name: name,
      description: description,
      subCity: subCity,
      city: city,
      imageCover: imageCover,
    );
  }

  Future<bool> updateProfile(variable) {
    return itemOperation.updateProfile(variable);
  }

  Future<List<Item>> getMockItems() {
    return Future.delayed(const Duration(seconds: 4), () {
      return List.generate(30, (i) {
        return Item(
            id: "$i",
            category: "Food",
            imagePath:
                "https://www.shutterstock.com/image-photo/young-student-watching-lesson-online-studying-1676998306",
            name: "Item $i",
            description: "Shop $i sells shoes",
            price: "24\$",
            shopId: "1");
      });
    });
  }
}
