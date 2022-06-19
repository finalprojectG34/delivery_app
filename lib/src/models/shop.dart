import 'package:delivery_app/src/models/user.dart';

import 'category.dart';

class Shop {
  const Shop({
    this.id,
    this.name,
    this.description,
    this.ownerId,
    this.sellingCategories,
    this.image,
    this.phoneNumber,
    this.address,
    this.tinNumber,
    this.status,
    this.role,
  });

  final String? id;
  final String? name;
  final String? phoneNumber;
  final String? ownerId;
  final List<Category>? sellingCategories;
  final String? image;
  final String? description;
  final String? tinNumber;
  final String? status;
  final String? role;
  final Address? address;

  factory Shop.fromJson(Map<String, dynamic> json) {
    return Shop(
      id: json['id'],
      name: json['name'],
      phoneNumber: json["phoneNumber"],
      ownerId: json['ownerId'],
      image: json['image'] != null ? json['image']['imageCover'] : "",
      description: json['description'],
      tinNumber: json['tinNumber'],
      role: json['role'],
      status: json['status'],
      address:
          json["address"] != null ? Address.fromJson(json["address"]) : null,
      sellingCategories: json["sellingCategories"] != null
          ? List.from(json["sellingCategories"])
              .map((e) => Category.fromJson(e))
              .toList()
          : null,
    );
  }
}
