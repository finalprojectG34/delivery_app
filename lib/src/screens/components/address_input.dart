import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class AddressInput extends StatefulWidget {
  const AddressInput({Key? key, required this.address1, required this.address2})
      : super(key: key);
  final String address1;
  final String address2;

  @override
  State<AddressInput> createState() => _AddressInputState();
}

class _AddressInputState extends State<AddressInput> {
  final TextEditingController address1Controller = TextEditingController();
  final TextEditingController address2Controller = TextEditingController();
  FocusNode address1FocusNode = FocusNode();
  String address1 = '';
  String address2 = '';

  @override
  void initState() {
    super.initState();
    address1FocusNode.addListener(onAddress1FocusChange);
    address1Controller.text = widget.address1;
    address2Controller.text = widget.address2;
  }

  void onAddress1FocusChange() {
    if (!address1FocusNode.hasFocus) {
      setState(() {
        address1Controller.text = address1;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // address1Controller.text = address1;
    address1Controller.value.copyWith(text: address1);
    address2Controller.value.copyWith(text: address2);
    // address2Controller.text = widget.address2;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 10,
        ),
        const Text(
          'Enter the city you live in',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(
          height: 10,
        ),
        TextField(
          keyboardType: TextInputType.text,
          controller: address1Controller,
          focusNode: address1FocusNode,
          decoration: const InputDecoration(
            // enabledBorder: OutlineInputBorder(
            //   borderSide: BorderSide(color: Colors.blue, width: 0.5),
            // ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blue, width: 0.75),
            ),
            labelText: 'Area of living',
            labelStyle: TextStyle(
              fontSize: 16,
              color: Colors.blue,
            ),
            contentPadding: EdgeInsets.only(left: 20, bottom: 20),
          ),
          onChanged: (value) {
            address1 = value;
          },
          onEditingComplete: () {
            FocusScope.of(context).unfocus();
          },
        ),
        const SizedBox(
          height: 20,
        ),
        const Text(
          'Enter the sub city you live in',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(
          height: 10,
        ),
        TextField(
          keyboardType: TextInputType.text,
          controller: address2Controller,
          decoration: const InputDecoration(
            // enabledBorder: OutlineInputBorder(
            //   borderSide: BorderSide(color: Colors.green, width: 0.5),
            // ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blue, width: 0.75),
            ),
            labelText: 'Sub-City',
            labelStyle: TextStyle(
              fontSize: 16,
              color: Colors.blue,
            ),
            contentPadding: EdgeInsets.only(left: 20, bottom: 20),
          ),
          onChanged: (value) {
            address2 = value;
          },
          onEditingComplete: () {
            FocusScope.of(context).unfocus();
          },
        ),
        SizedBox(
          height: 20,
        ),
        ElevatedButton(
          style: ButtonStyle(
            shadowColor: MaterialStateProperty.all(Colors.lightBlueAccent),
            elevation: MaterialStateProperty.all(6),
            backgroundColor: MaterialStateProperty.all(const Color(0xff40BFFF)),
            fixedSize: MaterialStateProperty.all(Size(Get.width, 54)),
          ),
          onPressed: () async {},
          child: Text(
            '${widget.address1 == '' ? 'Add' : 'Update'}  location',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
