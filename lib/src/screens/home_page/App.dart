import 'package:delivery_app/src/app.dart';
import 'package:delivery_app/src/screens/order_page/received_orders_page.dart';
import 'package:delivery_app/src/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';

import '../add_item/add_item.dart';
import '../auth/login/login.dart';
import '../components/add_shop.dart';
import 'AppCtx.dart';

class App extends StatefulWidget {
  const App({Key? key, this.index}) : super(key: key);
  final int? index;

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  bool searchBar = false;
  late Widget body;
  final storage = Get.find<FlutterSecureStorage>();

  late AppBar appbar;
  late String appbarName;

  @override
  void initState() {
    super.initState();
    getToken();
    body = const ReceivedOrdersPage();
  }

  getToken() async {
    String? value = await storage.read(key: 'token');
    print('token $value');
  }

  Widget _mapIndexToPage(int index) {
    final AppController appController = Get.find();
    getToken();
    switch (index) {
      case 1:
        if (appController.isAuthenticated.isFalse) {
          Get.snackbar(
              'Sign in', 'You need to sign in first before you add item',
              snackPosition: SnackPosition.BOTTOM);
          appController.changePage('Account', 4);
        } else if (appController.hasShopId.isTrue &&
            appController.userRole.value == 'SELLER') {
          appController.changePage('Add Item', index);
        } else if (appController.hasShopId.isTrue &&
            appController.userRole.value == 'USER') {
          appController.changePage('Pending', index);
        } else {
          appController.changePage('Register as seller', index);
        }
        return appController.isAuthenticated.isTrue
            ? appController.hasShopId.isTrue &&
                    appController.userRole.value == 'SELLER'
                ? AddItem(
                    hasAppbar: false,
                  )
                : appController.hasShopId.isTrue &&
                        appController.userRole.value == 'USER'
                    ? Padding(
                        padding: const EdgeInsets.all(20),
                        child: Center(
                          child: Text(
                            'Your request to be a seller is under review. You will be a seller as soon as the review is complete.',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      )
                    : AddShop(redirectFrom: 'home')
            : Container();
      case 2:
        appController.getUserInfo();
        appController.changePage('Profile', index);
        return appController.isAuthenticated.isTrue ? ProfilePage() : Login();
      case 0:
      default:
        appController.changePage('Order', index);
        return appController.isAuthenticated.isTrue
            ? ReceivedOrdersPage()
            : Login();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetX<AppController>(
      builder: (ctx) {
        return Scaffold(
          body: _mapIndexToPage(ctx.selectedIndex.value),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: ctx.selectedIndex.value,
            type: BottomNavigationBarType.fixed,
            onTap: _mapIndexToPage,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.my_library_books_outlined), label: 'Orders'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.my_library_books_outlined),
                  label: 'My Company'),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_outline_rounded),
                label: 'Profile',
              ),
            ],
          ),
        );
      },
    );
  }
}
