import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CardsListScreen extends ConsumerStatefulWidget {
  const CardsListScreen({super.key});

  @override
  ConsumerState createState() => _CardsListScreenState();
}

class _CardsListScreenState extends ConsumerState<CardsListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text('Discount Cards here!')));
  }
}
