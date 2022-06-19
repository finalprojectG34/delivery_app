import 'package:delivery_app/src/screens/auth/reset_password/resetCtx.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class ResetPassword extends StatelessWidget {
  ResetPassword({Key? key}) : super(key: key);
  final GlobalKey<FormState> formState = GlobalKey<FormState>();
  final ResetController resetController = Get.find();
  final TextEditingController phoneController = TextEditingController();

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
          resizeToAvoidBottomInset: true,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: CustomScrollView(slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Form(
                  key: formState,
                  child: Column(
                    children: [
                      // const Padding(
                      //   padding: EdgeInsets.only(top: 100),
                      // ),
                      SizedBox(
                        height: 100,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "Reset Your Password",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      TextFormField(
                        controller: phoneController,
                        // validator: validateMobileNum,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.phone),
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
                        keyboardType: TextInputType.phone,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                          shadowColor:
                              MaterialStateProperty.all(Colors.lightBlueAccent),
                          elevation: MaterialStateProperty.all(5),
                          backgroundColor: MaterialStateProperty.all(
                              const Color(0xff40BFFF)),
                          fixedSize: MaterialStateProperty.all(
                              Size(Get.width * 0.45, 54)),
                        ),
                        onPressed: () async {
                          if (formState.currentState!.validate()) {
                            FocusScope.of(context).unfocus();
                            EasyLoading.instance.loadingStyle =
                                EasyLoadingStyle.light;
                            await EasyLoading.show(
                              status: 'waiting for verification ...',
                              maskType: EasyLoadingMaskType.black,
                            );
                            resetController
                                .sendOtp('+251' + phoneController.text);
                          }
                        },
                        child: const Text(
                          "Send Code",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 13),
                        ),
                      ),
                      // const SizedBox(
                      //   height: 20,
                      // ),
                      // const Spacer(),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: [
                      //     const Text(
                      //       "Have an account",
                      //       style: TextStyle(color: Colors.grey),
                      //     ),
                      //     TextButton(
                      //         onPressed: () {},
                      //         child: const Expanded(
                      //             child: Center(
                      //           child: Text(
                      //             "Sign in",
                      //             style: TextStyle(
                      //                 color: Color(0xff40BFFF),
                      //                 fontWeight: FontWeight.bold,
                      //                 fontSize: 13),
                      //           ),
                      //         ))),
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
                      //         onPressed: () {},
                      //         child: const Expanded(
                      //             child: Center(
                      //           child: Text(
                      //             "Register",
                      //             style: TextStyle(
                      //                 color: Color(0xff40BFFF),
                      //                 fontWeight: FontWeight.bold,
                      //                 fontSize: 13),
                      //           ),
                      //         ))),
                      //   ],
                      // ),
                      // const SizedBox(
                      //   height: 100,
                      // )
                    ],
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
