import 'package:flutter/material.dart';
import 'package:solitaire/app/components/foundation_deck.dart';
import 'package:solitaire/app/components/tableau_deck.dart';
import 'package:solitaire/app/components/stock_deck.dart';
import 'package:solitaire/app/controller/game_controller.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  late GameController controller;

  @override
  void initState() {
    super.initState();
    controller = GameController.instance;
    controller.startGame();
    controller.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 16),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OverflowBar(
                    spacing: 3,
                    children: [
                      FoundationDeck(controller.foundationDeck1),
                      FoundationDeck(controller.foundationDeck2),
                      FoundationDeck(controller.foundationDeck3),
                      FoundationDeck(controller.foundationDeck4),
                    ],
                  ),
                  StockDeck(controller.stockDeck),
                ],
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TableauDeck(controller.tableauDeck7),
                  TableauDeck(controller.tableauDeck6),
                  TableauDeck(controller.tableauDeck5),
                  TableauDeck(controller.tableauDeck4),
                  TableauDeck(controller.tableauDeck3),
                  TableauDeck(controller.tableauDeck2),
                  TableauDeck(controller.tableauDeck1),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
