class Item {
  const Item({
    this.id,
    this.name,
    this.price,
    this.discountPrice,
    this.category,
    this.shopId,
    this.imagePath,
    this.description,
    // this.amount,
  });

  final String? id;
  final String? name;
  final String? price;
  final String? discountPrice;
  final String? shopId;
  final String? category;
  final String? imagePath;
  final String? description;

  // final double? amount;

  factory Item.fromJson(Map<String, dynamic> json) {
    Item item = Item(
      id: json['id'],
      name: json['name'],
      price: json['price']['sale'].toString(),
      discountPrice: json['price']['discountPrice'].toString(),
      category: json['category'],
      shopId: json['shopId'],
      imagePath: json['image'],
      description: json['desc'],
      // amount: double.parse(json['count']),
    );
    return item;
  }

  @override
  String toString() {
    return '{id: $id name $name price $price category $category imagePath $imagePath description $description}';
  }
}
