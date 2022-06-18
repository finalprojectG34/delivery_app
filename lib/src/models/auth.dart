import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class AuthInfo extends Equatable {
  AuthInfo({this.info, this.info_type, this.password});

  final String? info;
  final String? info_type;
  final String? password;

  @override
  List<Object?> get props => [info, info_type, password];

  factory AuthInfo.fromJson(Map<String, dynamic> json) {
    return AuthInfo(
      info: json['id'],
      info_type: json['title'],
      password: json['code'],
    );
  }

  @override
  String toString() => 'AuthInfo { info: $info, password: $password }';
}
