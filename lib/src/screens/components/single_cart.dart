import 'package:delivery_app/helper/constance.dart';
import 'package:delivery_app/src/models/cart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../cart_page/cart_page_ctx.dart';

class SingleCart extends StatefulWidget {
  const SingleCart({Key? key, required this.cart}) : super(key: key);

  final Cart cart;

  @override
  State<SingleCart> createState() => _SingleCartState();
}

class _SingleCartState extends State<SingleCart> {
  TextEditingController frequencyController = TextEditingController();
  final CartPageController cartPageController = Get.find();
  int frequency = 1;

  @override
  Widget build(BuildContext context) {
    frequencyController.text = '1';
    return Card(
      child: SizedBox(
        height: 120,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Image.asset(
                'assets/images/img.png',
                fit: BoxFit.fitHeight,
                height: 120,
              ),
            ),
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            widget.cart.name!,
                            maxLines: 3,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: color1,
                            ),
                          ),
                        ),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.end,
                        //   children: [
                        const SizedBox(
                          width: 10,
                        ),
                        const SizedBox(width: 10),
                        GestureDetector(
                          onTap: () {
                            cartPageController.deleteCart(widget.cart.id);
                          },
                          // splashRadius: 20,
                          child: const Icon(
                            Icons.delete_outline_rounded,
                            color: Colors.grey,
                            size: 30,
                          ),
                        ),
                      ],
                      //   )
                      // ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'ETB ${widget.cart.price}',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.blue),
                        ),
                        SizedBox(
                          width: 100,
                          height: 26,
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextButton(
                                    child: const Icon(
                                      Icons.remove,
                                    ),
                                    style: TextButton.styleFrom(
                                      padding: EdgeInsets.zero,
                                    ),
                                    onPressed: () async {
                                      // await FocusScope.of(context).unfocus();
                                      // incomeAndExpenseController.decreaseFrequencyValue(
                                      //     widget.categoryModel.id,
                                      //     widget.categoryModel.categoryId);
                                    },
                                  ),
                                ),
                                Expanded(
                                    flex: 2,
                                    child: Container(
                                      padding: EdgeInsets.zero,
                                      decoration: const BoxDecoration(
                                        color: color2,
                                      ),
                                      child: Text(
                                        '$frequency',
                                        textAlign: TextAlign.center,
                                      ),
                                    )
//                                   TextField(
//                                     onTap: () {
//                                       // frequency = widget.categoryModel.frequency.toString();
//                                     },
//                                     enabled: false,
//                                     // focusNode: frequencyFocusNode,
//                                     keyboardType: TextInputType.number,
//                                     controller: frequencyController,
//                                     textAlign: TextAlign.center,
// // textAlignVertical: TextAlignVertical.center,
//                                     decoration: const InputDecoration(
//                                       fillColor: color2,
//                                       focusColor: color2,
//                                       enabledBorder: InputBorder.none,
//                                       focusedBorder: InputBorder.none,
//                                       border: InputBorder.none,
//                                       filled: true,
//
//                                       // enabledBorder: OutlineInputBorder(
//                                       //   borderSide: BorderSide(
//                                       //       color: Colors.green, width: 0.5),
//                                       // ),
//                                       // focusedBorder: OutlineInputBorder(
//                                       //   borderSide: BorderSide(
//                                       //       color: Colors.green, width: 0.75),
//                                       // ),
//                                       // contentPadding: EdgeInsets.only(bottom: 20),
//                                     ),
//                                     showCursor: false,
//
//                                     onChanged: (givenFrequency) {
//                                       print('given $givenFrequency');
//                                       // frequency = givenFrequency;
//                                     },
//                                     onEditingComplete: () {
//                                       FocusScope.of(context).unfocus();
//                                     },
//                                   ),
                                    ),
                                Expanded(
                                  // flex: 2,
                                  child: TextButton(
                                    child: const Center(
                                      child: Icon(Icons.add),
                                    ),
                                    style: OutlinedButton.styleFrom(
                                        padding: EdgeInsets.zero),
                                    onPressed: () {
                                      // await FocusScope.of(context).unfocus();
                                      // incomeAndExpenseController.increaseFrequencyValue(
                                      //     widget.categoryModel.id,
                                      //     widget.categoryModel.categoryId);
                                      setState(() {
                                        frequencyController.text =
                                            '${frequency++}';
                                        // frequencyController.value.copyWith(
                                        //     text:
                                        //         '${frequency++}');
                                      });
                                    },
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
