import 'package:flutter/material.dart';
import 'package:test8/screens/cards_list_screen.dart';
import 'package:test8/theme/light_theme.dart';

class Test8 extends StatelessWidget {
  const Test8({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: lightTheme,
      themeMode: ThemeMode.system,
      home: CardsListScreen(),
    );
  }
}
