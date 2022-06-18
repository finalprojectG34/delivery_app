import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

import '../../../../data/repository/user_repository.dart';
import '../../../models/user.dart' as user;
import '../../home_page/AppCtx.dart';
import '../verification/code_verification.dart';

class SignUpController extends GetxController {
  final UserRepository userRepository;

  SignUpController({required this.userRepository});

  RxBool isLoading = false.obs;
  RxBool isVerificationLoading = false.obs;
  RxBool isUserCreatedSuccessfully = false.obs;
  RxBool error = false.obs;
  String verificationId = "";

  user.User? createdUser;
  final storage = Get.find<FlutterSecureStorage>();
  var userVariable;

  sendOtp(variable) async {
    userVariable = variable;
    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+251900000000',
        // phoneNumber: variable['token']['phone'],
        verificationCompleted: (PhoneAuthCredential credential) {},
        verificationFailed: (FirebaseAuthException e) {
          // EasyLoading.dismiss();
          print(e.message);
          EasyLoading.showError(e.message ?? "Something went wrong. Try Again",
              dismissOnTap: true, maskType: EasyLoadingMaskType.black);
        },
        codeSent: (verificationId, [resendToken]) {
          this.verificationId = verificationId;
          EasyLoading.dismiss();
          Get.to(
            () => CodeVerification(
              redirectFrom: 'signUp',
            ),
          );
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          EasyLoading.dismiss();
          // EasyLoading.showError('Timeout. Try again',
          //     maskType: EasyLoadingMaskType.black);
        },
        timeout: const Duration(seconds: 60),
      );
    } catch (e) {
      // EasyLoading.dismiss();
      EasyLoading.showError(e.toString(),
          maskType: EasyLoadingMaskType.black,
          duration: const Duration(seconds: 3));
    } finally {}
  }

  signUp(String smsCode) {
    EasyLoading.show(
      status: 'please wait ...',
      maskType: EasyLoadingMaskType.black,
    );

    var token;
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: smsCode);
    FirebaseAuth.instance.authStateChanges().listen((event) async {
      token ??= await event?.getIdToken();

      print('**************************** $token');
    });
    FirebaseAuth.instance
        .signInWithCredential(credential)
        .then((UserCredential result) async {
      if (token != null) {
        userVariable['token']['idToken'] = token;
        print("token found successfully");
        await signupUser(userVariable);

        if (createdUser != null) {
          await storage.write(key: 'token', value: createdUser?.token);
          await storage.write(key: 'userId', value: createdUser?.id);
          await storage.write(key: 'firstName', value: createdUser?.firstName);
          await storage.write(key: 'lastName', value: createdUser?.lastName);
          await storage.write(key: 'phone', value: createdUser?.phone);
          await storage.write(key: 'role', value: createdUser?.role);

          EasyLoading.showSuccess('Account created successfully',
              dismissOnTap: true, maskType: EasyLoadingMaskType.black);
          AppController appController = Get.find();
          appController.changePage('Home', 0);
          appController.isAuthenticated(true);
          Get.offNamed('/');
        }
      } else {
        EasyLoading.showError('Some error occurred',
            dismissOnTap: true, maskType: EasyLoadingMaskType.black);
        Get.back();
      }
    }).catchError((e) {
      EasyLoading.showError(e, maskType: EasyLoadingMaskType.black);
      Get.back();
    });
  }

  signupUser(variable) async {
    // print(userVariable);
    isLoading(true);
    try {
      createdUser = await userRepository.signupUser(userVariable);
      print("SignUp successfully");
    } on TimeoutException catch (e) {
      EasyLoading.showError(e.message!,
          dismissOnTap: true,
          maskType: EasyLoadingMaskType.black,
          duration: const Duration(seconds: 3));
    } catch (e) {
      print("error  $e  ------------------------------------");
      EasyLoading.showError('Some error occurred. Please try again',
          dismissOnTap: true,
          maskType: EasyLoadingMaskType.black,
          duration: const Duration(seconds: 3));
      Get.back();
    }
  }
}
