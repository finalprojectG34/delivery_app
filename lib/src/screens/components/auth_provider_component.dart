import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class AuthProvider extends StatelessWidget {
  final String providerName;
  final String providerIconName;

  const AuthProvider(
      {Key? key, required this.providerName, required this.providerIconName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        shape: MaterialStateProperty.all(RoundedRectangleBorder(
            side: BorderSide(color: Colors.grey[200]!),
            borderRadius: BorderRadius.circular(8))),
        elevation: MaterialStateProperty.all(0),
        backgroundColor: MaterialStateProperty.all(Colors.transparent),
        fixedSize: MaterialStateProperty.all(
          Size(Get.width, 54),
        ),
      ),
      onPressed: () {},
      child: Row(
        children: const [
          FaIcon(FontAwesomeIcons.google, color: Colors.lightBlue),
          Expanded(
            child: Center(
              child: Text(
                "Login with Google",
                style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: 13),
              ),
            ),
          )
        ],
      ),
    );
  }
}
