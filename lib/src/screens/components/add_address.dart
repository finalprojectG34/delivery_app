import 'package:delivery_app/src/screens/components/single_address.dart';
import 'package:flutter/material.dart';

import 'address_input.dart';

class AddAddress extends StatelessWidget {
  static const String pathName = '/add_address';

  const AddAddress({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Modify Address'),
      ),
      body: Column(
        children: [
          // Padding(
          //   padding: EdgeInsets.only(top: 20, bottom: 20),
          //   child: Row(
          //     children: [
          //       IconButton(
          //         icon: Icon(Icons.chevron_left, size: 30),
          //         onPressed: () => Navigator.pop(context),
          //       ),
          //       Padding(
          //         padding: EdgeInsets.only(left: 20),
          //         child: Text(
          //           "Add Address",
          //           style: TextStyle(
          //             fontSize: 25,
          //             fontWeight: FontWeight.bold,
          //           ),
          //         ),
          //       )
          //     ],
          //   ),
          // ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: ListView(
              shrinkWrap: true,
              children: [
                SingleAddress(
                    address1: 'Addis Ababa', address2: 'Kolfe keranyo'),
              ],
            ),
          ),
          TextButton(
              onPressed: () {
                showModalBottomSheet(
                  isDismissible: true,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                  ),
                  context: context,
                  builder: (context) => Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 10),
                    child: AddressInput(address1: '', address2: ''),
                  ),
                );
              },
              child: Text('Add new location')),
        ],
      ),
    );
  }
}
