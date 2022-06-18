import 'package:flutter/material.dart';

import 'address_input.dart';

class SingleAddress extends StatelessWidget {
  final String address1;
  final String address2;

  const SingleAddress(
      {Key? key, required this.address1, required this.address2})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      margin: EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!, width: 2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  address1,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  address2,
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ],
            ),
          ),
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.edit, color: Colors.blue[500]),
                onPressed: () => {
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
                      child:
                          AddressInput(address1: address1, address2: address2),
                    ),
                  )
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.delete_forever,
                  color: Colors.red[400],
                ),
                onPressed: () => {},
              )
            ],
          ),
        ],
      ),
    );
  }
}
