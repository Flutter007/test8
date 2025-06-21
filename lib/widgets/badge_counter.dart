import 'package:flutter/material.dart';
import 'package:test8/models/discount_card.dart';

class BadgeCounter extends StatelessWidget {
  final List<DiscountCard>? value;
  const BadgeCounter({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Badge(
      child: Text(
        value == null ? 'Loading...' : value!.length.toString(),
        style: TextStyle(
          color: theme.colorScheme.surface,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
    );
  }
}
