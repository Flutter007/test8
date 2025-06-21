import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test8/providers/discount_card_provider.dart';
import 'package:test8/widgets/single_card_info.dart';
import '../widgets/center_event_container.dart';
import '../widgets/center_indicator.dart';

class SingleCardScreen extends ConsumerStatefulWidget {
  final String cardId;
  const SingleCardScreen({super.key, required this.cardId});

  @override
  ConsumerState createState() => _SingleCardScreenState();
}

class _SingleCardScreenState extends ConsumerState<SingleCardScreen> {
  @override
  Widget build(BuildContext context) {
    final cardState = ref.watch(singleCardProvider(widget.cardId));
    Widget body = switch (cardState) {
      AsyncData(value: final card) =>
        card == null ? Text('Is loading...') : SingleCardInfo(card: card),
      AsyncError() => CenterEventContainer(
        title: 'Something went wrong',
        iconData: Icons.error,
        buttonText: 'Try again',
        onButtonPressed:
            () => ref.invalidate(singleCardProvider(widget.cardId)),
      ),
      _ => CenterIndicator(),
    };
    return Scaffold(
      appBar: AppBar(
        title: Text(
          cardState.value == null
              ? 'Is loading...'
              : cardState.value!.shopTitle,
        ),
      ),
      body: body,
    );
  }
}
