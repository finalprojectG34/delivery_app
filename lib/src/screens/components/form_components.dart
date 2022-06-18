// import 'package:flutter/material.dart';
//
// Widget formName(item, TextEditingController nameController,  Function onSaved, [String hint, Function validator, ]) {
//   if (item == null && nameController.text.trim() == '') {
//     nameController.text = '';
//   } else if (item != null && nameController.text.trim() == '') {
//     nameController.text = item.name;
//   }
//   return Padding(
//     padding: const EdgeInsets.all(12.0),
//     //=============== Name Form ===============
//     child: TextFormField(
//       controller: nameController,
//       decoration: InputDecoration(hintText: hint),
//       validator: (value) => validator(value),
//       onSaved: onSaved,
//     ),
//   );
// }
//
// Widget formEmail(item, TextEditingController nameController,  Function onSaved, [String hint, Function validator, ]) {
//   if (item == null && nameController.text.trim() == '') {
//     nameController.text = '';
//   } else if (item != null && nameController.text.trim() == '') {
//     nameController.text = item.email;
//   }
//   return Padding(
//     padding: const EdgeInsets.all(12.0),
//     //=============== Name Form ===============
//     child: TextFormField(
//       keyboardType: TextInputType.emailAddress,
//       controller: nameController,
//       decoration: InputDecoration(hintText: hint),
//       validator: (value) => validator(value),
//       onSaved: onSaved,
//     ),
//   );
// }
//
// Widget formPassword(item, TextEditingController nameController,  Function onSaved, [String hint, Function validator, ]) {
//   if (item == null && nameController.text.trim() == '') {
//     nameController.text = '';
//   } else if (item != null && nameController.text.trim() == '') {
//     nameController.text = item.password;
//   }
//   return Padding(
//     padding: const EdgeInsets.all(12.0),
//     //=============== Name Form ===============
//     child: TextFormField(
//       obscureText: true,
//       controller: nameController,
//       decoration: InputDecoration(hintText: hint),
//       validator: (value) => validator(value),
//       onSaved: onSaved,
//     ),
//   );
// }
//
// Widget formNumber(item, TextEditingController textControler,  Function onSaved,[String hint ]) {
//   if (item == null && textControler.text.trim() == '') {
//     textControler.text = '';
//   } else if (item != null && textControler.text.trim() == '') {
//     textControler.text = item.price;
//   }
//   return Padding(
//     padding: const EdgeInsets.all(8.0),
//     child: TextFormField(
//         controller: textControler,
//         decoration: InputDecoration(labelText: hint, hintMaxLines: 6),
//         keyboardType: TextInputType.number,
//         obscureText: false,
// //        initialValue: product == null ? '' : product.price.toString(),
//         validator: (String value) {
// //          this regExp accepts both comma and decimal as a valure
//           if (value.isEmpty ||
//               !RegExp(r'^(?:[1-9]\d*|0)?(?:[.,]d+)?$').hasMatch(value)) {
//             return 'this value is a number and required';
//           }
//           return null;
//         },
//         onSaved: onSaved
//     ),
//   );
// }
//
// Widget formPhone(item, TextEditingController textControler,  Function onSaved,[String hint ]) {
//   if (item == null && textControler.text.trim() == '') {
//     textControler.text = '';
//   } else if (item != null && textControler.text.trim() == '') {
//     textControler.text = item.phone;
//   }
//   return Padding(
//     padding: const EdgeInsets.all(8.0),
//     child: TextFormField(
//         controller: textControler,
//         decoration: InputDecoration(labelText: hint, hintMaxLines: 6),
//         keyboardType: TextInputType.number,
//         obscureText: false,
// //        initialValue: product == null ? '' : product.price.toString(),
//         validator: (String value) {
// //          this regExp accepts both comma and decimal as a valure
//           if (value.isEmpty ||
//               !RegExp(r'^(?:[1-9]\d*|0)?(?:[.,]d+)?$').hasMatch(value)) {
//             return 'this value is a number and required';
//           }
//           return null;
//         },
//         onSaved: onSaved
//     ),
//   );
// }
//
//
//
// Widget formDescription(item, TextEditingController textController, Function onSaved) {
//
//   if (item == null && textController.text.trim() == '') {
//     textController.text = '';
//   } else if (item != null && textController.text.trim() == '') {
//     textController.text = item.description;
//   }
//   return Padding(
//     padding: const EdgeInsets.all(8.0),
//     child: TextFormField(
//         controller: textController,
//         maxLines: 2,
//         decoration: InputDecoration(labelText: 'description'),
//
//         validator: (String value) {
//           if (value.isEmpty || value.length < 5) {
//             return '* description must be > 5 letters';
//           }
//           return null;
//         },
//         onSaved: onSaved
//     ),
//   );
// }
