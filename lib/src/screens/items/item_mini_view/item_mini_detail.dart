import 'package:delivery_app/src/screens/cart_page/cart_page_ctx.dart';
import 'package:delivery_app/src/screens/home_page/AppCtx.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../models/cart.dart';
import '../../../models/item.dart';

class ItemMiniDetail extends StatelessWidget {
  final Item item;

  ItemMiniDetail({Key? key, required this.item}) : super(key: key);
  final AppController appController = Get.find();
  final CartPageController addToCartController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Expanded(
            child: Stack(
              alignment: AlignmentDirectional.centerEnd,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(10),
                      topLeft: Radius.circular(10),
                    ),
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(0.9),
                          BlendMode.dstATop,
                        ),
                        image: const NetworkImage(
                            "https://fdn.gsmarena.com/imgroot/reviews/20/apple-iphone-12-pro-max/lifestyle/-1200w5/gsmarena_008.jpg"),
                        onError: (e, s) {}),
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 18,
                    horizontal: 12,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name!,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: const [
                    Icon(
                      Icons.star,
                      size: 16,
                      color: Colors.amber,
                    ),
                    Icon(
                      Icons.star,
                      size: 16,
                      color: Colors.amber,
                    ),
                    Icon(
                      Icons.star,
                      size: 16,
                      color: Colors.amber,
                    ),
                    Icon(
                      Icons.star,
                      size: 16,
                      color: Colors.amber,
                    ),
                    Icon(
                      Icons.star,
                      size: 16,
                      color: Colors.amber,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      '(12)',
                      style: TextStyle(color: Colors.grey),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text(
                      "${item.discountPrice}",
                      style: const TextStyle(
                          decoration: TextDecoration.lineThrough,
                          color: Colors.grey),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      "${item.price}",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.blue),
                    ),
                    const Spacer(),
                    InkWell(
                      child: const Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Icon(
                          Icons.add_shopping_cart,
                          color: Colors.blue,
                        ),
                      ),
                      borderRadius: BorderRadius.circular(50),
                      onTap: () {
                        addToCartController.addToCart(Cart(
                          name: item.name,
                          shopId: item.shopId,
                          itemId: item.id,
                          price: item.price,
                          amount: "1",
                        ));
                        // appController.changePage('Cart', 3);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
