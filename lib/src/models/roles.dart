import 'package:delivery_app/src/utils/loger/console_loger.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class Role extends Equatable {
  Role({this.id, @required this.name});

  final String? id;
  final String? name;

  @override
  List<Object?> get props => [id, name];

  factory Role.fromJson(Map<String, dynamic> json) {
    logTrace("inFactory");
    Role role = Role(
      id: json['_id'],
      name: json['username'],
    );
    return role;
  }

  @override
  String toString() => 'User { id: $id, name: $name }';
}
