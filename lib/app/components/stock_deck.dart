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
  List<CardModel> get deckClosed => widget.deck;
  List<CardModel> deckOpened = [];

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        deckOpened.isNotEmpty
            ? Draggable<List<CardModel>>(
                data: [deckOpened.last],
                childWhenDragging: deckOpened.length > 1
                    ? CardWidget(model: deckOpened[deckOpened.length - 2])
                    : const SizedBox.shrink(),
                feedback: CardWidget(model: deckOpened.last),
                child: CardWidget(model: deckOpened.last),
                onDragCompleted: () {
                  setState(() => deckOpened.removeLast());
                },
              )
            : const SizedBox.shrink(),
        const SizedBox(width: 4),
        GestureDetector(
          child: deckClosed.isEmpty
              ? const CardEmptyWidget.restart()
              : const CardEmptyWidget.back(),
          onTap: () {
            setState(() {
              if (deckClosed.isEmpty) {
                deckClosed.addAll(deckOpened);
                deckOpened.clear();
              } else {
                deckOpened.add(deckClosed.removeAt(0));
                deckOpened.last.isFaceUp = true;
              }
            });
          },
        ),
      ],
    );
  }
}
