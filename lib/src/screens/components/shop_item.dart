import 'package:delivery_app/src/models/shop.dart';
import 'package:flutter/material.dart';

class ShopItem extends StatelessWidget {
  const ShopItem({Key? key, required this.shop}) : super(key: key);

  final Shop shop;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Expanded(
            child: Stack(
              alignment: AlignmentDirectional.topStart,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(.5),
                    borderRadius: BorderRadius.circular(10),
                    // border: Border.all(color: Colors.grey),
                  ),
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        '${shop.name}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.location_on_outlined,
                            color: Colors.white,
                          ),
                          Text('${shop.address?.addressName}')
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                  transform: Matrix4.translationValues(0.0, 25.0, 0.0),
                  padding: const EdgeInsets.only(left: 10),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: CircleAvatar(
                      radius: 28,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        backgroundImage: NetworkImage('${shop.image}'),
                        radius: 25,
                        // onBackgroundImageError: (o,s){},
                        // onForegroundImageError: (o,s){},
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.phone),
                const SizedBox(width: 5),
                Text('${shop.phoneNumber}'),
                const SizedBox(width: 10),
                const Icon(
                  Icons.arrow_forward,
                  color: Colors.grey,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
