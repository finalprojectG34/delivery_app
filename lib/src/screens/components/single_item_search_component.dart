import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SingleItemSearch extends StatelessWidget {
  final variable;

  const SingleItemSearch({Key? key, this.variable}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Image.network(variable['poster']),
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
              flex: 5,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    variable['name'],
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                        color: Colors.green.shade300,
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    child: Text(
                      variable['attrs'][0]['val'],
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      if (variable['price']['discountPrice'] != null)
                        Text(
                          variable['price']['discountPrice'].toString(),
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      if (variable['price']['discountPrice'] != null)
                        SizedBox(
                          width: 20,
                        ),
                      Text(
                        variable['price']['sale'].toString(),
                        style: TextStyle(
                            fontSize: 18,
                            color: variable['price']['discountPrice'] != null
                                ? Colors.grey
                                : null,
                            fontWeight: FontWeight.bold,
                            decoration:
                                variable['price']['discountPrice'] != null
                                    ? TextDecoration.lineThrough
                                    : null),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
