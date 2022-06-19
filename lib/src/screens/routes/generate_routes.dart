import 'package:delivery_app/src/app.dart';
import 'package:delivery_app/src/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

class RouteGenerator {
  FlutterSecureStorage storage = Get.find();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => App());
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return const Scaffold(
        body: Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}

class PageArgument {
  final dynamic item;
  final bool? edit;

  PageArgument({this.item, this.edit});
}
