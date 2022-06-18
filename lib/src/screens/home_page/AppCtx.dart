import 'package:delivery_app/data/repository/item_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

import '../../app.dart';
import '../auth/login/login.dart';

class AppController extends GetxController {
  final ItemRepository itemRepository;

  AppController({required this.itemRepository});

  final storage = Get.find<FlutterSecureStorage>();
  RxBool hasSearchIcon = true.obs;
  RxString pageName = 'Home'.obs;
  RxInt selectedIndex = 0.obs;
  RxBool isSearchBarActive = false.obs;
  RxBool isAuthenticated = false.obs;
  RxBool isGettingItems = false.obs;
  RxBool getItemError = false.obs;
  RxString err = ''.obs;
  RxList<Item>? itemList;
  FocusNode searchBarFocusNode = FocusNode();

  RxString userId = ''.obs;
  RxString firstName = ''.obs;
  RxString lastName = ''.obs;
  RxString phone = ''.obs;
  RxString role = ''.obs;
  RxBool hasShopId = false.obs;
  RxString userRole = ''.obs;

  @override
  void onInit() async {
    super.onInit();

    String? value = await storage.read(key: 'token');
    if (value != null) {
      isAuthenticated(true);
      getUserInfo();
      getShopId();
    } else {
      Get.to(() => Login());
    }
  }

  getShopId() async {
    hasShopId(await storage.read(key: 'shopId') != null);
    userRole(await storage.read(key: 'role'));
    // hasShopId(true);
    // userRole('SELLER');
    // userRole = 'SELLER';
    // hasShopId = true;
  }

  changePage(String name, int index) {
    pageName(name);
    selectedIndex(index);
  }

  getUserInfo() async {
    String? _id = await storage.read(key: 'userId');
    String? _firstName = await storage.read(key: 'firstName');
    String? _lastName = await storage.read(key: 'lastName');
    String? _phone = await storage.read(key: 'phone');
    String? _role = await storage.read(key: 'role');

    userId(_id);
    firstName(_firstName);
    lastName(_lastName);
    phone(_phone);
    role(_role);
  }

  logout() async {
    await storage.deleteAll();
    isAuthenticated(false);
    Get.offAllNamed('/');
  }
}
