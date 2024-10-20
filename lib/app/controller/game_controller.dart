import 'package:flutter/material.dart';
import 'package:solitaire/app/controller/sound_controller.dart';
import 'package:solitaire/app/enums/card_value.dart';
import 'package:solitaire/app/models/card_model.dart';

class GameController with ChangeNotifier {
  GameController._();
  static final GameController instance = GameController._();

  List<CardModel> fullDeck = [];

  List<CardModel> stockDeck = [];

  List<CardModel> foundationDeck1 = [];
  List<CardModel> foundationDeck2 = [];
  List<CardModel> foundationDeck3 = [];
  List<CardModel> foundationDeck4 = [];

  List<CardModel> tableauDeck1 = [];
  List<CardModel> tableauDeck2 = [];
  List<CardModel> tableauDeck3 = [];
  List<CardModel> tableauDeck4 = [];
  List<CardModel> tableauDeck5 = [];
  List<CardModel> tableauDeck6 = [];
  List<CardModel> tableauDeck7 = [];

  void startGame() {
    fullDeck = CardModel.getFullDeck()..shuffle();

    final List<List<CardModel>> tableauDecks = [
      tableauDeck1, tableauDeck2, tableauDeck3,
      tableauDeck4, tableauDeck5, tableauDeck6,
      tableauDeck7
    ];

    for (int i = 0; i < tableauDecks.length; i++) {
      tableauDecks[i].addAll(fullDeck.sublist(0, 7 - i));
      tableauDecks[i].last.isFaceUp = true;
      fullDeck.removeRange(0, 7 - i);
    }

    stockDeck = fullDeck;
  }

  void receiveCards(List<CardModel> targetDeck, List<CardModel> receivedCards) {
    SoundController.playSound('sounds/card_pick.wav');
    targetDeck.addAll(receivedCards.where((card) => !targetDeck.contains(card)));
    notifyListeners();
  }

  void removeCards(List<CardModel> sourceDeck, List<CardModel> draggedCards) {
    sourceDeck.removeWhere((card) => draggedCards.contains(card));
    if (sourceDeck.isNotEmpty) {
      sourceDeck.last.isFaceUp = true;
    }
    draggedCards.clear();
    notifyListeners();
  }

  bool canAcceptCardTableau(CardModel receivedCard, List<CardModel> targetDeck) {
    if (targetDeck.isEmpty && receivedCard.value == CardValue.king) {
      return true;
    }
    if (targetDeck.isNotEmpty) {
      CardModel lastCard = targetDeck.last;
      if (receivedCard.value.value == lastCard.value.value - 1 &&
          receivedCard.suit.color != lastCard.suit.color) {
        return true;
      }
    }
    return false;
  }

  bool canAcceptCardFoundation(List<CardModel> receivedCards, List<CardModel> targetDeck) {
    if (receivedCards.length == 1) {
      if (targetDeck.isEmpty && receivedCards.first.value == CardValue.ace) {
        return true;
      }
      if (targetDeck.isNotEmpty) {
        CardModel lastCard = targetDeck.last;
        if (receivedCards.first.value.value == lastCard.value.value + 1 &&
            receivedCards.first.suit == lastCard.suit) {
          return true;
        }
      }
    }
    return false;
  }
}
