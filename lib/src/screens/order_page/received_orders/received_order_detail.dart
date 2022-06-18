import 'package:delivery_app/src/screens/order_page/order_page_ctx.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../shops_list/shops_list_ctx.dart';

class ReceivedOrderDetail extends StatefulWidget {
  final String orderId;

  const ReceivedOrderDetail({Key? key, required this.orderId})
      : super(key: key);

  @override
  State<ReceivedOrderDetail> createState() => _ReceivedOrderDetailState();
}

class _ReceivedOrderDetailState extends State<ReceivedOrderDetail> {
  OrderPageController orderPageController = Get.find();
  ShopsListController shopsListController = Get.find();

  @override
  void initState() {
    super.initState();
    orderPageController.getOrderById(widget.orderId);
  }

  static const months = [
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec"
  ];

  @override
  Widget build(BuildContext context) {
    return GetX<OrderPageController>(
      builder: (ctx) {
        return ctx.isOrderLoading.isTrue
            ? const Center(child: CircularProgressIndicator())
            : ctx.isOrderError.isTrue
                ? Text("${ctx.orderErrorText}")
                : RefreshIndicator(
                    onRefresh: () async {
                      await orderPageController.getOrderById(widget.orderId);
                    },
                    child: Scaffold(
                      appBar: AppBar(title: Text('Order')),
                      body: ListView(
                        children: [
                          SizedBox(height: 10),
                          OrderInfo(ctx),
                          SizedBox(height: 20),
                          if (ctx.order.value.status == "REQUESTED")
                            AcceptReject(ctx),
                          if (ctx.order.value.status == "DELIVERY_PENDING")
                            ReceiveFromSeller(ctx),
                          if (ctx.order.value.status == "ON_DELIVERY")
                            ReturnToSeller(ctx),
                        ],
                      ),
                    ),
                  );
      },
    );
  }

  AcceptReject(OrderPageController ctx) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.red,
              ),
              onPressed: () {
                ctx.updateOrderStatus(
                  ctx.order.value.id!,
                  "DeclinedByDelivery",
                );
              },
              child: const Text(
                "Reject",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
            ),
          ),
          SizedBox(width: 20),
          Expanded(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
              ),
              onPressed: () async {
                ctx.updateOrderStatus(
                  ctx.order.value.id!,
                  "AcceptedByDelivery",
                );
              },
              child: const Text(
                "Accept",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  // fontSize: 13,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  OrderInfo(OrderPageController ctx) {
    DateTime getDate(String date) {
      return DateTime.parse(date);
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Card(
        color: Colors.blue.shade300,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 25,
            vertical: 15,
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    'ETB 300',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Divider(color: Colors.white),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Items',
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    '${ctx.order.value.orderItems?.length}',
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ),
              SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Date',
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    "${getDate(ctx.order.value.createdAt!).day} ${months[getDate(ctx.order.value.createdAt!).month]}, ${getDate(ctx.order.value.createdAt!).year}: ${getDate(ctx.order.value.createdAt!).hour}:${getDate(ctx.order.value.createdAt!).minute}",
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ),
              SizedBox(height: 5),
            ],
          ),
        ),
      ),
    );
  }

  ReceiveFromSeller(OrderPageController ctx) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.red,
              ),
              onPressed: () {
                ctx.updateOrderStatus(
                  ctx.order.value.id!,
                  "DeclinedByDelivery",
                );
              },
              child: const Text(
                "Cancel",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
            ),
          ),
          SizedBox(width: 20),
          Expanded(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
              ),
              onPressed: () async {
                ctx.updateOrderStatus(
                  ctx.order.value.id!,
                  "ReceivedByDelivery",
                );
              },
              child: const Text(
                "Order Received",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  // fontSize: 13,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  ReturnToSeller(OrderPageController ctx) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
              ),
              onPressed: () async {
                ctx.updateOrderStatus(
                  ctx.order.value.id!,
                  "ReturnedByDelivery",
                );
              },
              child: const Text(
                "Return To Seller",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  // fontSize: 13,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
