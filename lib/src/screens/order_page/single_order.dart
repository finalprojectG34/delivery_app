import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../models/order.dart';

class SingleOrder extends StatelessWidget {
  final Order order;

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

  const SingleOrder({Key? key, required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime getDate(String date) {
      return DateTime.parse(date);
    }

    return Container(
      margin: EdgeInsets.all(16),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${order.id}',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
          ),
          SizedBox(height: 5),
          Text(
            'Order date: ${getDate(order.createdAt!).day} ${months[getDate(order.createdAt!).month]}, ${getDate(order.createdAt!).year}',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
          Divider(color: Colors.grey),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Order status',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              Text('${order.deliveryStatus}',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey))
            ],
          ),
          SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Items',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              Text('${order.orderItems?.length.toString()}',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))
            ],
          ),
          SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'price',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              Text('ETB 299',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))
            ],
          )
        ],
      ),
    );
  }
}
