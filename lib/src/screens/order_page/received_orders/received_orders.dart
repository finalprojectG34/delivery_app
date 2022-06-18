import 'package:delivery_app/src/screens/order_page/received_orders/received_order_detail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../order_page_ctx.dart';
import '../single_order.dart';

class ReceivedOrderStatus extends StatefulWidget {
  final String status;
  final String tabName;

  const ReceivedOrderStatus(
      {Key? key, required this.status, required this.tabName})
      : super(key: key);

  @override
  State<ReceivedOrderStatus> createState() => _ReceivedOrderStatusState();
}

class _ReceivedOrderStatusState extends State<ReceivedOrderStatus> {
  OrderPageController orderPageController = Get.find();

  @override
  Widget build(BuildContext context) {
    return GetX<OrderPageController>(
      builder: (ctx) {
        return RefreshIndicator(
          onRefresh: () async {
            await ctx.getReceivedOrders(widget.status);
          },
          child: ctx.isOrderLoading.isTrue
              ? const Center(child: CircularProgressIndicator())
              : ctx.isOrderError.isTrue
                  ? Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Error happened! Please,"),
                          TextButton(
                              onPressed: () {
                                ctx.getReceivedOrders(widget.status);
                              },
                              child: Text("Retry"))
                        ],
                      ),
                    )
                  : ctx.orderList!.isEmpty
                      ? Center(
                          child: Text("No ${widget.tabName} orders yet."),
                        )
                      : ListView(
                          children: [
                            if (ctx.isOrderLoading.isFalse)
                              ...ctx.orderList!
                                  .map((order) => GestureDetector(
                                        onTap: () {
                                          ctx.getOrderById(order.id!);
                                          Get.to(() => ReceivedOrderDetail(
                                              orderId: order.id!));
                                        },
                                        child: SingleOrder(order: order),
                                      ))
                                  .toList()
                          ],
                        ),
        );
      },
    );
  }
}
