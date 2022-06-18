import 'dart:async';

import 'package:delivery_app/src/models/models.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

import '../../../data/repository/cart_repository.dart';

class CartPageController extends GetxController {
  final CartRepository cartRepository;

  final storage = Get.find<FlutterSecureStorage>();

  CartPageController({required this.cartRepository});

  RxBool isCartFetchedFromDB = false.obs;
  RxList<Cart>? cartList = <Cart>[].obs;

  RxString err = ''.obs;
  RxBool errOccurred = false.obs;
  RxBool isCartLoading = false.obs;
  RxDouble totalPrice = (0.0).obs;
  RxDouble shippingPrice = (0.0).obs;

  @override
  void onInit() async {
    super.onInit();
    await getCart();
  }

  calculatePrice() {
    var temp = 0.0;
    cartList?.forEach((cart) {
      temp += double.parse(cart.price!);
    });
    totalPrice(temp);
  }

  getCart() async {
    isCartLoading(true);
    try {
      List<Cart> carts = await cartRepository.getCart();
      cartList!(carts);
      calculatePrice();
    } on TimeoutException catch (e) {
      err(e.message);
      errOccurred(true);
    } catch (e) {
      err('Some error occurred');
      errOccurred(true);
    }
    isCartLoading(false);
  }

  addToCart(Cart cart) async {
    await cartRepository.addToCart(cart);
  }

  deleteCart(cartId) async {
    await cartRepository.deleteCart(cartId);
    cartList!(cartList?.where((p0) => p0.id != cartId).toList());
    calculatePrice();
  }
}
