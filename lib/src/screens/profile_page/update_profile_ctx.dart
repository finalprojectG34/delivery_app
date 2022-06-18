import 'dart:async';

import 'package:delivery_app/data/repository/item_repository.dart';
import 'package:delivery_app/src/screens/home_page/AppCtx.dart';
import 'package:delivery_app/src/utils/loger/console_loger.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

class UpdateProfileController extends GetxController {
  final ItemRepository itemRepository;

  UpdateProfileController({required this.itemRepository});

  final storage = Get.find<FlutterSecureStorage>();
  AppController appController = Get.find();
  RxBool isUpdateProfileLoading = false.obs;
  RxString err = ''.obs;
  RxBool updateError = false.obs;
  bool? isProfileUpdated;

  updateProfile(variable) async {
    isUpdateProfileLoading(true);
    print('var $variable');
    logTrace('phone', variable['input']['phone']);
    try {
      isProfileUpdated = await itemRepository.updateProfile(variable);
      if (isProfileUpdated == true) {
        if (variable['input']['firstName'] != null) {
          await storage.write(
              key: 'firstName', value: variable['input']['firstName']);
          appController.firstName(variable['input']['firstName']);
        }
        if (variable['input']['lastName'] != null) {
          await storage.write(
              key: 'lastName', value: variable['input']['lastName']);
          appController.lastName(variable['input']['lastName']);
        }
        if (variable['input']['phone'] != null) {
          print(variable['phone']);
          await storage.write(key: 'phone', value: variable['input']['phone']);
          appController.phone(variable['input']['phone']);
        }
        EasyLoading.showSuccess('Profile updated successfully',
            dismissOnTap: true, maskType: EasyLoadingMaskType.black);
        Get.back();
      }
    } on TimeoutException catch (e) {
      updateError(true);
      err(e.message);
      EasyLoading.showError(e.message!,
          maskType: EasyLoadingMaskType.black,
          duration: const Duration(seconds: 3));
    } catch (e) {
      updateError(true);
      err('Connection error');
      EasyLoading.showError('Connection error',
          maskType: EasyLoadingMaskType.black,
          duration: const Duration(seconds: 3));
    }
    isUpdateProfileLoading(false);
  }
}
