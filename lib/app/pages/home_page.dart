import 'package:flutter/material.dart';
import 'package:solitaire/app/controller/game_controller.dart';
import 'package:solitaire/app/pages/game_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Spacer(),
            const Text(
              'SOLITAIRE',
              style: TextStyle(
                color: Colors.green,
                fontSize: 48,
                fontFamily: 'Times New Roman',
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 48),
            FilledButton(
              onPressed: () {
                GameController.instance.loadGame();
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const GamePage()),
                );
              },
              style: ButtonStyle(
                elevation: WidgetStateProperty.all(1),
                foregroundColor: WidgetStateProperty.all(Colors.white),
                backgroundColor: WidgetStateProperty.all(Colors.green),
                minimumSize: WidgetStateProperty.all(const Size.fromHeight(48)),
                side: WidgetStateProperty.all(const BorderSide(color: Colors.grey, width: 0.1)),
              ),
              child: const Text(
                'Continuar jogo',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 20),
            FilledButton(
              onPressed: () {
                GameController.instance.startGame();
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const GamePage()),
                );
              },
              style: ButtonStyle(
                elevation: WidgetStateProperty.all(1),
                backgroundColor: WidgetStateProperty.all(Colors.white),
                foregroundColor: WidgetStateProperty.all(Colors.green),
                minimumSize: WidgetStateProperty.all(const Size.fromHeight(48)),
                side: WidgetStateProperty.all(const BorderSide(color: Colors.grey, width: 0.1)),
              ),
              child: const Text(
                'Novo jogo',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
