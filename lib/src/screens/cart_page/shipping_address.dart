import 'package:delivery_app/src/screens/profile_page/profile_page_ctx.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/user.dart';
import '../components/input_field_custom.dart';

class ShippingAddress extends StatefulWidget {
  const ShippingAddress({Key? key}) : super(key: key);

  @override
  State<ShippingAddress> createState() => _ShippingAddressState();
}

class _ShippingAddressState extends State<ShippingAddress> {
  TextEditingController countryController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController subCityController = TextEditingController();
  TextEditingController addressNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GetX<ProfilePageController>(
      builder: (ctx) {
        return Container(
          width: double.infinity,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: ctx.address?.value.addressName == null
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Add Shipping Address"),
                        IconButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (builder) {
                                    return AlertDialog(
                                      title: Text("Add shipping address"),
                                      content: SingleChildScrollView(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            CustomInputField(
                                              label: "Country",
                                              controller: countryController,
                                            ),
                                            const SizedBox(height: 10),
                                            CustomInputField(
                                              label: "City",
                                              controller: cityController,
                                            ),
                                            const SizedBox(height: 10),
                                            CustomInputField(
                                              label: "Sub City",
                                              controller: subCityController,
                                            ),
                                            const SizedBox(height: 10),
                                            CustomInputField(
                                              label: "Address Name",
                                              controller: addressNameController,
                                            ),
                                          ],
                                        ),
                                      ),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              Get.back();
                                            },
                                            child: Text("Cancel")),
                                        TextButton(
                                            onPressed: () {
                                              if (subCityController.text.isNotEmpty &&
                                                  countryController
                                                      .text.isNotEmpty &&
                                                  cityController
                                                      .text.isNotEmpty &&
                                                  addressNameController
                                                      .text.isNotEmpty) {
                                                ctx.updateUserAddress(Address(
                                                  subCity:
                                                      subCityController.text,
                                                  country:
                                                      countryController.text,
                                                  city: cityController.text,
                                                  addressName:
                                                      addressNameController
                                                          .text,
                                                ));
                                                Get.back();
                                              }
                                            },
                                            child: Text("Save")),
                                      ],
                                    );
                                  });
                            },
                            icon: Icon(Icons.add)),
                      ],
                    )
                  : ctx.isProfileLoading.isTrue
                      ? AlertDialog(
                          content: Center(child: CircularProgressIndicator()),
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${ctx.address?.value.addressName}",
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.w500),
                            ),
                            SizedBox(height: 5),
                            Text(
                              "${ctx.address?.value.subCity}",
                              style: TextStyle(fontSize: 14),
                            ),
                            SizedBox(height: 5),
                            Text(
                              "${ctx.address?.value.city}",
                              style: TextStyle(fontSize: 14),
                            ),
                            SizedBox(height: 5),
                            Text(
                              "${ctx.address?.value.country}",
                              style: TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
            ),
          ),
        );
      },
    );
  }
}
