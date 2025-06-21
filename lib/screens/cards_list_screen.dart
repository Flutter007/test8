import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test8/providers/discount_card_provider.dart';
import 'package:test8/screens/add_card_screen.dart';
import 'package:test8/screens/single_card_screen.dart';
import 'package:test8/widgets/center_event_container.dart';
import 'package:test8/widgets/center_indicator.dart';
import 'package:test8/widgets/discount_card_view.dart';
import '../widgets/badge_counter.dart';

class CardsListScreen extends ConsumerStatefulWidget {
  const CardsListScreen({super.key});

  @override
  ConsumerState createState() => _CardsListScreenState();
}

class _CardsListScreenState extends ConsumerState<CardsListScreen> {
  void goToAddScreen() async {
    await Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (ctx) => AddCardScreen()));
    ref.invalidate(discountCardsListProvider);
  }

  void goToSingleCardScreen(String cardId) async {
    await Navigator.of(context).push(
      MaterialPageRoute(builder: (ctx) => SingleCardScreen(cardId: cardId)),
    );
    ref.invalidate(discountCardsListProvider);
  }

  @override
  Widget build(BuildContext context) {
    final cardsState = ref.watch(discountCardsListProvider);
    Widget body = switch (cardsState) {
      AsyncData(value: final cards) =>
        cards.isEmpty
            ? CenterEventContainer(
              title: 'No cards yet!',
              iconData: Icons.hourglass_empty_rounded,
              buttonText: 'Add card',
              onButtonPressed: goToAddScreen,
            )
            : ListView.builder(
              itemBuilder:
                  (ctx, i) => DiscountCardTile(
                    card: cards[i],
                    onTap: () => goToSingleCardScreen(cards[i].id!),
                  ),
              itemCount: cards.length,
            ),
      AsyncError() => CenterEventContainer(
        title: 'Something went wrong!',
        iconData: Icons.error,
        buttonText: 'Try again',
        onButtonPressed: () => ref.invalidate(discountCardsListProvider),
      ),
      _ => CenterIndicator(),
    };

    return Scaffold(
      appBar: AppBar(
        title: Text('Cards wallet!'),
        actions: [
          BadgeCounter(value: cardsState.value),
          IconButton(
            onPressed: goToAddScreen,
            icon: Icon(Icons.add_card, size: 30),
          ),
        ],
      ),
      body: body,
    );
  }
}
