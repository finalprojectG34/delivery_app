import 'package:delivery_app/src/screens/cart_page/shipping_address.dart';
import 'package:delivery_app/src/screens/profile_page/profile_page_ctx.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/cart.dart';
import '../components/payment_detail.dart';
import '../order_page/order_page_ctx.dart';
import 'cart_page_ctx.dart';

class ShipmentInfoPage extends StatefulWidget {
  const ShipmentInfoPage({Key? key, this.index}) : super(key: key);
  final int? index;

  @override
  State<ShipmentInfoPage> createState() => _ShipmentInfoPageState();
}

class _ShipmentInfoPageState extends State<ShipmentInfoPage> {
  @override
  void initState() {
    super.initState();
  }

  final OrderPageController orderPageController = Get.find();
  final ProfilePageController profilePageController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Shipment Info")),
      body: GetX<CartPageController>(
        builder: (ctx) {
          return RefreshIndicator(
            onRefresh: () async {
              await ctx.getCart();
            },
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: ctx.isCartLoading.isTrue ||
                      orderPageController.isOrderLoading.isTrue
                  ? const Center(child: CircularProgressIndicator())
                  : ctx.errOccurred.isTrue
                      ? Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(ctx.err.value),
                                const SizedBox(width: 20),
                                TextButton(
                                    onPressed: () {
                                      ctx.getCart();
                                    },
                                    child: const Text('Retry'))
                              ],
                            ),
                          ),
                        )
                      : Column(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(vertical: 15),
                                    child: Text(
                                      "Your Cart",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ),
                                const Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(vertical: 10),
                                    child: Text(
                                      "Shipping Address",
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ),
                                ),
                                const ShippingAddress(),
                                const Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(vertical: 10),
                                    child: Text(
                                      "Payment Method",
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: double.infinity,
                                  child: Card(
                                    child: Padding(
                                      padding: EdgeInsets.all(10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Payment"),
                                          Text(
                                            "On Delivery",
                                            style:
                                                TextStyle(color: Colors.grey),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(),
                            Column(
                              children: [
                                const PaymentDetail(),
                                ElevatedButton(
                                  style: ButtonStyle(
                                    shadowColor: MaterialStateProperty.all(
                                        Colors.lightBlueAccent),
                                    elevation: MaterialStateProperty.all(5),
                                    backgroundColor: MaterialStateProperty.all(
                                        const Color(0xff40BFFF)),
                                    fixedSize: MaterialStateProperty.all(
                                        Size(Get.width, 54)),
                                  ),
                                  onPressed: () {
                                    List<Cart> tempCart = [];
                                    ctx.cartList?.toList().forEach((element) {
                                      tempCart.add(element);
                                    });
                                    orderPageController.createOrder(
                                      tempCart,
                                      profilePageController.address?.value,
                                    );
                                  },
                                  child: const Text(
                                    "Continue To Delivery",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
            ),
          );
        },
      ),
    );
  }
}
