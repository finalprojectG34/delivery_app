import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../../../../data/repository/user_repository.dart';
import '../../home_page/AppCtx.dart';
import '../verification/code_verification.dart';

class ResetController extends GetxController {
  final UserRepository userRepository;

  ResetController({required this.userRepository});

  String verificationId = "";
  String? password;
  String? serverToken;

  sendOtp(String phone) async {
    // userVariable = variable;
    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phone,
        verificationCompleted: (PhoneAuthCredential credential) {},
        verificationFailed: (FirebaseAuthException e) {
          EasyLoading.dismiss();
          EasyLoading.showError(e.message ?? "Something went wrong. Try Again",
              maskType: EasyLoadingMaskType.black);
        },
        codeSent: (verificationId, [resendToken]) {
          this.verificationId = verificationId;
          EasyLoading.dismiss();
          Get.to(
            () => CodeVerification(
              redirectFrom: 'reset',
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
      EasyLoading.dismiss();
      EasyLoading.showError(e.toString(),
          maskType: EasyLoadingMaskType.black,
          duration: const Duration(seconds: 5));
    } finally {}
  }

  verifyCode(String smsCode) {
    EasyLoading.show(
      status: 'please wait ...',
      maskType: EasyLoadingMaskType.black,
    );

    var token;
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: smsCode);
    FirebaseAuth.instance.authStateChanges().listen((event) async {
      token ??= await event?.getIdToken();

      print('hhhhhhhhhhhhhhhhhhhhhhhhhhh $token');
    });
    FirebaseAuth.instance
        .signInWithCredential(credential)
        .then((UserCredential result) async {
      if (token != null) {
        // userVariable['token']['idToken'] = token;
        // userVariable['token']['phone'] = '+251923232323';
        await reset(token);
        if (serverToken != null) {
          EasyLoading.showSuccess('Password reseted successfully',
              maskType: EasyLoadingMaskType.black);
          AppController appController = Get.find();
          appController.changePage('Account', 4);
        }
      } else {
        EasyLoading.showError('Some error occurred',
            maskType: EasyLoadingMaskType.black);
        Get.back();
      }
    }).catchError((e) {
      EasyLoading.showError(e, maskType: EasyLoadingMaskType.black);
      Get.back();
    });
  }

  reset(String token) async {
    // print(userVariable);
    // isLoading(true);
    try {
      serverToken = await userRepository.reset(password!, token);
    } catch (e) {
      EasyLoading.showError('Some error occurred. Please try again',
          maskType: EasyLoadingMaskType.black,
          duration: const Duration(seconds: 3));
      Get.back();
    }
  }
}
