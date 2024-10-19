import 'package:flutter/material.dart';
import 'package:solitaire/app/pages/game_page.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Solitaire',
      home: GamePage(),
    );
  }
}
