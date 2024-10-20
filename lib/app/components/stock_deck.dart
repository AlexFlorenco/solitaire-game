import 'package:flutter/material.dart';
import 'package:solitaire/app/components/card_empty_widget.dart';
import 'package:solitaire/app/components/card_widget.dart';
import 'package:solitaire/app/models/card_model.dart';

class StockDeck extends StatefulWidget {
  final List<CardModel> deck;

  const StockDeck(this.deck, {super.key});

  @override
  State<StockDeck> createState() => _StockDeckState();
}

class _StockDeckState extends State<StockDeck> {
  late List<CardModel> deck;

  @override
  void initState() {
    super.initState();
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
            onTap: () => setState(() {
              for (var card in deck) {
                card.isFaceUp = false;
              }
              deck = deck.reversed.toList();
            }),
            child: const CardEmptyWidget.restart(),
          ),
          ...deck.map((card) {
            return AnimatedPositioned(
              key: ValueKey(card),
              left: card.isFaceUp ? 0 : 53,
              duration: const Duration(milliseconds: 400),
              child: GestureDetector(
                child: Draggable<List<CardModel>>(
                  data: [card],
                  childWhenDragging: card == deck.last
                      ? const SizedBox.shrink()
                      : CardWidget(model: deck[deck.length - 2]),
                  feedback: CardWidget(model: card),
                  child: CardWidget(model: card),
                  onDragCompleted: () => setState(() {
                    deck.removeLast();
                  }),
                ),
                onTap: () => setState(() {
                  card.isFaceUp = true;
                  deck.remove(card);
                  deck.add(card);
                }),
              ),
            );
          }),
        ],
      ),
    );
  }
}
