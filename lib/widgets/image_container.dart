import 'package:flutter/material.dart';

class ImageContainer extends StatelessWidget {
  final String imageURL;
  const ImageContainer({super.key, required this.imageURL});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      height: 180,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        image: DecorationImage(
          image: NetworkImage(imageURL),
          fit: BoxFit.fill,
          alignment: Alignment.center,
        ),
      ),
      margin: EdgeInsets.all(20),
    );
  }
}
