import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreference {
  static SharedPreference? _instance;
  Rx<SharedPreferences?> sharedPreferences = Rx<SharedPreferences?>(null);

  static const String _LAST_POSITION_LAT = 'lastPositionLat';
  static const String _LAST_POSITION_LNG = 'lastPositionLng';
  static const _NOT_FIRST_TIME_USER = "first_time_user";
  static const _EMAIL_ID = "emailId";
  static const _PASSWORD = "password";
  static const _USER_ID = "userId";
  static const _IS_BOOTH_MANAGER = "isBoothManager";
  static const _MOB_NUM = "mobNum";
  static const _AUTHENTICATED = "authenticated";
  static const _FIRSTNAME = "firstname";
  static const _LASTNAME = "lastname";
  static const _PROFILE_PIC = "PROFILE_PIC";
  static const _PARENT_ID = "parentId";
  static const _UUID = "uuid";
  static const _LOYALTYTOKEN = "loyaltyToken";

  Future<SharedPreference?> getInstance() async {
    if (_instance == null) {
      _instance = SharedPreference();
    }
    if (sharedPreferences.value == null) {
      sharedPreferences.value = await SharedPreferences.getInstance();
    }
    return _instance;
  }

  void setUserAuthenticated(bool authenticated) {
    sharedPreferences.value!.setBool(_AUTHENTICATED, authenticated);
  }

  void setNotFirstTimeUser() {
    sharedPreferences.value!.setBool(_NOT_FIRST_TIME_USER, false);
  }

  bool? getIsFirstTimeUser() {
    return sharedPreferences.value!.getBool(_NOT_FIRST_TIME_USER);
  }

  void setLoyaltyToken(String token) {
    sharedPreferences.value!.setString(_LOYALTYTOKEN, token);
  }

  //save email and password
  void saveUserLogin(
      String email, String password, String userId, bool isBoothManager) {
    sharedPreferences.value!.setString(_EMAIL_ID, email);
    sharedPreferences.value!.setString(_MOB_NUM, email);
    sharedPreferences.value!.setString(_PASSWORD, password);
    sharedPreferences.value!.setString(_USER_ID, userId);
    sharedPreferences.value!.setBool(_IS_BOOTH_MANAGER, isBoothManager);
  }

  //save email and password
  void saveUserLocation(
    double lat,
    double lng,
  ) {
    if (sharedPreferences.value != null) {
      sharedPreferences.value!.setDouble(_LAST_POSITION_LAT, lat);
      sharedPreferences.value!.setDouble(_LAST_POSITION_LNG, lng);
      return;
    }
  }

  void deleteUserLogin() {
    sharedPreferences.value!.remove(_EMAIL_ID);
    sharedPreferences.value!.remove(_PASSWORD);
    sharedPreferences.value!.remove(_MOB_NUM);
    sharedPreferences.value!.remove(_USER_ID);
    sharedPreferences.value!.remove(_IS_BOOTH_MANAGER);
    sharedPreferences.value!.remove(_LOYALTYTOKEN);
    sharedPreferences.value!.remove(_FIRSTNAME);
    sharedPreferences.value!.remove(_LASTNAME);
  }

  String? getUserId() {
    return sharedPreferences.value!.getString(_USER_ID);
  }

  bool getUserLoginDetails() {
    String? email;
    String? password;
    String? mobNum;
    bool? isBoothManager;

    if (sharedPreferences.value != null) {
      email = sharedPreferences.value!.getString(_EMAIL_ID);
      password = sharedPreferences.value!.getString(_PASSWORD);
      mobNum = sharedPreferences.value!.getString(_MOB_NUM);
      isBoothManager = sharedPreferences.value!.getBool(_IS_BOOTH_MANAGER);
    }

    if (email != null && password != null) {
      return true;
    }
    if (mobNum != null) {
      return true;
    } else {
      return false;
    }
  }

  String? getemail() {
    return sharedPreferences.value!.getString(_EMAIL_ID);
  }

  /// Get the booth manager status value
  bool? getBoothManager() {
    return sharedPreferences.value!.getBool(_IS_BOOTH_MANAGER) ?? false;
  }

  String? getPassword() {
    return sharedPreferences.value!.getString(_PASSWORD);
  }

  loadData() {
    List<dynamic>? listString = sharedPreferences.value!.getStringList('list');
    if (listString != null) {
      listString.map((item) => item.fromMap(json.decode(item))).toList();

      // setState((){});
    }
    return listString;
  }

  void saveUserSignUp(String firstname, String lastname, String mobilenum,
      String email, String password, bool isBoothManager) {
    sharedPreferences.value!.setString(_FIRSTNAME, firstname);
    sharedPreferences.value!.setString(_LASTNAME, lastname);
    sharedPreferences.value!.setString(_MOB_NUM, mobilenum);
    sharedPreferences.value!.setString(_EMAIL_ID, email);
    sharedPreferences.value!.setBool(_IS_BOOTH_MANAGER, isBoothManager);
    sharedPreferences.value!.setString(_PASSWORD, password);
  }

  void saveUserInfo(String? firstname, String? lastname, String? mobilenum,
      String? password) {
    if (firstname != null) {
      sharedPreferences.value!.setString(_FIRSTNAME, firstname);
    }
    if (lastname != null) {
      sharedPreferences.value!.setString(_LASTNAME, lastname);
    }
    if (mobilenum != null) {
      sharedPreferences.value!.setString(_MOB_NUM, mobilenum);
    }
    if (password != null) {
      sharedPreferences.value!.setString(_PASSWORD, password);
    }
  }

  bool getUserSignupDetails() {
    String? firstName;
    String? lastName;
    String? email;
    String? password;
    String? mobNum;
    bool? isBoothManager;

    if (sharedPreferences.value != null) {
      firstName = sharedPreferences.value!.getString(_FIRSTNAME);
      lastName = sharedPreferences.value!.getString(_LASTNAME);
      mobNum = sharedPreferences.value!.getString(_MOB_NUM);
      email = sharedPreferences.value!.getString(_EMAIL_ID);
      isBoothManager = sharedPreferences.value!.getBool(_IS_BOOTH_MANAGER);
      password = sharedPreferences.value!.getString(_PASSWORD);
    }

    if (firstName != null &&
        lastName != null &&
        mobNum != null &&
        email != null &&
        password != null) {
      return true;
    } else {
      return false;
    }
  }

  String? getUuId() {
    return sharedPreferences.value!.getString(_UUID);
  }

  setUuId(String uuid) {
    sharedPreferences.value!.setString(_UUID, uuid);
  }

  String? getUserfirstName() {
    return sharedPreferences.value!.getString(_FIRSTNAME);
  }

  String? getUserlastName() {
    return sharedPreferences.value!.getString(_LASTNAME);
  }

  String? getUsermobNum() {
    return sharedPreferences.value!.getString(_MOB_NUM);
  }

  String? getUserEmailId() {
    return sharedPreferences.value!.getString(_EMAIL_ID);
  }

  String? getUserPassword() {
    return sharedPreferences.value!.getString(_PASSWORD);
  }

  saveMobileNum(String? mobilenum) {
    sharedPreferences.value!.setString(_MOB_NUM, mobilenum!);
  }

  String? getMobileNum() {
    return sharedPreferences.value!.getString(_MOB_NUM);
  }

  savefirstName(String? firstName) {
    sharedPreferences.value!.setString(_FIRSTNAME, firstName!);
  }

  String? getfirstName() {
    return sharedPreferences.value!.getString(_FIRSTNAME);
  }

  savelastName(String? lastName) {
    sharedPreferences.value!.setString(_LASTNAME, lastName!);
  }

  String? getlastName() {
    return sharedPreferences.value!.getString(_LASTNAME);
  }

  void saveProfilePic(String? profilePic) {
    sharedPreferences.value!.setString(_PROFILE_PIC, profilePic!);
  }

  String? getUserProfilePic() {
    return sharedPreferences.value!.getString(_PROFILE_PIC);
  }

  void saveParentId(String? id) {
    sharedPreferences.value!.setString(_PARENT_ID, id!);
  }

  Future<String?> getParentId() async {
    return sharedPreferences.value!.getString(_PARENT_ID);
  }

  void saveCartItemLength(String value) {
    sharedPreferences.value!.setString("CART_LENGTH", value);
  }

  String? getCartItemLength() {
    return sharedPreferences.value!.getString("CART_LENGTH");
  }

  String? getLoyaltyToken() {
    return sharedPreferences.value!.getString(_LOYALTYTOKEN);
  }

  bool isLoyaltyLoggedIn() {
    if (getLoyaltyToken() != null) {
      return true;
    }
    return false;
  }

  void saveCurrencyCode(String? currencyCode) {
    sharedPreferences.value!.setString("CURRENCY_CODE", currencyCode!);
  }

  Future<String?> getCurrencyCode() async {
    return sharedPreferences.value!.getString("CURRENCY_CODE");
  }

  void saveForgotPswdParentId(String? id) {
    sharedPreferences.value!.setString('forgotParentId', id!);
  }

  Future<String?> getForgotPswdParentId() async {
    return sharedPreferences.value!.getString('forgotParentId');
  }
}
