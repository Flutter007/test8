import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final TextStyle? style;
  final String txt;
  const CustomText({super.key, required this.txt, required this.style});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Text(
        txt,
        style: style,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
