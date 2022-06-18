import 'package:delivery_app/src/models/user.dart';

class Order {
  const Order({
    this.id,
    this.deliveryStatus,
    this.userId,
    this.shopId,
    this.orderItems,
    this.subTotal,
    this.actions,
    this.deliveryAddress,
    this.createdAt,
    this.orderActions,
    this.deliveryId,
  });

  final String? id;
  final String? deliveryStatus;
  final String? userId;
  final String? shopId;
  final List<OrderItem>? orderItems;
  final List<OrderAction>? orderActions;
  final String? subTotal;
  final String? actions;
  final String? createdAt;
  final String? deliveryId;
  final Address? deliveryAddress;

  factory Order.fromJson(Map<String, dynamic> json) {
    Order item = Order(
      id: json['id'],
      deliveryStatus: json['deliveryStatus'],
      userId: json['userId'],
      shopId: json['shopId'],
      deliveryId: (json['deliveryId'] != null) ? json['deliveryId'] : "",
      orderItems: (json['orderItems'] != null)
          ? (json['orderItems'] as List)
              .map((e) => OrderItem.fromJson(e))
              .toList()
          : [],
      orderActions: (json['actions'] != null)
          ? (json['actions'] as List)
              .map((e) => OrderAction.fromJson(e))
              .toList()
          : [],
      subTotal: (json['subTotal'] != null) ? json['subTotal'].toString() : "",
      createdAt: json['createdAt'],
      deliveryAddress: (json['deliveryAddress'] != null)
          ? Address.fromJson(json['deliveryAddress'])
          : Address(),
    );
    return item;
  }

  @override
  String toString() {
    return '{id: $id deliveryStatus: $deliveryStatus userId: $userId, createdAt: $createdAt}';
  }
}

class OrderItem {
  const OrderItem({
    this.id,
    this.name,
    this.price,
    this.amount,
  });

  final String? id;
  final String? name;
  final String? price;
  final String? amount;

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    OrderItem item = OrderItem(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      amount: json['amount'],
    );
    return item;
  }

  @override
  String toString() {
    return '{id: $id name: $name, price: $price, amountL $amount }';
  }
}

class OrderAction {
  const OrderAction({
    this.date,
    this.messages,
    this.type,
  });

  final String? date;
  final String? messages;
  final String? type;

  factory OrderAction.fromJson(Map<String, dynamic> json) {
    OrderAction item = OrderAction(
      date: json['date'],
      messages: json['messages'],
      type: json['type'],
    );
    return item;
  }

  @override
  String toString() {
    return '{date: $date type: $type, messages: $messages }';
  }
}
