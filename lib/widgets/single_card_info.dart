import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test8/models/discount_card.dart';
import 'package:test8/providers/images_upload_providers.dart';
import 'card_container.dart';

class SingleCardInfo extends ConsumerWidget {
  final DiscountCard card;
  const SingleCardInfo({super.key, required this.card});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          LayoutBuilder(
            builder: (ctx, constraints) {
              final width = constraints.maxWidth;
              return Column(
                children: [
                  CardContainer(
                    width: width,
                    imageURL: ref
                        .watch(imageUploadProvider.notifier)
                        .getImageURL(
                          'cards_front_side',
                          card.cardFrontSideImageURL,
                        ),
                  ),
                  if (card.cardBackSideImageURL != null)
                    CardContainer(
                      width: width,
                      imageURL: ref
                          .watch(imageUploadProvider.notifier)
                          .getImageURL(
                            'cards_back_side',
                            card.cardBackSideImageURL!,
                          ),
                    ),
                  if (card.notes != null)
                    ListTile(
                      title: Text('Notes :'),
                      subtitle: Text(card.notes!),
                    ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
