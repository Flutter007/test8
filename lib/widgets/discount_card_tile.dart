import 'package:flutter/material.dart';
import 'package:test8/models/discount_card.dart';
import 'package:test8/widgets/image_container.dart';
import 'custom_text.dart';

class DiscountCardTile extends StatelessWidget {
  final DiscountCard card;
  final void Function() onTap;

  const DiscountCardTile({super.key, required this.card, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: InkWell(
        onTap: onTap,
        child: Card(
          elevation: 9,
          child: Column(
            children: [
              ListTile(
                title: Text('Shop name :'),
                subtitle: CustomText(txt: card.shopTitle),
              ),
              card.shopLogoURL != null
                  ? ImageContainer(
                    imageURL: card.shopLogoURL!,
                    imageDescription: 'logo',
                  )
                  : Image.asset(
                    width: 160,
                    height: 120,
                    'assets/images/shop.jpg',
                    fit: BoxFit.fill,
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
