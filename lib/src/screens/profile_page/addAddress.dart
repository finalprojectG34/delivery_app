// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// class AddAddress extends StatelessWidget {
//   static const String pathName = '/add_address';
//
//   const AddAddress({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Modify Address'),),
//       body: Column(
//         children: [
//           // Padding(
//           //   padding: EdgeInsets.only(top: 20, bottom: 20),
//           //   child: Row(
//           //     children: [
//           //       IconButton(
//           //         icon: Icon(Icons.chevron_left, size: 30),
//           //         onPressed: () => Navigator.pop(context),
//           //       ),
//           //       Padding(
//           //         padding: EdgeInsets.only(left: 20),
//           //         child: Text(
//           //           "Add Address",
//           //           style: TextStyle(
//           //             fontSize: 25,
//           //             fontWeight: FontWeight.bold,
//           //           ),
//           //         ),
//           //       )
//           //     ],
//           //   ),
//           // ),
//           SizedBox(height: 10,),
//           Padding(
//             padding: EdgeInsets.only(left: 20, right: 20),
//             child: Column(
//
//               children: [
//                 Container(
//                   padding: EdgeInsets.all(15),
//                   margin: EdgeInsets.only(bottom: 15),
//                   decoration: BoxDecoration(
//                     border: Border.all(color: Colors.grey[300]!, width: 2),
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                   child: Row(
//                     children: [
//                       Expanded(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               "HELLO",
//                               style: TextStyle(fontWeight: FontWeight.bold),
//                             ),
//                             SizedBox(height: 2,),
//                             Text(
//                               "Alembank",
//                               style: TextStyle(color: Colors.grey[600]),
//                             ),
//                           ],
//                         ),
//                       ),
//                       Row(
//                         children: [
//                           IconButton(
//                             icon: Icon(Icons.edit, color: Colors.blue[500]),
//                             onPressed: () => {
//                               showModalBottomSheet(
//                                 backgroundColor: Colors.transparent,
//                                 context: context,
//                                 builder: (context) => EditAddress(),
//                               )
//                             },
//                           ),
//                           IconButton(
//                             icon: Icon(
//                               Icons.delete_forever,
//                               color: Colors.red[400],
//                             ),
//                             onPressed: () => {},
//                           )
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 20),
//             child: Row(
//               children: [
//                 IconButton(
//                     icon: Icon(Icons.add),
//                     onPressed: () => {
//                           showModalBottomSheet(
//                             backgroundColor: Colors.transparent,
//                             context: context,
//                             builder: (context) => AddAddresses(),
//                           )
//                         }),
//                 Text(
//                   "Add New Location",
//                   style: TextStyle(
//                     color: Colors.grey[600],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class EditAddress extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.only(top: 20, left: 20),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(40),
//           topRight: Radius.circular(40),
//         ),
//       ),
//       child: Column(
//         children: [
//           Row(
//             children: [
//               IconButton(
//                 icon: Icon(Icons.edit),
//                 onPressed: () => {},
//               ),
//               Text(
//                 "Edit",
//                 style: TextStyle(
//                   fontWeight: FontWeight.bold,
//                   fontSize: 25,
//                 ),
//               )
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class AddAddresses extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.only(top: 20, left: 20),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(40),
//           topRight: Radius.circular(40),
//         ),
//       ),
//       child: Column(
//         children: [
//           Row(
//             children: [
//               IconButton(
//                 icon: Icon(Icons.add),
//                 onPressed: () => {},
//               ),
//               Text(
//                 "Add Address",
//                 style: TextStyle(
//                   fontWeight: FontWeight.bold,
//                   fontSize: 25,
//                 ),
//               )
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
