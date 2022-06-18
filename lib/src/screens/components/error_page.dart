import 'package:flutter/material.dart';

Widget errorPage(
    {Function()? onTryAgain, String errorMessage = "Something went wrong"}) {
  return Center(
    child: Column(
      children: [
        Text(errorMessage),
        const SizedBox(
          height: 10,
        ),
        ElevatedButton(onPressed: onTryAgain, child: const Text("Try Again"))
      ],
    ),
  );
}
