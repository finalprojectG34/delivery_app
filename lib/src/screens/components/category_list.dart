import 'package:delivery_app/src/screens/components/category_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utils/Constants.dart';

class CategoryList extends StatelessWidget {
  const CategoryList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GridView.count(
          crossAxisCount: 3,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: const [
            CategoryItem(
              imagePath: Constants.foodImagePath,
              title: "Food",
            ),
            CategoryItem(
              imagePath: Constants.candyImagePath,
              title: "Candies",
            ),
            CategoryItem(
              imagePath: Constants.watchImagePath,
              title: "Watches",
            ),
            CategoryItem(
              imagePath: Constants.sneakersImagePath,
              title: "Sneakers",
            ),
            CategoryItem(
              imagePath: Constants.cosmeticsImagePath,
              title: "Beauty",
            ),
            CategoryItem(
              imagePath: Constants.sampleImagePath,
              title: "Smartphones",
            ),
          ],
        ),
        TextButton(
          onPressed: () {},
          child: const Text('More category'),
        )
      ],
    );
  }
}
