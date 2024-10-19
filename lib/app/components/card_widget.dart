import 'package:flutter/material.dart';
import 'package:solitaire/app/components/card_empty_widget.dart';
import 'package:solitaire/app/models/card_model.dart';

class CardWidget extends StatelessWidget {
  final CardModel model;
  const CardWidget({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: model.isFaceUp
          ? Container(
              padding: const EdgeInsets.all(4),
              width: 50,
              height: 78,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.black, width: 0.3),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        model.value.label,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: model.suit.color,
                          decoration: TextDecoration.none,
                        ),
                      ),
                      Text(
                        model.suit.char,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: model.suit.color,
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    model.suit.char,
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: model.suit.color,
                      decoration: TextDecoration.none,
                    ),
                  ),
                ],
              ),
            )
          : const CardEmptyWidget.back(),
    );
  }
}
