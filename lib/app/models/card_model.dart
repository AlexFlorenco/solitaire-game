import 'package:solitaire/app/enums/card_suit.dart';
import 'package:solitaire/app/enums/card_value.dart';

class CardModel {
  final CardSuit suit;
  final CardValue value;
  bool isFaceUp;

  CardModel({
    required this.suit,
    required this.value,
    this.isFaceUp = false,
  });

  static List<CardModel> getFullDeck() {
    return [
      for (var suit in CardSuit.values)
        for (var value in CardValue.values) 
          CardModel(suit: suit, value: value)
    ];
  }
}