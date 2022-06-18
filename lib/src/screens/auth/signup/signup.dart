import 'package:delivery_app/src/screens/auth/signup/signupCtx.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../../../packages/validators.dart';

class Signup extends StatelessWidget {
  Signup({Key? key}) : super(key: key);
  final SignUpController signUpController = Get.find();
  final GlobalKey<FormState> formState = GlobalKey<FormState>();

  String? firstName;
  String? lastName;
  String? phoneNumber;
  String? password;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        EasyLoading.dismiss();
        return true;
      },
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          body: GetX<SignUpController>(builder: (ctx) {
            return SingleChildScrollView(
                child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Form(
                key: formState,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: ctx.isUserCreatedSuccessfully.isTrue
                      ? [
                          Center(
                            child: Icon(
                              Icons.check_circle,
                              color: Colors.green,
                              size: 100,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('Continue'))
                        ]
                      : [
                          const Padding(padding: EdgeInsets.only(top: 100)),
                          // Center(
                          //   child: Image.asset("images/home_icon.png"),
                          // ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            "Create new account",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          // const Text(
                          //   "Sign in to continue",
                          //   style: TextStyle(),
                          // ),
                          const SizedBox(
                            height: 30,
                          ),
                          Row(children: [
                            Expanded(
                              child: TextFormField(
                                decoration: InputDecoration(
                                  prefixIcon: const Icon(Icons.person_outline),
                                  contentPadding: const EdgeInsets.all(10),
                                  hintText: "First Name",
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
                                keyboardType: TextInputType.emailAddress,
                                onChanged: (text) => firstName = text,
                                validator: validateName,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: TextFormField(
                                decoration: InputDecoration(
                                  prefixIcon: const Icon(Icons.person_outline),
                                  contentPadding: const EdgeInsets.all(10),
                                  hintText: "Last Name",
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
                                keyboardType: TextInputType.emailAddress,
                                onChanged: (text) => lastName = text,
                                validator: validateName,
                              ),
                            )
                          ]),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            validator: validateMobileNum,
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
                                    color: Colors.grey[200]!, width: 1),
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(6),
                                  borderSide: BorderSide(
                                      color: Colors.grey[200]!, width: 1)),
                            ),
                            maxLines: 1,
                            keyboardType: TextInputType.phone,
                            onChanged: (text) => phoneNumber = text,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.lock),
                              contentPadding: const EdgeInsets.all(10),
                              hintText: "Password",
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
                            keyboardType: TextInputType.emailAddress,
                            obscureText: true,
                            onChanged: (text) => password = text,
                            validator: validatePassword,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.lock),
                              contentPadding: const EdgeInsets.all(10),
                              hintText: "Confirm Password",
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
                            obscureText: true,
                            validator: (val) {
                              validatePassword(val);
                              if (password != null && val != password)
                                return 'Password do not match';
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          ElevatedButton(
                            style: ButtonStyle(
                              shadowColor: MaterialStateProperty.all(
                                  Colors.lightBlueAccent),
                              elevation: MaterialStateProperty.all(6),
                              backgroundColor: MaterialStateProperty.all(
                                  const Color(0xff40BFFF)),
                              fixedSize: MaterialStateProperty.all(
                                  Size(Get.width, 54)),
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
                                ctx.sendOtp({
                                  "token": {
                                    "firstName": firstName,
                                    "lastName": lastName,
                                    "phone": "+251" + phoneNumber!,
                                    "password": password,
                                    "confirmPassword": password,
                                    "idToken": ''
                                  }
                                });
                              }

                              // signUpController.signupUser({
                              //   "input": {
                              //     "firstName": firstName,
                              //     "lastName": lastName,
                              //     "phone": phoneNumber,
                              //     // "password": "my password"
                              //   }
                              // });

                              // ctx.sendFakeOtp();
                            },
                            child: const Text(
                              "Sign up",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Have an account",
                                style: TextStyle(color: Colors.grey),
                              ),
                              TextButton(
                                  onPressed: () {
                                    // Get.off(() => Login());
                                    Get.back();
                                  },
                                  child: const Center(
                                    child: Text(
                                      "Sign in",
                                      style: TextStyle(
                                          color: Color(0xff40BFFF),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13),
                                    ),
                                  )),
                            ],
                          )
                        ],
                ),
              ),
            ));
          }),
        ),
      ),
    );
  }
}
