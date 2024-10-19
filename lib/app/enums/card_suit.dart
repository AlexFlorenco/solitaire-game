import 'package:flutter/material.dart';

enum CardSuit {
  clubs,
  spades,
  hearts,
  diamonds;

  String get char => switch (this) {
    CardSuit.spades => '♠',
    CardSuit.hearts => '♥',
    CardSuit.diamonds => '♦',
    CardSuit.clubs => '♣'
  };

  Color get color => switch (this) {
    CardSuit.spades || CardSuit.clubs => Colors.black,
    CardSuit.hearts || CardSuit.diamonds => Colors.red
  };
}
