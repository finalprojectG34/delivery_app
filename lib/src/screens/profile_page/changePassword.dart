import 'package:delivery_app/src/models/user.dart';
import 'package:delivery_app/src/utils/loger/console_loger.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../packages/validators.dart';

class ChangePassword extends StatelessWidget {
  static const String pathName = '/change_password';

  final GlobalKey<FormState> formState = GlobalKey<FormState>();
  String? oldPassword;

  String? newPassword;
  String? confirmPassword;
  final User? user;

  ChangePassword({@required this.user});

  final Map<String, dynamic> _user = {};

  @override
  Widget build(BuildContext context) {
    logTrace("here", this.user);
    return Scaffold(
      appBar: AppBar(
        title: Text('Change Password'),
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
                      hintText: "Old Password",
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
                    onChanged: (text) => oldPassword = text,
                    validator: validatePassword,
                  ),
                  SizedBox(
                    height: 20,
                  ),
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
                  // Container(
                  //   margin: EdgeInsets.only(bottom: 30),
                  //   child: TextFormField(
                  //     controller: TextEditingController(),
                  //     onSaved: (value) {},
                  //     validator: (value) {
                  //       if (value!.isEmpty) {
                  //         return 'Please enter some text';
                  //       }
                  //       return null;
                  //     },
                  //     decoration: InputDecoration(
                  //       labelText: 'Old Password',
                  //       contentPadding: EdgeInsets.only(bottom: 0),
                  //     ),
                  //   ),
                  // ),
                  // Container(
                  //   margin: EdgeInsets.only(bottom: 30),
                  //   child: TextFormField(
                  //     controller: TextEditingController(),
                  //     onSaved: (value) {
                  //       this._user["password"] = value;
                  //     },
                  //     validator: (value) {
                  //       if (value!.isEmpty) {
                  //         return 'Please enter some text';
                  //       }
                  //       return null;
                  //     },
                  //     decoration: InputDecoration(
                  //       labelText: 'New Password',
                  //       contentPadding: EdgeInsets.only(bottom: 0),
                  //     ),
                  //   ),
                  // ),
                  // Container(
                  //   margin: EdgeInsets.only(bottom: 30),
                  //   child: TextFormField(
                  //     controller: TextEditingController(),
                  //     onSaved: (value) {},
                  //     validator: (value) {
                  //       if (value!.isEmpty) {
                  //         return 'Please enter some text';
                  //       }
                  //       return null;
                  //     },
                  //     decoration: InputDecoration(
                  //       labelText: 'Confirm Password',
                  //       contentPadding: EdgeInsets.only(bottom: 0),
                  //     ),
                  //   ),
                  // ),
                  ElevatedButton(
                    style: ButtonStyle(
                      shadowColor:
                          MaterialStateProperty.all(Colors.lightBlueAccent),
                      elevation: MaterialStateProperty.all(5),
                      backgroundColor:
                          MaterialStateProperty.all(const Color(0xff40BFFF)),
                      fixedSize: MaterialStateProperty.all(Size(Get.width, 54)),
                    ),
                    onPressed: () {
                      if (formState.currentState!.validate()) {}
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
