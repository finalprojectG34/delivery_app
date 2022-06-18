import 'package:delivery_app/data/repository/user_repository.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

import '../../models/user.dart';

class ProfilePageController extends GetxController {
  final UserRepository userRepository;

  final storage = Get.find<FlutterSecureStorage>();

  ProfilePageController({required this.userRepository});

  Rx<Address>? address = Address().obs;

  RxBool errOccurred = false.obs;
  RxString errorText = "".obs;
  RxBool isProfileLoading = false.obs;

  @override
  void onInit() async {
    super.onInit();
    await getUserAddress();
  }

  Future<bool> getUserAddress() async {
    if (await storage.read(key: "country") == null) {
      return false;
    } else {
      Address temp = Address(
        addressName: await storage.read(key: "addressName"),
        city: await storage.read(key: "city"),
        country: await storage.read(key: "country"),
        subCity: await storage.read(key: "subCity"),
      );
      address!(temp);
    }
    return false;
  }

  setUserAddress(Address? _address) async {
    await storage.write(key: "country", value: _address?.country);
    await storage.write(key: "city", value: _address?.city);
    await storage.write(key: "subCity", value: _address?.subCity);
    await storage.write(key: "addressName", value: _address?.addressName);

    getUserAddress();
  }

  updateUserAddress(Address _address) async {
    isProfileLoading(true);
    try {
      Address temp = await userRepository.updateUserAddress(_address);
      address!(temp);

      await setUserAddress(temp);
      getUserAddress();
    } catch (e) {
      errOccurred(true);
      errorText("Please try again!");
    }
    isProfileLoading(false);
  }
}
