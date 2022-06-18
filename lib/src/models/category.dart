import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class Category extends Equatable {
  const Category({this.id, this.name, this.description, this.image});

  final String? id;
  final String? name;
  final String? description;
  final String? image;

  @override
  List<Object?> get props => [id, name, description, image];

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      image: json['image'],
    );
  }

  @override
  String toString() =>
      'Category { id: $id, name: $name, description: $description, image: $image }';
}
