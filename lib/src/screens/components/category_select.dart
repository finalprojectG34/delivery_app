import 'package:delivery_app/src/screens/add_item/add_item_ctx.dart';
import 'package:delivery_app/src/screens/add_item/subcategory_select.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategorySelect extends StatelessWidget {
  final String name;
  final bool isOnSubcategoryPage;
  final bool isSelectable;
  final bool hasSubcategory;
  final List subcategories;
  final List attributes;
  final AddItemController addItemController = Get.find();

  CategorySelect(
      {Key? key,
      required this.name,
      required this.isOnSubcategoryPage,
      required this.isSelectable,
      required this.hasSubcategory,
      required this.subcategories,
      required this.attributes})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Card(
        child: ListTile(
          onTap: hasSubcategory
              ? isOnSubcategoryPage && !isSelectable
                  ? null
                  : isOnSubcategoryPage && isSelectable
                      ? () {
                          for (int i = 0;
                              i < addItemController.categorySelectPages.value;
                              i++) {
                            // addItemController.attributes([]);
                            addItemController.changeAttribute(attributes);
                            addItemController.selectedAttributes({});
                            Navigator.of(context).pop();
                          }
                          addItemController.categorySelectPages(0);
                          if (addItemController.tempCategories.isEmpty) {
                            addItemController.tempCategories.add(name);
                          } else if (addItemController.tempCategories.last !=
                              name) {
                            addItemController.tempCategories.add(name);
                          }
                          addItemController.selectedCategoryName(
                              addItemController.tempCategories);
                          addItemController.tempCategories = [];
                        }
                      : () {
                          addItemController.categorySelectPages++;
                          // addItemController.tempCategories.add(name);
                          if (addItemController.tempCategories.isEmpty) {
                            addItemController.tempCategories.add(name);
                          } else if (addItemController.tempCategories.last !=
                              name) {
                            addItemController.tempCategories.add(name);
                          }
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => SubcategorySelect(
                                    name: name,
                                    subcategories: subcategories,
                                    isSelectable: isSelectable,
                                    attributes: attributes,
                                  )));
                        }
              : () {
                  for (int i = 0;
                      i < addItemController.categorySelectPages.value;
                      i++) {
                    addItemController.changeAttribute(attributes);
                    addItemController.selectedAttributes({});
                    Navigator.of(context).pop();
                  }
                  if (addItemController.tempCategories.isEmpty) {
                    addItemController.tempCategories.add(name);
                  } else if (addItemController.tempCategories.last != name) {
                    addItemController.tempCategories.add(name);
                  }
                  addItemController
                      .selectedCategoryName(addItemController.tempCategories);
                  addItemController.categorySelectPages(0);
                  addItemController.tempCategories = [];
                },
          title: Text(
            name,
          ),
          trailing: isOnSubcategoryPage
              ? OutlinedButton(
                  onPressed: isSelectable ? () {} : null,
                  child: const Text('select'),
                )
              : hasSubcategory
                  ? const Icon(Icons.arrow_forward_rounded)
                  : null,
        ),
      ),
    );
  }
}
