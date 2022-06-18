import 'package:delivery_app/src/screens/add_item/add_item_ctx.dart';
import 'package:delivery_app/src/screens/components/category_select.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class SubcategorySelect extends StatelessWidget {
  final String name;
  final bool isSelectable;
  final List subcategories;
  final List attributes;
  final AddItemController addItemController = Get.find();

  SubcategorySelect(
      {Key? key,
      required this.name,
      required this.subcategories,
      required this.isSelectable,
      required this.attributes})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        addItemController.categorySelectPages--;
        addItemController.tempCategories.removeLast();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(name),
        ),
        body: ListView(
          children: [
            CategorySelect(
              name: name,
              isOnSubcategoryPage: true,
              isSelectable: isSelectable,
              hasSubcategory: false,
              subcategories: subcategories,
              attributes: attributes,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30),
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) => CategorySelect(
                  name: subcategories[index]['name'],
                  isOnSubcategoryPage: false,
                  isSelectable: subcategories[index]['isCreatable'],
                  hasSubcategory: subcategories[index]['hasSubcategory'],
                  subcategories: subcategories[index]['subCategories'],
                  attributes: subcategories[index]['attributes'],
                ),
                itemCount: subcategories.length,
              ),
            )
          ],
        ),
      ),
    );
  }
}
