import 'package:flutter/material.dart';
import 'image_container.dart';

class CardContainer extends StatelessWidget {
  final double width;

  final String imageURL;
  const CardContainer({super.key, required this.width, required this.imageURL});

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: width, child: ImageContainer(imageURL: imageURL));
  }
}
