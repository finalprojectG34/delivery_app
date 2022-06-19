import 'dart:async';
import 'dart:io';

import 'package:delivery_app/data/repository/shop_repository.dart';
import 'package:delivery_app/src/models/models.dart';
import 'package:delivery_app/src/screens/home_page/AppCtx.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../models/shop.dart';

class AddItemController extends GetxController {
  final ShopRepository shopRepository;
  AppController appController = Get.find();

  AddItemController({required this.shopRepository});

  RxBool isCategoryFetchedFromDB = false.obs;
  RxList<Category>? categoryList = <Category>[].obs;

  RxString itemId = ''.obs;
  RxList attributes = [].obs;
  RxMap<String, String> selectedAttributes = <String, String>{}.obs;

  RxMap<String, dynamic>? mockCategory = <String, dynamic>{}.obs;
  RxInt categorySelectPages = 0.obs;
  RxBool isCategoryLoading = true.obs;
  List<String> tempCategories = [];
  RxList<String> selectedCategoryName = <String>[].obs;
  RxBool? userHasShop;
  RxBool isShopLoading = false.obs;
  RxBool isTimedOut = false.obs;
  RxString err = ''.obs;
  RxBool shopImageErr = false.obs;
  RxBool addItemImageErr = false.obs;
  RxBool isShopAdding = false.obs;
  RxBool isItemAdding = false.obs;
  RxBool errOccurred = false.obs;
  RxString shopImageLink = ''.obs;
  RxString itemImageLink = ''.obs;
  final storage = Get.find<FlutterSecureStorage>();

  @override
  void onInit() async {
    super.onInit();
    await getUserShop();
  }

  getUserShop() async {
    isShopLoading(true);
    errOccurred(false);
    try {
      bool hasShop = await shopRepository.getUserShop('');
      userHasShop = hasShop.obs;
    } on TimeoutException catch (e) {
      err(e.message);
      errOccurred(true);
    } catch (e) {
      err('Some error occurred');
      errOccurred(true);
    }

    isShopLoading(false);
  }

  addShop({name, description, subCity, city, required File file}) async {
    isShopLoading(true);
    var imagePath = await imageUpload(file);
    if (imagePath != null) {
      try {
        Shop shop = await shopRepository.addShop(
          name: name,
          description: description,
          subCity: subCity,
          city: city,
          imageCover: imagePath,
        );
        if (shop != null) {
          // await .
          await storage.write(key: 'shopId', value: shop.id);
          appController.hasShopId(true);
          appController.changePage('Pending', 2);
          EasyLoading.showSuccess('Shop created successfully',
              dismissOnTap: true, maskType: EasyLoadingMaskType.black);
        }
      } catch (e) {
        EasyLoading.showError('Some error happened',
            dismissOnTap: true, maskType: EasyLoadingMaskType.black);
      }
    } else {
      shopImageErr(true);
    }
    isShopLoading(false);
  }

  Future<String?> imageUpload(File file) async {
    final storageRef = FirebaseStorage.instance.ref();
    final mountainsRef = storageRef.child(appController.userId.value);

    try {
      await mountainsRef.putFile(file);
      return await mountainsRef.getDownloadURL();
    } on FirebaseException {
      Fluttertoast.showToast(msg: "Uploading failed");
      return null;
    }
  }

  addSelectedAttribute(String key, String value) {
    if (selectedAttributes.isEmpty) {
      selectedAttributes.addEntries(
        [
          MapEntry(
            key,
            value,
          ),
        ],
      );
    } else if (selectedAttributes.containsKey(key)) {
      selectedAttributes.update(key, (val) => value);
    } else {
      selectedAttributes.addEntries(
        [
          MapEntry(
            key,
            value,
          ),
        ],
      );
    }
    print('attrs ${selectedAttributes}');
  }

  changeAttribute(variable) {
    attributes(variable);
  }
}
