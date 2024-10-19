import 'dart:math';

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
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        transitionBuilder: (Widget child, Animation<double> animation) {
          final rotate = Tween(begin: 1.0, end: 0.0).animate(animation);

          return AnimatedBuilder(
            animation: rotate,
            child: child,
            builder: (context, child) {
              return Transform(
                transform: Matrix4.rotationY(min(rotate.value, 0.5) * pi),
                alignment: Alignment.center,
                child: child,
              );
            },
          );
        },
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
      ),
    );
  }
}
