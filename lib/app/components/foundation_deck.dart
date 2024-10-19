import 'package:flutter/material.dart';
import 'package:solitaire/app/components/card_empty_widget.dart';
import 'package:solitaire/app/components/card_widget.dart';
import 'package:solitaire/app/models/card_model.dart';

class FoundationDeck extends StatefulWidget {
  final List<CardModel> deck;

  const FoundationDeck(this.deck, {super.key});

  @override
  State<FoundationDeck> createState() => _FoundationDeckState();
}

class _FoundationDeckState extends State<FoundationDeck> {
  @override
  Widget build(BuildContext context) {
    return Draggable(
      data: widget.deck.isNotEmpty ? [widget.deck.last] : [],
      feedback: widget.deck.isNotEmpty
          ? CardWidget(model: widget.deck.last)
          : const SizedBox.shrink(),
      childWhenDragging: widget.deck.length > 1
          ? CardWidget(model: widget.deck[widget.deck.length - 2])
          : const CardEmptyWidget.ace(),
      child: DragTarget<List<CardModel>>(
        builder: (context, candidateData, rejectedData) {
          return widget.deck.isNotEmpty
              ? CardWidget(model: widget.deck.last)
              : const CardEmptyWidget.ace();
        },
        onWillAcceptWithDetails: (details) {
          CardModel card = details.data.first;

          if (details.data.length == 1) {
            if (widget.deck.isEmpty) {
              return card.value.value == 1;
            }

            return card.suit == widget.deck.last.suit &&
                card.value.value == widget.deck.last.value.value + 1;
          }
          return false;
        },
        onAcceptWithDetails: (data) {
          setState(() => widget.deck.add(data.data.first));
        },
      ),
      onDragCompleted: () {
        setState(() => widget.deck.removeLast());
      },
    );
  }
}
