import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../packages/validators.dart';
import '../auth/reset_password/resetCtx.dart';

class ResetPassword extends StatelessWidget {
  static const String pathName = '/change_password';

  ResetController resetController = Get.find();
  final GlobalKey<FormState> formState = GlobalKey<FormState>();

  // String? oldPassword;

  String? newPassword;
  String? confirmPassword;

  // final User? user;

  // ResetPassword(});

  final Map<String, dynamic> _user = {};

  @override
  Widget build(BuildContext context) {
    // logTrace("here", this.user);
    return Scaffold(
      appBar: AppBar(
        title: Text('Reset Password'),
      ),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(20),
            child: Form(
              key: formState,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.lock_outline_rounded),
                      contentPadding: const EdgeInsets.all(10),
                      hintText: "New Password",
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
                    keyboardType: TextInputType.text,
                    obscureText: true,
                    onChanged: (text) => newPassword = text,
                    validator: validatePassword,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.lock_outline_rounded),
                      contentPadding: const EdgeInsets.all(10),
                      hintText: "Confirm Password",
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
                    keyboardType: TextInputType.text,
                    obscureText: true,
                    onChanged: (text) => confirmPassword = text,
                    validator: (val) {
                      validatePassword(val);
                      if (newPassword != null && val != newPassword)
                        return 'Password do not match';
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      shadowColor:
                          MaterialStateProperty.all(Colors.lightBlueAccent),
                      elevation: MaterialStateProperty.all(5),
                      backgroundColor:
                          MaterialStateProperty.all(const Color(0xff40BFFF)),
                      fixedSize: MaterialStateProperty.all(Size(Get.width, 54)),
                    ),
                    onPressed: () async {
                      if (formState.currentState!.validate()) {
                        await EasyLoading.show(
                          status: 'Updating password ...',
                          maskType: EasyLoadingMaskType.black,
                        );
                        FocusScope.of(context).unfocus();
                        resetController.reset(newPassword!);
                      }
                    },
                    child: const Text(
                      "Update",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
