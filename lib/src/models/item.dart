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
    this.poster,
    this.attrs,
    this.ctgId,
    this.ctgPath,
    this.department,
    this.ratingAverage,
    this.ratingQuantity,
    this.specs,
    this.tags,
    this.updatedAt,
    this.variants,
    this.amount,
  });

  final String? id;
  final String? name;
  final Price? price;
  final String? discountPrice;
  final String? shopId;
  final String? category;
  final String? imagePath;
  final String? description;
  final String? poster;
  final String? ctgPath;
  final String? ctgId;
  final String? department;
  final List<ItemAttribute>? attrs;
  final List<ItemAttribute>? specs;
  final ItemVariant? variants;
  final List<String>? tags;
  final String? updatedAt;
  final double? ratingAverage;
  final double? ratingQuantity;

  final int? amount;

  factory Item.fromJson(Map<String, dynamic> json) {
    Item item = Item(
      id: json['id'],
      name: json['name'],
      price: json["price"] != null ? Price.fromJson(json["price"]) : null,
      discountPrice: json['price']['discountPrice'].toString(),
      category: json['category'],
      shopId: json['shopId'],
      imagePath: json['image'],
      description: json['desc'],
      poster: json["poster"],
      attrs: json["attrs"] != null
          ? List.of(json["attrs"])
              .map((e) => ItemAttribute.fromJson(e))
              .toList()
          : null,
      specs: json["specs"] != null
          ? List.of(json["specs"])
              .map((e) => ItemAttribute.fromJson(e))
              .toList()
          : null,
      variants: json["variants"] != null
          ? ItemVariant.fromJson(json["variants"])
          : null,
      tags: json["tags"] != null
          ? List.of(json["tags"]).map((e) => e.toString()).toList()
          : null,
      ctgId: json["ctgId"],
      ctgPath: json["ctgPath"],
      department: json["department"],
      ratingAverage: double.parse(json["ratingAverage"]),
      ratingQuantity: double.parse(json["ratingQuantity"]),
      updatedAt: json["updatedAt"],
      amount: int.parse(json['count']),
    );
    return item;
  }

  @override
  String toString() {
    return '{id: $id name $name price $price category $category imagePath $imagePath description $description}';
  }
}

class ItemAttribute {
  final String? name;
  final String? val;

  ItemAttribute({this.name, this.val});

  factory ItemAttribute.fromJson(Map<String, dynamic> json) {
    return ItemAttribute(name: json["name"], val: json["val"]);
  }
}

class ItemVariant {
  final String? cnt;
  final List<VariantAttr>? variantAttr;

  ItemVariant({this.cnt, this.variantAttr});

  factory ItemVariant.fromJson(Map<String, dynamic> json) {
    return ItemVariant(
        cnt: json["cnt"],
        variantAttr: json["attrs"] is List
            ? List.of(json["attrs"])
                .map((e) => VariantAttr.fromJson(e))
                .toList()
            : null);
  }
}

class VariantAttr {
  final String? dispType;
  final String? name;

  VariantAttr({this.dispType, this.name});

  factory VariantAttr.fromJson(Map<String, dynamic> json) {
    return VariantAttr(name: json["name"], dispType: json["dispType"]);
  }
}

class Price {
  final int? discountPrice;
  final String? sale;

  Price({this.discountPrice, this.sale});

  factory Price.fromJson(Map<String, dynamic> json) {
    return Price(
      discountPrice: json["discountPrice"],
      sale: json["sale"].toString(),
    );
  }
}
