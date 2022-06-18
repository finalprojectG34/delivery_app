import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../helper/constance.dart';
import '../cart_page/cart_page_ctx.dart';

class PaymentDetail extends StatelessWidget {
  const PaymentDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CartPageController ctx = Get.find();

    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Items (${(ctx.cartList as List).length})',
                  style: const TextStyle(color: Colors.grey, fontSize: 16),
                ),
                Text(
                  'ETB ${ctx.totalPrice.toString()}',
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Shipping',
                  style: TextStyle(color: Colors.grey, fontSize: 16),
                ),
                Text(
                  'ETB ${ctx.shippingPrice.toString()}',
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 5),
            const Divider(height: 10, color: Colors.grey),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total Price',
                  style: TextStyle(
                      color: color1, fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  'ETB ${ctx.totalPrice.toString()}',
                  style: const TextStyle(fontSize: 16, color: Colors.lightBlue),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
