import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:test8/models/discount_card.dart';
import 'package:test8/widgets/add_card_form/add_card_form_controllers.dart';

final supaBase = Supabase.instance.client;
final discountCardsListProvider = FutureProvider<List<DiscountCard>>((
  ref,
) async {
  final response = await supaBase.from('discount_cards').select();
  List<DiscountCard> newCards = [];
  for (var row in response) {
    final card = DiscountCard.fromJson(row);
    newCards.add(card);
  }
  return newCards;
});

class CreateDiscountCardProvider extends AsyncNotifier<void> {
  @override
  build() {}
  Future<void> createCard(
    AddCardFormControllers controller,
    String? logoFileName,
    String frontFileName,
    String? backFileName,
  ) async {
    state = AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final shopTitle = controller.shopTitleController.text.trim();
      final notes = controller.notesController.text.trim();
      final card = DiscountCard(
        shopTitle: shopTitle,
        shopLogoURL: logoFileName,
        cardFrontSideImageURL: frontFileName,
        cardBackSideImageURL: backFileName,
        notes: notes,
      );
      await supaBase.from('discount_cards').insert(card.toJson());
    });
  }
}

final createDiscountCardProvider =
    AsyncNotifierProvider<CreateDiscountCardProvider, void>(
      CreateDiscountCardProvider.new,
    );
