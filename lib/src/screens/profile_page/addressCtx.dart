import 'dart:async';

import 'package:delivery_app/src/models/models.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

import '../../../data/repository/user_repository.dart';

class AddressController extends GetxController {
  final UserRepository userRepository;

  AddressController({required this.userRepository});

  final storage = Get.find<FlutterSecureStorage>();

  RxBool isChangePasswordLoading = false.obs;
  RxString err = ''.obs;
  RxBool passwordError = false.obs;
  bool? isPasswordUpdated;

  RxString country = ''.obs;
  RxString city = ''.obs;
  RxString subCity = ''.obs;
  RxString streetName = ''.obs;

  User? authUser;

  @override
  void onInit() {
    super.onInit();
    getUserAddress();
  }

  getUserAddress() async {
    try {
      authUser = await userRepository.getMe();

      if (authUser != null) {
        country('Ethiopia');
        city(authUser?.address?.city);
        subCity(authUser?.address?.subCity);
        streetName(authUser?.address?.addressName);
      } else {
        EasyLoading.showError('Some error happened',
            dismissOnTap: true, maskType: EasyLoadingMaskType.black);
      }
    } catch (e) {
      EasyLoading.showError('Some error happened',
          dismissOnTap: true, maskType: EasyLoadingMaskType.black);
    }
  }

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
