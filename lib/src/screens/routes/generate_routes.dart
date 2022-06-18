import 'package:delivery_app/src/app.dart';
import 'package:delivery_app/src/screens/auth/login/login.dart';
import 'package:delivery_app/src/screens/home_page/AppCtx.dart';
import 'package:delivery_app/src/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

class RouteGenerator {
  FlutterSecureStorage storage = Get.find();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    AppController appController = Get.find();
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
            builder: (_) =>
                appController.isAuthenticated.isTrue ? App() : Login());
      // case '/home':
      //   return MaterialPageRoute(builder: (context) => App());
      // case '/add_item':
      //   return MaterialPageRoute(
      //       builder: (context) => const AddItem(
      //             hasAppbar: true,
      //           ));
      // case '/select_category':
      //   return MaterialPageRoute(
      //       builder: (context) => CategorySelectList(
      //             isOnSubcategoryPage: false,
      //           ));
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
