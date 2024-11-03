import 'package:solitaire/app/models/card_model.dart';

class GameState {
  final List<CardModel> fullDeck;
  final List<CardModel> stockDeck;
  final List<CardModel> foundationDeck1;
  final List<CardModel> foundationDeck2;
  final List<CardModel> foundationDeck3;
  final List<CardModel> foundationDeck4;
  final List<CardModel> tableauDeck1;
  final List<CardModel> tableauDeck2;
  final List<CardModel> tableauDeck3;
  final List<CardModel> tableauDeck4;
  final List<CardModel> tableauDeck5;
  final List<CardModel> tableauDeck6;
  final List<CardModel> tableauDeck7;
  final int elapsedTime;

  GameState({
    required this.fullDeck,
    required this.stockDeck,
    required this.foundationDeck1,
    required this.foundationDeck2,
    required this.foundationDeck3,
    required this.foundationDeck4,
    required this.tableauDeck1,
    required this.tableauDeck2,
    required this.tableauDeck3,
    required this.tableauDeck4,
    required this.tableauDeck5,
    required this.tableauDeck6,
    required this.tableauDeck7,
    required this.elapsedTime,
  });

  Map<String, dynamic> toJson() {
    return {
      'fullDeck': fullDeck.map((card) => card.toJson()).toList(),
      'stockDeck': stockDeck.map((card) => card.toJson()).toList(),
      'foundationDeck1': foundationDeck1.map((card) => card.toJson()).toList(),
      'foundationDeck2': foundationDeck2.map((card) => card.toJson()).toList(),
      'foundationDeck3': foundationDeck3.map((card) => card.toJson()).toList(),
      'foundationDeck4': foundationDeck4.map((card) => card.toJson()).toList(),
      'tableauDeck1': tableauDeck1.map((card) => card.toJson()).toList(),
      'tableauDeck2': tableauDeck2.map((card) => card.toJson()).toList(),
      'tableauDeck3': tableauDeck3.map((card) => card.toJson()).toList(),
      'tableauDeck4': tableauDeck4.map((card) => card.toJson()).toList(),
      'tableauDeck5': tableauDeck5.map((card) => card.toJson()).toList(),
      'tableauDeck6': tableauDeck6.map((card) => card.toJson()).toList(),
      'tableauDeck7': tableauDeck7.map((card) => card.toJson()).toList(),
      'elapsedTime': elapsedTime,
    };
  }

  factory GameState.fromJson(Map<String, dynamic> json) {
    return GameState(
      fullDeck: (json['fullDeck'] as List).map((card) => CardModel.fromJson(card)).toList(),
      stockDeck: (json['stockDeck'] as List).map((card) => CardModel.fromJson(card)).toList(),
      foundationDeck1: (json['foundationDeck1'] as List).map((card) => CardModel.fromJson(card)).toList(),
      foundationDeck2: (json['foundationDeck2'] as List).map((card) => CardModel.fromJson(card)).toList(),
      foundationDeck3: (json['foundationDeck3'] as List).map((card) => CardModel.fromJson(card)).toList(),
      foundationDeck4: (json['foundationDeck4'] as List).map((card) => CardModel.fromJson(card)).toList(),
      tableauDeck1: (json['tableauDeck1'] as List).map((card) => CardModel.fromJson(card)).toList(),
      tableauDeck2: (json['tableauDeck2'] as List).map((card) => CardModel.fromJson(card)).toList(),
      tableauDeck3: (json['tableauDeck3'] as List).map((card) => CardModel.fromJson(card)).toList(),
      tableauDeck4: (json['tableauDeck4'] as List).map((card) => CardModel.fromJson(card)).toList(),
      tableauDeck5: (json['tableauDeck5'] as List).map((card) => CardModel.fromJson(card)).toList(),
      tableauDeck6: (json['tableauDeck6'] as List).map((card) => CardModel.fromJson(card)).toList(),
      tableauDeck7: (json['tableauDeck7'] as List).map((card) => CardModel.fromJson(card)).toList(),
      elapsedTime: json['elapsedTime'],
    );
  }
}