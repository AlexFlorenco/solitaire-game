import 'package:flutter/material.dart';
import 'package:solitaire/app/components/card_empty_widget.dart';
import 'package:solitaire/app/components/card_widget.dart';
import 'package:solitaire/app/controller/game_controller.dart';
import 'package:solitaire/app/models/card_model.dart';

class TableauDeck extends StatefulWidget {
  final List<CardModel> deck;

  const TableauDeck(this.deck, {super.key});

  @override
  State<TableauDeck> createState() => _TableauDeckState();
}

class _TableauDeckState extends State<TableauDeck> {
  late GameController controller;
  List<CardModel> get deck => widget.deck;
  List<CardModel> draggedCards = [];

  @override
  void initState() {
    super.initState();
    controller = GameController.instance;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50,
      height: 550,
      child: Stack(
        children: deck.isEmpty
            ? [
                DragTarget<List<CardModel>>(
                  builder: (context, candidateData, rejectedData) {
                    return const CardEmptyWidget();
                  },
                  onWillAcceptWithDetails: (receivedDeck) {
                    return controller.canAcceptCard(receivedDeck.data.first, deck);
                  },
                  onAcceptWithDetails: (receivedDeck) {
                    controller.receiveCards(deck, receivedDeck.data);
                  },
                ),
              ]
            : deck.asMap().entries.map((entry) {
                int index = entry.key;
                CardModel card = entry.value;

                List<CardModel> cardsToMove = deck.sublist(index);

                return Positioned(
                  top: index * 24.0,
                  child: IgnorePointer(
                    ignoring: cardsToMove.any((card) => !card.isFaceUp),
                    child: Draggable<List<CardModel>>(
                      data: cardsToMove,
                      childWhenDragging: widget.deck.length == cardsToMove.length
                          ? const CardEmptyWidget()
                          : const SizedBox.shrink(),
                      feedback: SizedBox(
                        height: 550,
                        width: 50,
                        child: Stack(
                          children: cardsToMove.asMap().entries.map((entry) {
                            int feedbackIndex = entry.key;
                            CardModel feedbackCard = entry.value;
                            return Positioned(
                              top: feedbackIndex * 24.0,
                              child: CardWidget(model: feedbackCard),
                            );
                          }).toList(),
                        ),
                      ),
                      child: DragTarget<List<CardModel>>(
                        builder: (context, candidateData, rejectedData) {
                          return draggedCards.contains(card)
                              ? const SizedBox.shrink()
                              : CardWidget(model: card);
                        },
                        onWillAcceptWithDetails: (details) {
                          return controller.canAcceptCard(details.data.first, deck);
                        },
                        onAcceptWithDetails: (receivedDeck) {
                          controller.receiveCards(deck, receivedDeck.data);
                        },
                      ),
                      onDragStarted: () {                 
                        setState(() => draggedCards = cardsToMove);
                      },
                      onDragCompleted: () {
                        controller.removeCards(deck, draggedCards);
                      },
                      onDraggableCanceled: (_, __) {
                        setState(() => draggedCards.clear());
                      },
                    ),
                  ),
                );
              }).toList(),
      ),
    );
  }
}
