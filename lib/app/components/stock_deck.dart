import 'dart:math';

import 'package:flutter/material.dart';
import 'package:solitaire/app/components/card_empty_widget.dart';
import 'package:solitaire/app/components/card_widget.dart';
import 'package:solitaire/app/controller/game_controller.dart';
import 'package:solitaire/app/controller/sound_controller.dart';
import 'package:solitaire/app/models/card_model.dart';
import 'package:solitaire/app/service/ads_service.dart';

class StockDeck extends StatefulWidget {
  final List<CardModel> deck;

  const StockDeck(this.deck, {super.key});

  @override
  State<StockDeck> createState() => _StockDeckState();
}

class _StockDeckState extends State<StockDeck> {
  late List<CardModel> deck;
  late GameController controller;

  @override
  void initState() {
    super.initState();
    controller = GameController.instance;
    deck = widget.deck;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 103,
      height: 78,
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          GestureDetector(
            onTap: () {
              AdsService.showInterstitialAd(callback: () {
                setState(() {
                  for (var card in deck) {
                    card.isFaceUp = false;
                  }
                  deck = deck.reversed.toList();
                });
              });
            },
            child: const CardEmptyWidget.restart(),
          ),
          ...deck.map((card) {
            return AnimatedPositioned(
              key: ValueKey(card),
              left: card.isFaceUp ? 0 : 53,
              duration: const Duration(milliseconds: 400),
              child: GestureDetector(
                onTap: () => setState(() {
                  if (card.isFaceUp) {
                    controller.automaticMove([card], deck);
                    return;
                  } else {
                    SoundController.playSound('sounds/card_pick.wav');
                    card.isFaceUp = true;
                    deck.remove(card);
                    deck.add(card);
                  }
                }),
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 400),
                  transitionBuilder: (Widget child, Animation<double> animation) {
                    final rotate = Tween(begin: 1.0, end: 0.0).animate(animation);

                    return AnimatedBuilder(
                      animation: rotate,
                      child: child,
                      builder: (context, child) {
                        return Transform(
                          transform: Matrix4.rotationY(min(rotate.value, 0.5) * pi),
                          alignment: Alignment.center,
                          child: child,
                        );
                      },
                    );
                  },
                  child: card.isFaceUp
                      ? Draggable<List<CardModel>>(
                          key: ValueKey(card.isFaceUp),
                          data: [card],
                          childWhenDragging: card == deck.last
                              ? const SizedBox.shrink()
                              : CardWidget(model: deck[deck.length - 2]),
                          feedback: CardWidget(model: card),
                          child: CardWidget(model: card),
                          onDragCompleted: () => setState(() {
                            deck.removeLast();
                          }),
                        )
                      : CardWidget(model: card),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
