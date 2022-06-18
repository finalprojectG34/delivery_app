import 'dart:io';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../components/add_shop.dart';
import 'add_item_ctx.dart';

class AddItem extends StatefulWidget {
  const AddItem({Key? key, required this.hasAppbar}) : super(key: key);
  final bool hasAppbar;

  @override
  State<AddItem> createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  String? name;
  String? description;
  double? price;

  String addItem = '''
      mutation AddItem(\$createItemInput2: ItemCreateInput!){
        createItem(input: createItemInput2){
          name
          id
        }
      }
      ''';
  var variable = {
    "createItemInput": {
      "name": "item 5",
      "description": {"description": "desc"},
      "image":
          "https://fdn.gsmarena.com/imgroot/reviews/20/apple-iphone-12-pro-max/lifestyle/-1200w5/gsmarena_008.jpg",
      "categoryId": "cat id 5"
    }
  };
  final List<String> categoryTypes = [
    'Income',
    'Expense',
    'Both',
  ];
  TextEditingController categoryTextEditingController = TextEditingController(
      text:
          'vbfdjbvjhbvjdfhbvjhdfvjbvdjfbvjdfbvjdfbvj dfhvjhbdvjbdfhbvdjfbvjdf vdfh vjhbvdjbh');
  final _formKey = GlobalKey<FormState>();
  AddItemController addItemController = Get.find();

  File? _image;

  final ImagePicker _picker = ImagePicker();

  @override
  void dispose() {
    Get.delete<AddItemController>();
    super.dispose();
  }

  Future<void> _openImagePicker(String type) async {
    final XFile? pickedImage = await _picker.pickImage(
        source: type == 'camera' ? ImageSource.camera : ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // AddItemController addItemController = Get.put(AddItemController());
    return GetX<AddItemController>(
      builder: (ctx) {
        return Scaffold(
          appBar: widget.hasAppbar
              ? AppBar(
                  title: Text(
                      '${ctx.userHasShop!.isTrue ? 'Add Item' : 'Register your shop'}'),
                )
              : null,
          body: ctx.isShopLoading.isTrue
              ? const Center(child: CircularProgressIndicator())
              : ctx.errOccurred.isTrue
                  ? Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(ctx.err.value),
                            SizedBox(
                              width: 20,
                            ),
                            TextButton(
                                onPressed: () {
                                  ctx.getUserShop();
                                },
                                child: Text('Retry'))
                          ],
                        ),
                      ),
                    )
                  : ctx.userHasShop!.isTrue
                      ?
                      // ctx.isCategoryFetchedFromDB.isFalse
                      //   ? Center(
                      //       child: CircularProgressIndicator(),
                      //     )
                      //   :
                      Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          child: Form(
                            key: _formKey,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 25),
                              child: ListView(
                                // crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  TextField(
                                    // style: Text,
                                    decoration: InputDecoration(
                                      labelText: 'Name',
                                      labelStyle: TextStyle(
                                        fontSize: 16,
                                        // color: Colors.blue,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          width: 0.75,
                                          // color: Colors.blue,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          width: 0.75,
                                          color: Colors.blue,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  TextField(
                                    minLines: 1,
                                    maxLines: 10,
                                    readOnly: true,
                                    controller: TextEditingController(
                                        text: ctx.selectedCategoryName.isEmpty
                                            ? ''
                                            : ctx.selectedCategoryName
                                                .join(' / ')),
                                    decoration: const InputDecoration(
                                      labelText: 'Select Category',
                                      labelStyle: TextStyle(
                                        fontSize: 16,
                                        // color: Colors.blue,
                                      ),
                                      suffixIcon: Icon(
                                        Icons.arrow_drop_down_rounded,
                                        size: 30,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          width: 0.75,
                                          // color: Colors.blue,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          width: 0.75,
                                          color: Colors.blue,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  ListView.separated(
                                    key: UniqueKey(),
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) => Padding(
                                        padding:
                                            const EdgeInsets.only(left: 20),
                                        child:
                                            index == ctx.attributes.length - 1
                                                ? Column(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          // Text(
                                                          //   ctx.attributes[index]['name'],
                                                          //   style: TextStyle(fontSize: 18),
                                                          // ),
                                                          Expanded(
                                                            child: ctx.attributes[
                                                                            index]
                                                                        [
                                                                        'display'] !=
                                                                    'dropdown'
                                                                ? TextField(
                                                                    // focusNode: categoryNameFocusNode,
                                                                    // controller: categoryNameController,
                                                                    keyboardType: ctx.attributes[index]['display'] ==
                                                                            'text'
                                                                        ? TextInputType
                                                                            .text
                                                                        : TextInputType
                                                                            .number,
                                                                    decoration:
                                                                        InputDecoration(
                                                                      enabledBorder:
                                                                          const OutlineInputBorder(
                                                                        borderSide: BorderSide(
                                                                            color:
                                                                                Colors.blue,
                                                                            width: 0.5),
                                                                      ),
                                                                      focusedBorder:
                                                                          const OutlineInputBorder(
                                                                        borderSide: BorderSide(
                                                                            color:
                                                                                Colors.blue,
                                                                            width: 0.75),
                                                                      ),
                                                                      isDense:
                                                                          true,
                                                                      labelText:
                                                                          ctx.attributes[index]
                                                                              [
                                                                              'name'],

                                                                      // contentPadding: EdgeInsets.only(left: 20)
                                                                    ),
                                                                    onChanged:
                                                                        (value) {
                                                                      ctx.addSelectedAttribute(
                                                                          ctx.attributes[index]
                                                                              [
                                                                              'name'],
                                                                          value
                                                                              .toString());
                                                                    },
                                                                    onEditingComplete:
                                                                        () {
                                                                      FocusScope.of(
                                                                              context)
                                                                          .unfocus();
                                                                    },
                                                                  )
                                                                : DropdownButtonFormField2(
                                                                    // value: 'Select ',
                                                                    // key: UniqueKey(),
                                                                    decoration:
                                                                        InputDecoration(
                                                                      labelText:
                                                                          ctx.attributes[index]
                                                                              [
                                                                              'name'],
                                                                      enabledBorder:
                                                                          const OutlineInputBorder(
                                                                        borderSide: BorderSide(
                                                                            color:
                                                                                Colors.blue,
                                                                            width: 0.5),
                                                                      ),
                                                                      focusedBorder:
                                                                          const OutlineInputBorder(
                                                                        borderSide: BorderSide(
                                                                            color:
                                                                                Colors.blue,
                                                                            width: 0.75),
                                                                      ),
                                                                      contentPadding:
                                                                          EdgeInsets
                                                                              .zero,
                                                                      border:
                                                                          OutlineInputBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(5),
                                                                      ),
                                                                    ),
                                                                    isExpanded:
                                                                        true,
                                                                    hint: Text(
                                                                      'Select ${ctx.attributes[index]['name']}',
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              14,
                                                                          color:
                                                                              Colors.blue),
                                                                    ),
                                                                    icon:
                                                                        const Icon(
                                                                      Icons
                                                                          .arrow_drop_down,
                                                                      color: Colors
                                                                          .blue,
                                                                    ),
                                                                    iconSize:
                                                                        25,
                                                                    buttonPadding: const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            20,
                                                                        right:
                                                                            10),
                                                                    dropdownDecoration:
                                                                        BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10),
                                                                    ),
                                                                    items: (ctx.attributes[index]['options']
                                                                            as List<String>)
                                                                        .map(
                                                                      (item) {
                                                                        // print(item);
                                                                        return DropdownMenuItem<
                                                                            String>(
                                                                          value:
                                                                              item,
                                                                          // key: UniqueKey(),
                                                                          child:
                                                                              Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.center,
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
                                                                    onChanged:
                                                                        (value) {
                                                                      // print('onsaved  $value');
                                                                      ctx.addSelectedAttribute(
                                                                          ctx.attributes[index]
                                                                              [
                                                                              'name'],
                                                                          value
                                                                              .toString());
                                                                      // addCategoryController.setCategoryType(
                                                                      //     categoryId: widget.addCategoryModel.id,
                                                                      //     categoryType: value);
                                                                    },
                                                                    onSaved:
                                                                        (value) {
                                                                      // selectedValue = value.toString();
                                                                    },
                                                                  ),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 15,
                                                      ),
                                                    ],
                                                  )
                                                : Row(
                                                    children: [
                                                      // Text(
                                                      //   ctx.attributes[index]['name'],
                                                      //   style: TextStyle(fontSize: 18),
                                                      // ),
                                                      Expanded(
                                                        child: ctx.attributes[
                                                                        index][
                                                                    'display'] !=
                                                                'dropdown'
                                                            ? TextField(
                                                                // focusNode: categoryNameFocusNode,
                                                                // controller: categoryNameController,
                                                                keyboardType: ctx.attributes[index]
                                                                            [
                                                                            'display'] ==
                                                                        'text'
                                                                    ? TextInputType
                                                                        .text
                                                                    : TextInputType
                                                                        .number,
                                                                decoration:
                                                                    InputDecoration(
                                                                  enabledBorder:
                                                                      const OutlineInputBorder(
                                                                    borderSide: BorderSide(
                                                                        color: Colors
                                                                            .blue,
                                                                        width:
                                                                            0.5),
                                                                  ),
                                                                  focusedBorder:
                                                                      const OutlineInputBorder(
                                                                    borderSide: BorderSide(
                                                                        color: Colors
                                                                            .blue,
                                                                        width:
                                                                            0.75),
                                                                  ),
                                                                  isDense: true,
                                                                  labelText: ctx
                                                                              .attributes[
                                                                          index]
                                                                      ['name'],

                                                                  // contentPadding: EdgeInsets.only(left: 20)
                                                                ),
                                                                onChanged:
                                                                    (value) {
                                                                  ctx.addSelectedAttribute(
                                                                      ctx.attributes[
                                                                              index]
                                                                          [
                                                                          'name'],
                                                                      value
                                                                          .toString());
                                                                },
                                                                onEditingComplete:
                                                                    () {
                                                                  FocusScope.of(
                                                                          context)
                                                                      .unfocus();
                                                                },
                                                              )
                                                            : DropdownButtonFormField2(
                                                                // value: 'Select ',
                                                                // key: UniqueKey(),
                                                                decoration:
                                                                    InputDecoration(
                                                                  labelText: ctx
                                                                              .attributes[
                                                                          index]
                                                                      ['name'],
                                                                  enabledBorder:
                                                                      const OutlineInputBorder(
                                                                    borderSide: BorderSide(
                                                                        color: Colors
                                                                            .blue,
                                                                        width:
                                                                            0.5),
                                                                  ),
                                                                  focusedBorder:
                                                                      const OutlineInputBorder(
                                                                    borderSide: BorderSide(
                                                                        color: Colors
                                                                            .blue,
                                                                        width:
                                                                            0.75),
                                                                  ),
                                                                  contentPadding:
                                                                      EdgeInsets
                                                                          .zero,
                                                                  border:
                                                                      OutlineInputBorder(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(5),
                                                                  ),
                                                                ),
                                                                isExpanded:
                                                                    true,
                                                                hint: Text(
                                                                  'Select ${ctx.attributes[index]['name']}',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          14,
                                                                      color: Colors
                                                                          .blue),
                                                                ),
                                                                icon:
                                                                    const Icon(
                                                                  Icons
                                                                      .arrow_drop_down,
                                                                  color: Colors
                                                                      .blue,
                                                                ),
                                                                iconSize: 25,
                                                                buttonPadding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            20,
                                                                        right:
                                                                            10),
                                                                dropdownDecoration:
                                                                    BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10),
                                                                ),
                                                                items: (ctx.attributes[index]
                                                                            [
                                                                            'options']
                                                                        as List<
                                                                            String>)
                                                                    .map(
                                                                  (item) {
                                                                    // print(item);
                                                                    return DropdownMenuItem<
                                                                        String>(
                                                                      value:
                                                                          item,
                                                                      // key: UniqueKey(),
                                                                      child:
                                                                          Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        children: [
                                                                          Expanded(
                                                                            child:
                                                                                Text(
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
                                                                onChanged:
                                                                    (value) {
                                                                  // print('onsaved  $value');
                                                                  ctx.addSelectedAttribute(
                                                                      ctx.attributes[
                                                                              index]
                                                                          [
                                                                          'name'],
                                                                      value
                                                                          .toString());
                                                                  // addCategoryController.setCategoryType(
                                                                  //     categoryId: widget.addCategoryModel.id,
                                                                  //     categoryType: value);
                                                                },
                                                                onSaved:
                                                                    (value) {
                                                                  // selectedValue = value.toString();
                                                                },
                                                              ),
                                                      ),
                                                    ],
                                                  )),
                                    itemCount: ctx.attributes.length,
                                    separatorBuilder:
                                        (BuildContext context, int index) =>
                                            SizedBox(
                                      height: 10,
                                    ),
                                  ),
                                  TextField(
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      labelText: 'Price',
                                      labelStyle: TextStyle(
                                        fontSize: 16,
                                        // color: Colors.blue,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          width: 0.75,
                                          // color: Colors.blue,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          width: 0.75,
                                          color: Colors.blue,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  TextField(
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      labelText: 'Discounted Price (Optional)',
                                      labelStyle: TextStyle(
                                        fontSize: 16,
                                        // color: Colors.blue,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          width: 0.75,
                                          // color: Colors.blue,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          width: 0.75,
                                          color: Colors.blue,
                                        ),
                                      ),
                                      // contentPadding: EdgeInsets.zero
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  TextField(
                                    maxLines: 5,
                                    minLines: 1,
                                    decoration: InputDecoration(
                                      labelText: 'Description',
                                      labelStyle: TextStyle(
                                        fontSize: 16,
                                        // color: Colors.blue,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          width: 0.75,
                                          // color: Colors.blue,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          width: 0.75,
                                          color: Colors.blue,
                                        ),
                                      ),
                                    ),
                                  ),
                                  _image != null
                                      ? Center(
                                          child: Stack(
                                            alignment:
                                                AlignmentDirectional.topEnd,
                                            children: [
                                              SizedBox(
                                                height: 150,
                                                child: ClipRRect(
                                                  child: Image.file(_image!,
                                                      fit: BoxFit.cover),
                                                  borderRadius:
                                                      BorderRadius.all(
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
                                  Align(
                                    alignment: Alignment.bottomLeft,
                                    child: TextButton(
                                      child: Text('Add image'),
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
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                4,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  InkWell(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                      Radius.circular(10),
                                                    ),
                                                    onTap: () {
                                                      _openImagePicker(
                                                          'camera');
                                                      Navigator.pop(context);
                                                    },
                                                    child: Container(
                                                        padding:
                                                            EdgeInsets.all(20),
                                                        decoration:
                                                            BoxDecoration(
                                                          border: Border.all(
                                                              color:
                                                                  Colors.grey),
                                                          borderRadius:
                                                              BorderRadius.all(
                                                            Radius.circular(10),
                                                          ),
                                                        ),
                                                        child: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
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
                                                    borderRadius:
                                                        BorderRadius.all(
                                                      Radius.circular(10),
                                                    ),
                                                    onTap: () {
                                                      _openImagePicker(
                                                          'gallery');
                                                      Navigator.pop(context);
                                                    },
                                                    child: Container(
                                                      padding:
                                                          EdgeInsets.all(20),
                                                      decoration: BoxDecoration(
                                                          border: Border.all(
                                                              color:
                                                                  Colors.grey),
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          10))),
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          Text(
                                                              'Add from gallery'),
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
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: ElevatedButton(
                                          onPressed: () {
                                            // if (_formKey.currentState!.validate()) {
                                            //   _formKey.currentState!.save();
                                            // }
                                            if (_image != null) {
                                              addItemController.addItem({
                                                "input": {
                                                  "name": name,
                                                  "description": description,
                                                  "poster":
                                                      'https://fdn.gsmarena.com/imgroot/reviews/20/apple-iphone-12-pro-max/lifestyle/-1200w5/gsmarena_008.jpg',
                                                  "price": {"sale": price},
                                                  "categoryId": 'cat id 9'
                                                }
                                              }, _image!);
                                            }
                                          },
                                          child: const Text('Save'),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      : AddShop(
                          redirectFrom: 'home',
                        ),
        );
      },
    );
  }
}

class HomePagee extends StatefulWidget {
  const HomePagee({Key? key}) : super(key: key);

  @override
  _HomePageStatee createState() => _HomePageStatee();
}

class _HomePageStatee extends State<HomePagee> {
  File? _image;

  final ImagePicker _picker = ImagePicker();

  // Implementing the image picker
  Future<void> _openImagePicker() async {
    final XFile? pickedImage =
        await _picker.pickImage(source: ImageSource.camera);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kindacode.com'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(35),
          child: Column(
            children: [
              Center(
                child: ElevatedButton(
                  child: const Text('Select An Image'),
                  onPressed: _openImagePicker,
                ),
              ),
              const SizedBox(height: 35),
              _image != null
                  ? Stack(
                      alignment: AlignmentDirectional.topEnd,
                      children: [
                        SizedBox(
                          height: 200,
                          child: ClipRRect(
                            child: Image.file(_image!, fit: BoxFit.cover),
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                        )
                      ],
                    )
                  : const Text('Please select an image')
            ],
          ),
        ),
      ),
    );
  }
}
