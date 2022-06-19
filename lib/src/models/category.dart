import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class Category extends Equatable {
  const Category(
      {this.id,
      this.name,
      this.description,
      this.image,
      this.slug,
      this.count,
      this.attributes,
      this.poster,
      this.path,
      this.parentId,
      this.subCategories});

  final String? id;
  final String? name;
  final String? description;
  final ImageModel? image;
  final String? slug;
  final String? poster;
  final String? path;
  final String? parentId;
  final int? count;
  final List<Attribute>? attributes;
  final List<Category>? subCategories;

  @override
  List<Object?> get props => [id, name, description, image];

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      image: json['image'] != null ? ImageModel.fromJson(json["image"]) : null,
      slug: json["slug"],
      count: json["count"],
      poster: json["poster"],
      attributes: json["attributes"] != null
          ? List.of(json["attributes"])
              .map((e) => Attribute.fromJson(e))
              .toList()
          : null,
      parentId: json["parentId"],
      path: json["path"],
      subCategories: json["subCategories"] != null
          ? List.of(json["subCategories"])
              .map((e) => Category.fromJson(e))
              .toList()
          : null,
    );
  }

  @override
  String toString() =>
      'Category { id: $id, name: $name, description: $description, image: $image }';
}

class Attribute {
  final String? name;
  final String? slug;
  final List<String>? categoryIds;
  final List<CurrentData>? currentData;
  final String? display;
  final List<String>? options;
  final List<String>? modifiers;
  final String? brandId;
  final bool? isRequired;
  final bool? otherSupported;
  final String? inputType;

  Attribute(
      {this.name,
      this.slug,
      this.categoryIds,
      this.currentData,
      this.display,
      this.options,
      this.modifiers,
      this.brandId,
      this.isRequired,
      this.otherSupported,
      this.inputType});

  factory Attribute.fromJson(Map<String, dynamic> json) {
    return Attribute(
        name: json["name"],
        slug: json["slug"],
        categoryIds: json["categoryIds"] != null
            ? List.of(json["categoryIds"]).map((e) => e.toString()).toList()
            : null,
        currentData: json["currentData"] != null
            ? List.of(json["currentData"])
                .map((e) => CurrentData.fromJson(e))
                .toList()
            : null,
        display: json["display"],
        options: json["options"] != null
            ? List.of(json["options"]).map((e) => e.toString()).toList()
            : null,
        brandId: json["brandId"],
        inputType: json["inputType"],
        modifiers: json["modifiers"] != null
            ? List.of(json["modifiers"]).map((e) => e.toString()).toList()
            : null,
        isRequired: json["isRequired"],
        otherSupported: json["otherSupported"]);
  }
}

class CurrentData {
  final String? value;
  final String? count;

  CurrentData({this.value, this.count});

  factory CurrentData.fromJson(Map<String, dynamic> json) {
    return CurrentData(count: json["count"], value: json["value"]);
  }
}

class ImageModel {
  final List<String>? images;
  final String? bgImage;
  final String? imageCover;
  final String? suffix;
  final String? imagePath;

  ImageModel(
      {this.images,
      this.bgImage,
      this.imagePath,
      this.imageCover,
      this.suffix});

  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(
        bgImage: json["bgImage"],
        imageCover: json["imageCover"],
        imagePath: json["imagePath"],
        images: json["images"] != null
            ? List.of(json["images"]).map((e) => e.toString()).toList()
            : null,
        suffix: json["suffix"]);
  }
}
