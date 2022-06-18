class Cart {
  const Cart({
    this.id,
    this.itemId,
    this.name,
    this.price,
    this.amount,
    this.status,
    this.userId,
    this.shopId,
  });

  final String? id;
  final String? itemId;
  final String? name;
  final String? price;
  final String? amount;
  final String? status;
  final String? userId;
  final String? shopId;

  factory Cart.fromJson(Map<String, dynamic> json) {
    Cart item = Cart(
      id: json['id'],
      itemId: json['itemId'],
      name: json['name'],
      price: json['price'].toString(),
      amount: json['amount'].toString(),
      status: json['status'],
      userId: json['userId'],
      shopId: json['shopId'],
    );
    return item;
  }

  @override
  String toString() {
    return '{id: $id name: $name price: $price}';
  }
}
