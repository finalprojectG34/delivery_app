import 'package:delivery_app/src/screens/home_page/AppCtx.dart';
import 'package:delivery_app/src/screens/profile_page/update_profile_ctx.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../packages/validators.dart';

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({Key? key}) : super(key: key);

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  final GlobalKey<FormState> formState = GlobalKey<FormState>();
  AppController appController = Get.find();
  UpdateProfileController updateProfileController = Get.find();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  String? firstName;
  String? lastName;
  String? phoneNumber;

  @override
  void initState() {
    super.initState();
    firstName = appController.firstName.value;
    lastName = appController.lastName.value;
    phoneNumber = appController.phone.value.replaceFirst('+251', '');
  }

  @override
  Widget build(BuildContext context) {
    print('$firstName  $lastName  $phoneNumber');
    firstNameController.value = firstNameController.value.copyWith(
      text: firstName,
    );
    lastNameController.value = lastNameController.value.copyWith(
      text: lastName,
    );
    phoneController.value = phoneController.value.copyWith(
      text: phoneNumber,
    );
    return WillPopScope(
      onWillPop: () async {
        EasyLoading.dismiss();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Update Profile"),
        ),
        body: Container(
          padding: EdgeInsets.all(20),
          child: Form(
            key: formState,
            child: ListView(
              children: [
                TextFormField(
                  validator: validateName,
                  controller: firstNameController,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.person_outline),
                    contentPadding: const EdgeInsets.all(10),
                    hintText: "First Name",
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
                  onChanged: (text) => firstName = text,
                  // validator: validateName,
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  validator: validateName,
                  controller: lastNameController,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.person_outline),
                    contentPadding: const EdgeInsets.all(10),
                    hintText: "Last Name",
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
                  onChanged: (text) => lastName = text,
                  // validator: validateName,
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: phoneController,
                  readOnly: true,
                  decoration: InputDecoration(
                    prefixIcon: const SizedBox(
                      width: 50,
                      child: Center(
                        child: Text(
                          "+251",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                    contentPadding: const EdgeInsets.all(10),
                    hintText: "Phone number",
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
                  keyboardType: TextInputType.phone,
                  onChanged: (text) {
                    phoneNumber = text;
                    print(phoneNumber);
                  },
                  validator: validateMobileNum,
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
                      EasyLoading.instance.loadingStyle =
                          EasyLoadingStyle.light;

                      FocusScope.of(context).unfocus();

                      if (appController.firstName == firstName &&
                          appController.lastName == lastName &&
                          appController.phone == '+251' + phoneNumber!) {
                        EasyLoading.showInfo('Nothing changed',
                            dismissOnTap: true,
                            maskType: EasyLoadingMaskType.black);
                      } else {
                        await EasyLoading.show(
                          status: 'Updating profile ...',
                          maskType: EasyLoadingMaskType.black,
                        );
                        updateProfileController.updateProfile({
                          "input": {
                            if (firstName != appController.firstName.value)
                              "firstName": firstName,
                            if (lastName != appController.lastName.value)
                              "lastName": lastName,
                            if (phoneNumber != appController.phone.value)
                              "phone": '+251' + phoneNumber!,
                          }
                        });
                      }
                    }
                  },
                  child: const Text(
                    "Update",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
