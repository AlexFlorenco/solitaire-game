import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:solitaire/app/controller/sound_controller.dart';
import 'package:solitaire/app/enums/card_value.dart';
import 'package:solitaire/app/models/card_model.dart';
import 'package:solitaire/app/models/game_state.dart';
import 'package:solitaire/app/service/local_storage_service.dart';

class GameController with ChangeNotifier {
  GameController._();
  static final GameController instance = GameController._();
  ValueNotifier<bool> isGameWon = ValueNotifier<bool>(false);

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
    isGameWon.value = false;
    notifyListeners();
  }

  void resetGame() {
    fullDeck.clear();
    stockDeck.clear();
    foundationDeck1.clear();
    foundationDeck2.clear();
    foundationDeck3.clear();
    foundationDeck4.clear();
    tableauDeck1.clear();
    tableauDeck2.clear();
    tableauDeck3.clear();
    tableauDeck4.clear();
    tableauDeck5.clear();
    tableauDeck6.clear();
    tableauDeck7.clear();
  }

  void saveGame() {
    GameState gameState = GameState(
      fullDeck: fullDeck,
      stockDeck: stockDeck,
      foundationDeck1: foundationDeck1,
      foundationDeck2: foundationDeck2,
      foundationDeck3: foundationDeck3,
      foundationDeck4: foundationDeck4,
      tableauDeck1: tableauDeck1,
      tableauDeck2: tableauDeck2,
      tableauDeck3: tableauDeck3,
      tableauDeck4: tableauDeck4,
      tableauDeck5: tableauDeck5,
      tableauDeck6: tableauDeck6,
      tableauDeck7: tableauDeck7,
    );

    LocalStorageService().saveData('game_state', json.encode(gameState.toJson()));
  }

  void loadGame() async {
    var gameState = json.decode(await LocalStorageService().getData('game_state'));

    if (gameState == null) return;
    
    GameState loadedGame = GameState.fromJson(gameState);
    fullDeck = loadedGame.fullDeck;
    stockDeck = loadedGame.stockDeck;
    foundationDeck1 = loadedGame.foundationDeck1;
    foundationDeck2 = loadedGame.foundationDeck2;
    foundationDeck3 = loadedGame.foundationDeck3;
    foundationDeck4 = loadedGame.foundationDeck4;
    tableauDeck1 = loadedGame.tableauDeck1;
    tableauDeck2 = loadedGame.tableauDeck2;
    tableauDeck3 = loadedGame.tableauDeck3;
    tableauDeck4 = loadedGame.tableauDeck4;
    tableauDeck5 = loadedGame.tableauDeck5;
    tableauDeck6 = loadedGame.tableauDeck6;
    tableauDeck7 = loadedGame.tableauDeck7;
    checkWin();
    notifyListeners();
  }

  void receiveCards(List<CardModel> targetDeck, List<CardModel> receivedCards) {
    SoundController.playSound('sounds/card_pick.wav');
    targetDeck.addAll(receivedCards.where((card) => !targetDeck.contains(card)));
    saveGame();
    checkWin();
    notifyListeners();
  }

  void removeCards(List<CardModel> sourceDeck, List<CardModel> draggedCards) {
    sourceDeck.removeWhere((card) => draggedCards.contains(card));
    if (sourceDeck.isNotEmpty) {
      sourceDeck.last.isFaceUp = true;
    }
    draggedCards.clear();
    saveGame();
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

  void automaticMove(List<CardModel> draggedCards, List<CardModel> sourceDeck) {
    if (automaticMoveToFoundation(draggedCards, sourceDeck)) return;
    if (automaticMoveToTableau(draggedCards, sourceDeck)) return;
  }

  bool automaticMoveToFoundation(List<CardModel> draggedCards, List<CardModel> sourceDeck) {
    for (List<CardModel> foundationDeck in [
      foundationDeck1, foundationDeck2,
      foundationDeck3, foundationDeck4
    ]) {
      if (foundationDeck.isEmpty && draggedCards.first.value == CardValue.ace) {
        receiveCards(foundationDeck, draggedCards);
        removeCards(sourceDeck, draggedCards);
        return true;
      }
      if (foundationDeck.isNotEmpty &&
          draggedCards.length == 1 &&
          foundationDeck.last.value.value == draggedCards.first.value.value - 1 &&
          foundationDeck.last.suit == draggedCards.first.suit) {
        receiveCards(foundationDeck, draggedCards);
        removeCards(sourceDeck, draggedCards);
        return true;
      }
    }
    return false;
  }

  bool automaticMoveToTableau(List<CardModel> draggedCards, List<CardModel> sourceDeck) {
    for (List<CardModel> tableauDeck in [
      tableauDeck1, tableauDeck2, tableauDeck3,
      tableauDeck4, tableauDeck5, tableauDeck6,
      tableauDeck7
    ]) {
      if (tableauDeck.isEmpty && draggedCards.first.value == CardValue.king) {
        receiveCards(tableauDeck, draggedCards);
        removeCards(sourceDeck, draggedCards);
        return true;
      }
      if (tableauDeck.isNotEmpty &&
          tableauDeck.last.value.value == draggedCards.first.value.value + 1 &&
          tableauDeck.last.suit.color != draggedCards.first.suit.color) {
        receiveCards(tableauDeck, draggedCards);
        removeCards(sourceDeck, draggedCards);
        return true;
      }
    }
    return false;
  }

  void checkWin() {
    if (foundationDeck1.length == 13 &&
        foundationDeck2.length == 13 &&
        foundationDeck3.length == 13 &&
        foundationDeck4.length == 13) {
      isGameWon.value = true;
    }
  }
}
