import 'package:flutter/material.dart';

class DeliveryDetail extends StatelessWidget {
  const DeliveryDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order'),
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Card(
              color: Colors.blue.shade300,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                        Text(
                          'ETB 300',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Divider(
                        color: Colors.white,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Condition',
                          style: TextStyle(color: Colors.white),
                        ),
                        Text(
                          'new',
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'RAM',
                          style: TextStyle(color: Colors.white),
                        ),
                        Text(
                          '2 GB',
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Internal HDD',
                          style: TextStyle(color: Colors.white),
                        ),
                        Text(
                          '300 GB',
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 25,
                      // backgroundColor: Colors.white,
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(
                            'https://www.woolha.com/media/2020/03/eevee.png'),
                        radius: 25,
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text('Delivery man name')
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 6,
                              backgroundColor: Colors.green,
                              child: CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 3,
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text('address 1 comes here'),
                          ],
                        ),
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 6,
                              backgroundColor: Colors.green,
                              child: CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 3,
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text('address 2 comes here'),
                          ],
                        ),
                      ],
                    ),
                    InkWell(
                      child: Container(
                        child: Icon(
                          Icons.call,
                          color: Colors.white,
                        ),
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Colors.blue,
                          // border: Border.all(color: Colors.grey),
                        ),
                      ),
                      borderRadius: BorderRadius.circular(50),
                      onTap: () {},
                    )
                  ],
                )
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.red),
                    // ButtonStyle(
                    //   shadowColor: MaterialStateProperty.all(
                    //       Colors.lightBlueAccent),
                    //   elevation: MaterialStateProperty.all(6),
                    //   backgroundColor: MaterialStateProperty.all(
                    //       const Color(0xff40BFFF)),
                    //   fixedSize: MaterialStateProperty.all(
                    //       Size(Get.width, 54)),
                    // ),
                    onPressed: () async {
                      // signUpController.signupUser({
                      //   "input": {
                      //     "firstName": firstName,
                      //     "lastName": lastName,
                      //     "phone": phoneNumber,
                      //     // "password": "my password"
                      //   }
                      // });

                      // ctx.sendFakeOtp();
                    },
                    child: const Text(
                      "Reject",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 13),
                    ),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.blue),
                    // ButtonStyle(
                    //   shadowColor: MaterialStateProperty.all(
                    //       Colors.lightBlueAccent),
                    //   elevation: MaterialStateProperty.all(6),
                    //   backgroundColor: MaterialStateProperty.all(
                    //       const Color(0xff40BFFF)),
                    //   fixedSize: MaterialStateProperty.all(
                    //       Size(Get.width, 54)),
                    // ),
                    onPressed: () async {
                      // signUpController.signupUser({
                      //   "input": {
                      //     "firstName": firstName,
                      //     "lastName": lastName,
                      //     "phone": phoneNumber,
                      //     // "password": "my password"
                      //   }
                      // });

                      // ctx.sendFakeOtp();
                    },
                    child: const Text(
                      "Accept",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        // fontSize: 13,
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
