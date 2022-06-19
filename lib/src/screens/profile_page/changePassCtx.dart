import 'dart:async';

import 'package:delivery_app/data/repository/user_repository.dart';
import 'package:delivery_app/src/screens/home_page/AppCtx.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

class ChangePasswordController extends GetxController {
  final UserRepository userRepository;

  ChangePasswordController({required this.userRepository});

  final storage = Get.find<FlutterSecureStorage>();
  AppController appController = Get.find();
  RxBool isChangePasswordLoading = false.obs;
  RxString err = ''.obs;
  RxBool passwordError = false.obs;
  bool? isPasswordUpdated;

  changePassword(variable) async {
    isChangePasswordLoading(true);

    try {
      isPasswordUpdated = await userRepository.updatePassword(variable);
      if (isPasswordUpdated == true) {
        EasyLoading.showSuccess('Password changed successfully',
            dismissOnTap: true, maskType: EasyLoadingMaskType.black);
        Get.back();
      }
    } on TimeoutException catch (e) {
      passwordError(true);
      err(e.message);
      EasyLoading.showError(e.message!,
          maskType: EasyLoadingMaskType.black,
          duration: const Duration(seconds: 2));
    } catch (e) {
      passwordError(true);
      // err('Connection error');
      EasyLoading.showError(e.toString(),
          maskType: EasyLoadingMaskType.black,
          duration: const Duration(seconds: 2));
    }
    isChangePasswordLoading(false);
  }
}
