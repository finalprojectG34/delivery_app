import 'package:delivery_app/src/screens/auth/reset_password/resetCtx.dart';
import 'package:delivery_app/src/screens/auth/signup/signupCtx.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../login/loginCtx.dart';

class CodeVerification extends StatelessWidget {
  CodeVerification({Key? key, required this.redirectFrom}) : super(key: key);
  final txtController = TextEditingController();

  // final formState = GlobalKey<FormState>();
  final String redirectFrom;
  LoginController? loginController;
  SignUpController? signUpController;
  ResetController? resetController;

  // var variable;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        EasyLoading.dismiss();
        return true;
      },
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          // resizeToAvoidBottomInset: false,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: ListView(
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 100),
                ),
                const Text(
                  "Code Verification",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 30,
                ),

                TextFormField(
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(10),
                    hintText: "Enter Code",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                        borderSide:
                            BorderSide(color: Colors.grey[200]!, width: 1)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                        borderSide:
                            BorderSide(color: Colors.grey[200]!, width: 1)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                        borderSide:
                            BorderSide(color: Colors.grey[200]!, width: 1)),
                  ),
                  controller: txtController,
                  maxLines: 1,
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(
                  height: 40,
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    shadowColor:
                        MaterialStateProperty.all(Colors.lightBlueAccent),
                    elevation: MaterialStateProperty.all(5),
                    backgroundColor:
                        MaterialStateProperty.all(const Color(0xff40BFFF)),
                    fixedSize:
                        MaterialStateProperty.all(Size(Get.width * 0.45, 54)),
                  ),
                  onPressed: () async {
                    redirectFrom == 'signIn'
                        ? loginController = Get.find<LoginController>()
                        : redirectFrom == 'signUp'
                            ? signUpController = Get.find<SignUpController>()
                            : resetController = Get.find<ResetController>();
                    FocusScope.of(context).unfocus();
                    redirectFrom == 'signIn'
                        ? await loginController
                            ?.signIn(txtController.text.toString())
                        : redirectFrom == 'signUp'
                            ? await signUpController
                                ?.signUp(txtController.text.toString())
                            : await resetController
                                ?.verifyCode(txtController.text.toString());

                    // ctx.signIn(txtController.text.toString());

                    // Get.offAll(() => App());
                    // Na
                    // Navigator.of(context)
                    //     .pushNamedAndRemoveUntil('/',ModalRoute.withName("/"));
                    // if(signUpController!.isUserCreatedSuccessfully.isTrue){
                    //   Fluttertoast.showToast(
                    //       msg: 'Account successfully created');
                    // }
                    // AppController appCtx = Get.find();
                    // appCtx.selectedIndex(0);
                    // Get.offNamedUntil("/", ModalRoute.withName("/"));
                  },
                  child: const Text(
                    "Verify Code",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 13),
                  ),
                ),
                // const SizedBox(
                //   height: 20,
                // ),
                // // const Spacer(),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     const Text(
                //       "Have an account",
                //       style: TextStyle(color: Colors.grey),
                //     ),
                //     TextButton(
                //       onPressed: () {},
                //       child: const Text(
                //         "Sign in",
                //         style: TextStyle(
                //             color: Color(0xff40BFFF),
                //             fontWeight: FontWeight.bold,
                //             fontSize: 13),
                //       ),
                //     ),
                //   ],
                // ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     const Text(
                //       "Don't have an account",
                //       style: TextStyle(color: Colors.grey),
                //     ),
                //     TextButton(
                //       onPressed: () {},
                //       child: const Text(
                //         "Register",
                //         style: TextStyle(
                //             color: Color(0xff40BFFF),
                //             fontWeight: FontWeight.bold,
                //             fontSize: 13),
                //       ),
                //     ),
                //   ],
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
