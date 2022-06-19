import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../../data/repository/user_repository.dart';
import '../../app.dart';
import '../auth/login/login.dart';

class AppController extends GetxController {
  final UserRepository userRepository;

  AppController({required this.userRepository});

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
  RxBool hasShopId = false.obs;
  RxString userRole = ''.obs;
  RxString userImageLink = ''.obs;

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
    getMe();
    if (hasShopId.isTrue) {}
    // userRole(await storage.read(key: 'role'));

    // hasShopId(false);
    // userRole('SELLER');
    // userRole = 'SELLER';
    // hasShopId = true;
  }

  changePage(String name, int index) {
    pageName(name);
    selectedIndex(index);
  }

  getMe() async {
    try {
      User user = await userRepository.getMe();
      String? role = user.role;
      String? img = user.image;
      hasShopId(user.shopId != "" || user.shopId != null);
      if (role != null) {
        userRole(role);
      }
      if (img != null) {
        userImageLink(img);
      }
    } catch (e) {
      EasyLoading.showError('Some error happened',
          dismissOnTap: true, maskType: EasyLoadingMaskType.black);
    }
  }

  Future<String?> imageUpload(File file) async {
    final storageRef = FirebaseStorage.instance.ref();
    final mountainsRef = storageRef.child(userId.value + 'imgLink');

    try {
      await mountainsRef.putFile(file);
      return await mountainsRef.getDownloadURL();
    } on FirebaseException {
      Fluttertoast.showToast(msg: "Uploading failed");
      return null;
    }
  }

  updateProfilePic(File file) async {
    String? tempImgLink = await imageUpload(file);
    bool? imgLink = await userRepository.updateProfile({
      "input": {
        "image": {"imageCover": tempImgLink}
      }
    });
    if (imgLink != null) {
      userImageLink(tempImgLink);
    }
  }

  getUserInfo() async {
    String? _id = await storage.read(key: 'userId');
    String? _firstName = await storage.read(key: 'firstName');
    String? _lastName = await storage.read(key: 'lastName');
    String? _phone = await storage.read(key: 'phone');

    userId(_id);
    firstName(_firstName);
    lastName(_lastName);
    phone(_phone);
    userImageLink(await storage.read(key: 'userImg'));
  }

  logout() async {
    await storage.deleteAll();
    isAuthenticated(false);
    Get.offAllNamed('/');
  }
}
