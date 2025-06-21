import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:test8/models/discount_card.dart';
import 'package:test8/providers/images_upload_providers.dart';
import 'package:test8/widgets/image_container.dart';
import 'custom_text.dart';

final formattedDateTime = DateFormat('dd.MM.yyyy');

class DiscountCardTile extends ConsumerWidget {
  final DiscountCard card;
  final void Function() onTap;

  const DiscountCardTile({super.key, required this.card, required this.onTap});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: InkWell(
        onTap: onTap,
        child: Card(
          elevation: 9,
          child: Column(
            children: [
              CustomText(
                txt: card.shopTitle,
                style: theme.textTheme.headlineLarge,
              ),
              card.shopLogoURL != null
                  ? ImageContainer(
                    imageURL: ref
                        .read(imageUploadProvider.notifier)
                        .getImageURL('cards_logo', card.shopLogoURL!),
                  )
                  : Image.asset(
                    width: 250,
                    height: 180,
                    'assets/images/shop.jpg',
                    fit: BoxFit.fill,
                  ),
              Align(
                alignment: Alignment.bottomRight,
                child: CustomText(
                  txt: formattedDateTime.format(card.createdAt!),
                  style: theme.textTheme.titleMedium,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
