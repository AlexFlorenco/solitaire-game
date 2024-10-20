import 'package:flutter/material.dart';
import 'package:solitaire/app/components/card_empty_widget.dart';
import 'package:solitaire/app/components/card_widget.dart';
import 'package:solitaire/app/controller/game_controller.dart';
import 'package:solitaire/app/models/card_model.dart';

class FoundationDeck extends StatefulWidget {
  final List<CardModel> deck;

  const FoundationDeck(this.deck, {super.key});

  @override
  State<FoundationDeck> createState() => _FoundationDeckState();
}

class _FoundationDeckState extends State<FoundationDeck> {
  late GameController controller;

  @override
  void initState() {
    super.initState();
    controller = GameController.instance;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        controller.automaticMoveToTableau([widget.deck.last], widget.deck);
      },
      child: Draggable(
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
            return controller.canAcceptCardFoundation(details.data, widget.deck);
          },
          onAcceptWithDetails: (data) {
            controller.receiveCards(widget.deck, data.data);
          },
        ),
        onDragCompleted: () {
          controller.removeCards(widget.deck, [widget.deck.last]);
        },
      ),
    );
  }
}
