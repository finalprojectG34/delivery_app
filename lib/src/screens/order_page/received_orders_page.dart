import 'package:delivery_app/src/screens/order_page/order_page_ctx.dart';
import 'package:delivery_app/src/screens/order_page/received_orders/received_orders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReceivedOrdersPage extends StatefulWidget {
  const ReceivedOrdersPage({Key? key}) : super(key: key);

  @override
  State<ReceivedOrdersPage> createState() => _ReceivedOrderPageState();
}

class _ReceivedOrderPageState extends State<ReceivedOrdersPage>
    with TickerProviderStateMixin {
  late TabController _tabController;
  List<String> aa = [
    'REQUESTED',
    'CANCELED',
    'ON_DELIVERY',
    'DELIVERED',
    'ACCEPTED',
  ];

  OrderPageController orderPageController = Get.find();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
    orderPageController.getReceivedOrders(aa[0]);
    _tabController.addListener(() {
      orderPageController.getReceivedOrders(aa[_tabController.index]);
    });
  }

  int id = 1;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Received Orders'),
          centerTitle: true,
          bottom: TabBar(
            isScrollable: true,
            controller: _tabController,
            tabs: const [
              Tab(icon: Icon(Icons.description), text: 'Requested'),
              Tab(icon: Icon(Icons.event), text: 'Accepted'),
              Tab(icon: Icon(Icons.shopping_cart), text: 'On Delivery'),
              Tab(icon: Icon(Icons.check), text: 'Delivered'),
              Tab(icon: Icon(Icons.stop_circle_outlined), text: 'Canceled'),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: const [
            ReceivedOrderStatus(status: "REQUESTED", tabName: "requested"),
            ReceivedOrderStatus(
                status: "DELIVERY_PENDING", tabName: "delivery pending"),
            ReceivedOrderStatus(status: "ON_DELIVERY", tabName: "on delivery"),
            ReceivedOrderStatus(status: "DELIVERED", tabName: "delivered"),
            ReceivedOrderStatus(status: "CANCELED", tabName: "canceled"),
          ],
        ),
      ),
    );
  }
}
