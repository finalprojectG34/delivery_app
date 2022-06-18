import 'dart:io';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';

import '../../packages/validators.dart';
import '../add_item/add_item_ctx.dart';

class AddShop extends StatefulWidget {
  AddShop({Key? key, required this.redirectFrom}) : super(key: key);
  final String redirectFrom;
  final GlobalKey<FormState> formState = GlobalKey<FormState>();

  @override
  State<AddShop> createState() => _AddShopState();
}

class _AddShopState extends State<AddShop> {
  String shopName = '';
  String description = '';
  String area = '';
  String location = '';
  final ImagePicker _picker = ImagePicker();
  AddItemController addItemController = Get.find();
  File? _image;
  String? selectedArea;
  String? selectedSubCity;
  List<String> locationArea = [
    'Addis Ababa',
    'Harar',
    'Diredawa',
    'Oromia',
    'Amhara',
    'Tigray',
    'Gambela',
    'Somalia'
  ];

  List<String> aaArea = [
    'Kolfe keranyo',
    'Arada',
    'Nifas silk',
    'Yeka',
    'Lideta',
    'Bole',
    'Kirkos'
  ];
  List<String> hararArea = ['Harar a1', 'Harar a2', 'Harar a3', 'Harar a4'];
  List<String> ddArea = ['Dire a1', 'Dire a2', 'Dire a3', 'Dire a4'];
  List<String> orArea = ['OR a1', 'OR a2', 'OR a3', 'OR a4', 'OR a5'];
  List<String> amArea = ['AM a1', 'AM a2', 'AM a3', 'AM a4', 'AM a5'];
  List<String> tgArea = ['TG a1', 'TG a2', 'TG a3', 'TG a4', 'TG a5'];
  List<String> gmArea = ['GM a1', 'GM a2', 'GM a3', 'GM a4', 'GM a5'];
  List<String> smArea = ['SM a1', 'SM a2', 'SM a3', 'SM a4', 'SM a5'];

  Future<void> _openImagePicker(String type) async {
    final XFile? pickedImage = await _picker.pickImage(
        source: type == 'camera' ? ImageSource.camera : ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }

  List<String> getSubCityFromArea(String name) {
    switch (name) {
      case 'Somalia':
        return smArea;
      case 'Gambela':
        return gmArea;
      case 'Tigray':
        return tgArea;
      case 'Amhara':
        return amArea;
      case 'Oromia':
        return orArea;
      case 'Diredawa':
        return ddArea;
      case 'Harar':
        return hararArea;
      case 'Addis Ababa':
        return aaArea;
    }
    return [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.redirectFrom == 'drawer'
          ? AppBar(title: Text('Register as a seller'))
          : null,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        child: Form(
          key: widget.formState,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.shop_outlined),
                  contentPadding: const EdgeInsets.all(10),
                  hintText: "Shop Name",
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
                onChanged: (text) => shopName = text,
                validator: validateName,
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                decoration: InputDecoration(
                  prefixIcon: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    // mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.edit),
                    ],
                  ),
                  contentPadding: const EdgeInsets.all(10),
                  hintText: "Shop Description",
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
                maxLines: 10,
                minLines: 5,
                keyboardType: TextInputType.text,
                onChanged: (text) => description = text,
                validator: (val) {
                  if (val == '') return 'Please enter description';
                  return null;
                },
              ),
              SizedBox(
                height: 10,
              ),
              DropdownButtonFormField2(
                validator: (val) {
                  if (selectedArea == null) return 'Please select area';
                  return null;
                },
                // value: 'Select ',
                // key: UniqueKey(),
                decoration: InputDecoration(
                  labelText: 'Area',
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 0.5),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 0.75),
                  ),
                  contentPadding: EdgeInsets.zero,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                isExpanded: true,
                hint: Text(
                  'Select area',
                  style: TextStyle(fontSize: 14, color: Colors.blue),
                ),
                icon: const Icon(
                  Icons.arrow_drop_down,
                  color: Colors.blue,
                ),
                iconSize: 25,
                buttonPadding: const EdgeInsets.only(left: 20, right: 10),
                dropdownDecoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                items: locationArea.map(
                  (item) {
                    // print(item);
                    return DropdownMenuItem<String>(
                      value: item,

                      // key: UniqueKey(),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Text(
                              item,
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedArea = value.toString();
                    selectedSubCity = null;
                  });
                  // print('onsaved  $value');
                  // ctx.addSelectedAttribute(
                  //     ctx.attributes[index]['name'],
                  //     value.toString());
                  // addCategoryController.setCategoryType(
                  //     categoryId: widget.addCategoryModel.id,
                  //     categoryType: value);
                },
                onSaved: (value) {
                  // selectedValue = value.toString();
                },
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Choose Sub city area',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
              SizedBox(
                height: 10,
              ),
              DropdownButtonFormField2(
                value: selectedSubCity,
                validator: (val) {
                  if (selectedSubCity == null) return 'Please select sub city';
                  return null;
                },
                key: UniqueKey(),
                decoration: InputDecoration(
                  labelText: 'Sub city',
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 0.5),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 0.75),
                  ),
                  contentPadding: EdgeInsets.zero,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                isExpanded: true,
                hint: Text(
                  'Select location',
                  style: TextStyle(fontSize: 14, color: Colors.blue),
                ),
                icon: const Icon(
                  Icons.arrow_drop_down,
                  color: Colors.blue,
                ),
                iconSize: 25,
                buttonPadding: const EdgeInsets.only(left: 20, right: 10),
                dropdownDecoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                items: selectedArea == null
                    ? null
                    : getSubCityFromArea(selectedArea!).map(
                        (item) {
                          // print(item);
                          return DropdownMenuItem<String>(
                            value: item,
                            // key: Key(item),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Text(
                                    item,
                                    style: const TextStyle(
                                      fontSize: 14,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ).toList(),
                onChanged: (value) {
                  selectedSubCity = value.toString();
                  // print('onsaved  $value');
                  // ctx.addSelectedAttribute(
                  //     ctx.attributes[index]['name'],
                  //     value.toString());
                  // addCategoryController.setCategoryType(
                  //     categoryId: widget.addCategoryModel.id,
                  //     categoryType: value);
                },
                onSaved: (value) {
                  // selectedValue = value.toString();
                },
              ),
              SizedBox(
                height: 10,
              ),
              _image != null
                  ? Center(
                      child: Stack(
                        alignment: AlignmentDirectional.topEnd,
                        children: [
                          SizedBox(
                            height: 150,
                            child: ClipRRect(
                              child: Image.file(_image!, fit: BoxFit.cover),
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              print('yy');
                              setState(() {
                                _image = null;
                              });
                            },
                            child: Icon(
                              Icons.delete,
                              color: Colors.red.shade300,
                            ),
                          )
                        ],
                      ),
                    )
                  : Container(),
              if (_image != null)
                SizedBox(
                  height: 10,
                ),
              Row(
                children: [
                  OutlinedButton(
                    onPressed: () {
                      showModalBottomSheet(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          ),
                        ),
                        context: context,
                        builder: (context) => SizedBox(
                          height: MediaQuery.of(context).size.height / 4,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                  onTap: () {
                                    _openImagePicker('camera');
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                      padding: EdgeInsets.all(20),
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10),
                                        ),
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            'Add from camera',
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Icon(
                                            Icons.add_a_photo,
                                            size: 30,
                                          )
                                        ],
                                      )),
                                ),
                                InkWell(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                  onTap: () {
                                    _openImagePicker('gallery');
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(20),
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text('Add from gallery'),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Icon(
                                          Icons.camera,
                                          size: 30,
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    child: Text('Upload shop image'),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                style: ButtonStyle(
                  shadowColor:
                      MaterialStateProperty.all(Colors.lightBlueAccent),
                  elevation: MaterialStateProperty.all(6),
                  backgroundColor:
                      MaterialStateProperty.all(const Color(0xff40BFFF)),
                  fixedSize: MaterialStateProperty.all(Size(Get.width, 54)),
                ),
                onPressed: () async {
                  if (widget.formState.currentState!.validate()) {
                    FocusScope.of(context).unfocus();

                    EasyLoading.instance.loadingStyle = EasyLoadingStyle.light;
                    await EasyLoading.show(
                      status: 'Creating shop',
                      maskType: EasyLoadingMaskType.black,
                    );

                    addItemController.addShop(
                      name: shopName,
                      description: description,
                      city: selectedArea,
                      subCity: selectedSubCity,
                      file: _image!,
                    );
                    // FocusScope.of(context).unfocus();
                    // EasyLoading.instance.loadingStyle =
                    //     EasyLoadingStyle.light;
                    // await EasyLoading.show(
                    //   status: 'waiting for verification ...',
                    //   maskType: EasyLoadingMaskType.black,
                    // );
                    // ctx.sendOtp({
                    //   "token": {
                    //     "firstName": firstName,
                    //     "lastName": lastName,
                    //     "phone": "+251" + phoneNumber!,
                    //     "password": password,
                    //     "confirmPassword": password,
                    //     "idToken": ''
                    //   }
                    // });
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
                  "Register",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 13),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
