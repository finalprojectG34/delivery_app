import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class User extends Equatable {
  User({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.image,
    this.role,
    this.token,
    this.phone,
    this.password,
    this.profile,
    this.shopId,
    this.address,
  });

  final String? id;
  final String? shopId;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? phone;
  final String? password;
  final Address? address;

  String? profile;
  final String? role;

  final String? image;

  String? token;

  @override
  List<Object?> get props =>
      [id, firstName, email, role, image, password, phone];

  factory User.fromJson(Map<String, dynamic> json, {String? token}) {
    User item = User(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      role: json['role'],
      image: json['image'] != null ? json['image']['imageCover'] : "",
      token: token,
      password: json['password'],
      phone: json['phone'],
      shopId: json['shopId'],
      address: (json['address'] != null)
          ? Address.fromJson(json['address'])
          : Address(),
    );
    return item;
  }

  @override
  String toString() =>
      'User { id: $id, name: $firstName, email:$email, password: $password, phone: $phone }';
}

class Address extends Equatable {
  Address({
    this.subCity,
    this.city,
    this.addressName,
    this.country,
  });

  final String? subCity;
  final String? city;
  final String? addressName;
  final String? country;

  @override
  List<Object?> get props => [subCity, city, addressName];

  factory Address.fromJson(Map<String, dynamic> json, {String? token}) {
    Address item = Address(
      subCity: json['subCity'],
      city: json['city'],
      addressName: json['addressName'],
      country: json['country'],
    );
    return item;
  }

  @override
  String toString() =>
      'User { subCity: $subCity, city: $city, addressName: $addressName }';
}
