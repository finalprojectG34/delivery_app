// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';
//
// import '../home_page/AppCtx.dart';
//
// class AppBarComponent {
//   static AppController appController = Get.find();
//   static bool hasSearchIcon;
//
//   AppBarComponent({ required this.hasSearchIcon});
//
//   static AppBar setAppBar(String name) {
//     return AppBar(
//       title: Text(name),
//       elevation: 2,
//       centerTitle: true,
//       actions: [
//         if (hasSearchIcon)
//           IconButton(
//             onPressed: () {
//               appController.disableSearchIcon();
//             },
//             icon: const Icon(Icons.search),
//           ),
//         IconButton(
//           onPressed: () {},
//           icon: const Icon(Icons.shopping_cart_outlined),
//         )
//       ],
//     );
//   }
// }
