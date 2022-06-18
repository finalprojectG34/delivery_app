import 'package:flutter/material.dart';

class ShopDetail extends StatelessWidget {
  const ShopDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('shop detail')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 28,
                      // backgroundColor: Colors.white,
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(
                            'https://www.woolha.com/media/2020/03/eevee.png'),
                        radius: 25,
                      ),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Shop larson electronic',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Official store',
                          style: TextStyle(fontSize: 16),
                        )
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child:
                            Text('Jawa Barat, Bandung (Jam Buka 08:00-21:00)')),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Text(
                          'Total product',
                          style: TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          '150 item',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          'Joined date',
                          style: TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          '20 oct 2021',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
