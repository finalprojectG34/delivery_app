import 'package:delivery_app/src/utils/loger/console_loger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../../../packages/validators.dart';
import '../reset_password/reset_password.dart';
import '../signup/signup.dart';
import 'loginCtx.dart';

class Login extends StatelessWidget {
  Login({Key? key}) : super(key: key);
  final TextEditingController phoneCtrl = TextEditingController();
  final TextEditingController passCtrl = TextEditingController();
  final GlobalKey<FormState> formState = GlobalKey<FormState>();
  final LoginController loginController = Get.find();

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
          body: Form(
            key: formState,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  children: [
                    const Padding(padding: EdgeInsets.only(top: 30)),

                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "Welcome",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "Sign in to continue",
                      style: TextStyle(),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                        decoration: InputDecoration(
                          // prefixIcon: const Icon(Icons.email_outlined),
                          prefixIcon: const SizedBox(
                            width: 50,
                            child: Center(
                                child: Text(
                              "+251",
                              style: TextStyle(fontSize: 17),
                            )),
                          ),
                          contentPadding: const EdgeInsets.all(10),
                          hintText: "Your Phone",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6),
                              borderSide: BorderSide(
                                  color: Colors.grey[200]!, width: 1)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6),
                              borderSide: BorderSide(
                                  color: Colors.grey[200]!, width: 1)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6),
                              borderSide: BorderSide(
                                  color: Colors.grey[200]!, width: 1)),
                        ),
                        maxLines: 1,
                        controller: phoneCtrl,
                        keyboardType: TextInputType.phone,
                        validator: validateMobileNum),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      validator: validatePassword,
                      controller: passCtrl,
                      obscureText: true,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.lock),
                        contentPadding: const EdgeInsets.all(10),
                        hintText: "Password",
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
                      maxLines: 1,
                      // keyboardType: TextInputType,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                        style: ButtonStyle(
                          shadowColor:
                              MaterialStateProperty.all(Colors.lightBlueAccent),
                          elevation: MaterialStateProperty.all(6),
                          backgroundColor: MaterialStateProperty.all(
                              const Color(0xff40BFFF)),
                          fixedSize:
                              MaterialStateProperty.all(Size(Get.width, 54)),
                        ),
                        onPressed: () async {
                          if (formState.currentState!.validate()) {
                            FocusScope.of(context).unfocus();

                            EasyLoading.instance.loadingStyle =
                                EasyLoadingStyle.light;
                            await EasyLoading.show(
                              status: 'Please wait',
                              maskType: EasyLoadingMaskType.black,
                            );

                            logTrace("loginValue", phoneCtrl.text.toString());
                            // ctx.sendOtp("+251" + phoneCtrl.text.toString());
                            loginController.signInUser({
                              "input": {
                                "info": '+251${phoneCtrl.text.toString()}',
                                "info_type": "phone",
                                "password": passCtrl.text.toString()
                              }
                            });
                          }
                        },
                        child: const Text(
                          "Sign in",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 13),
                        )),
                    const SizedBox(
                      height: 10,
                    ),

                    // Row(
                    //   children: [
                    //     const Expanded(
                    //       child: Divider(
                    //         thickness: 0.5,
                    //         height: 0.5,
                    //       ),
                    //     ),
                    //     Container(
                    //       margin: const EdgeInsets.symmetric(horizontal: 10),
                    //       child: const Text(
                    //         "OR",
                    //         style: TextStyle(
                    //             fontWeight: FontWeight.bold, color: Colors.grey),
                    //       ),
                    //     ),
                    //     const Expanded(
                    //       child: Divider(
                    //         thickness: 0.5,
                    //         height: 0.5,
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    // const SizedBox(
                    //   height: 20,
                    // ),
                    // ElevatedButton(
                    //   style: ButtonStyle(
                    //     shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    //         side: BorderSide(color: Colors.grey[200]!),
                    //         borderRadius: BorderRadius.circular(8))),
                    //     elevation: MaterialStateProperty.all(0),
                    //     backgroundColor:
                    //         MaterialStateProperty.all(Colors.transparent),
                    //     fixedSize: MaterialStateProperty.all(Size(Get.width, 54)),
                    //   ),
                    //   onPressed: () {},
                    //   child: Row(
                    //     children: const [
                    //       FaIcon(FontAwesomeIcons.google, color: Colors.lightBlue),
                    //       Expanded(
                    //         child: Center(
                    //           child: Text(
                    //             "Login with Google",
                    //             style: TextStyle(
                    //                 color: Colors.grey,
                    //                 fontWeight: FontWeight.bold,
                    //                 fontSize: 13),
                    //           ),
                    //         ),
                    //       )
                    //     ],
                    //   ),
                    // ),
                    // const SizedBox(
                    //   height: 10,
                    // ),
                    // ElevatedButton(
                    //   style: ButtonStyle(
                    //     shape: MaterialStateProperty.all(
                    //       RoundedRectangleBorder(
                    //         side: BorderSide(color: Colors.grey[200]!),
                    //         borderRadius: BorderRadius.circular(8),
                    //       ),
                    //     ),
                    //     elevation: MaterialStateProperty.all(0),
                    //     backgroundColor:
                    //         MaterialStateProperty.all(Colors.transparent),
                    //     fixedSize: MaterialStateProperty.all(Size(Get.width, 54)),
                    //   ),
                    //   onPressed: () {},
                    //   child: Row(
                    //     children: const [
                    //       FaIcon(FontAwesomeIcons.facebookF, color: Colors.lightBlue),
                    //       Expanded(
                    //         child: Center(
                    //           child: Text(
                    //             "Login with Facebook",
                    //             style: TextStyle(
                    //                 color: Colors.grey,
                    //                 fontWeight: FontWeight.bold,
                    //                 fontSize: 13),
                    //           ),
                    //         ),
                    //       )
                    //     ],
                    //   ),
                    // ),
                    // const SizedBox(
                    //   height: 10,
                    // ),
                    TextButton(
                      onPressed: () {
                        Get.to(() => ResetPassword());
                      },
                      child: const Center(
                        child: Text(
                          "Forgot password",
                          style: TextStyle(
                            color: Color(0xff40BFFF),
                            fontWeight: FontWeight.bold,
                            // fontSize: 13
                          ),
                        ),
                      ),
                    ),
                    // const SizedBox(
                    //   height: 10,
                    // ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Don't have a account",
                          style: TextStyle(color: Colors.grey),
                        ),
                        TextButton(
                          onPressed: () {
                            Get.to(() => Signup());
                          },
                          child: const Center(
                            child: Text(
                              "Register",
                              style: TextStyle(
                                  color: Color(0xff40BFFF),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
