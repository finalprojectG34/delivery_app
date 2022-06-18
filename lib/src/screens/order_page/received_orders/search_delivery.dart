import 'package:delivery_app/src/screens/order_page/order_page_ctx.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/shop.dart';
import '../../shops_list/shops_list_ctx.dart';

class SearchDelivery extends StatefulWidget {
  final String orderId;

  const SearchDelivery({Key? key, required this.orderId}) : super(key: key);

  @override
  State<SearchDelivery> createState() => _SearchDeliveryState();
}

class _SearchDeliveryState extends State<SearchDelivery> {
  OrderPageController orderPageController = Get.find();

  @override
  void initState() {
    ShopsListController shopsListController = Get.find();
    shopsListController.getShopByRole("DELIVERY");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search Delivery"),
      ),
      body: GetX<ShopsListController>(
        builder: (ctx) {
          return ctx.isLoading.isTrue ||
                  orderPageController.isOrderLoading.isTrue
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : ctx.errorOccurred.isTrue ||
                      orderPageController.isOrderError.isTrue
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Error Happend, Please"),
                          TextButton(
                              onPressed: () {
                                ctx.getShopByRole("DELIVERY");
                              },
                              child: Text("Retry"))
                        ],
                      ),
                    )
                  : RefreshIndicator(
                      onRefresh: () async {
                        await ctx.getShopByRole("DELIVERY");
                      },
                      child: ListView.builder(
                        padding: EdgeInsets.all(20),
                        itemCount: ctx.shopsList.value?.length,
                        itemBuilder: (cx, i) => Card(
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: DeliveryProfile(ctx.shopsList.value![i]),
                          ),
                        ),
                      ),
                    );
        },
      ),
    );
  }

  DeliveryProfile(Shop shop) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 25,
                child: CircleAvatar(
                  backgroundImage: NetworkImage(
                      'https://www.woolha.com/media/2020/03/eevee.png'),
                  radius: 25,
                ),
              ),
              SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${shop.name}'),
                  Text('${shop.phoneNumber}'),
                ],
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 6,
                        backgroundColor: Colors.green,
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 3,
                        ),
                      ),
                      SizedBox(width: 5),
                      Text('${shop.address?.country}'),
                    ],
                  ),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 6,
                        backgroundColor: Colors.green,
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 3,
                        ),
                      ),
                      SizedBox(width: 5),
                      Text('${shop.address?.city}'),
                    ],
                  ),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 6,
                        backgroundColor: Colors.green,
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 3,
                        ),
                      ),
                      SizedBox(width: 5),
                      Text(
                          '${shop.address?.subCity} ${shop.address?.addressName}'),
                    ],
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  orderPageController.assignDelivery(widget.orderId, shop.id!);
                },
                child: Text("Assign"),
              )
            ],
          )
        ],
      ),
    );
  }
}
