import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {
  final String title;
  final String imagePath;

  const CategoryItem({Key? key, required this.title, required this.imagePath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: Colors.blue.shade100,
          child: Image.network(
            imagePath,
            fit: BoxFit.cover,
            errorBuilder: (error, o, s) => const Text(""),
          ),
          radius: 40,
        ),
        Text(
          title,
        )
      ],
    );
  }
}
