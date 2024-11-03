import 'package:flutter/material.dart';
import 'package:solitaire/app/controller/game_controller.dart';

class GameAppBar extends StatefulWidget implements PreferredSizeWidget {
  const GameAppBar({super.key});

  @override
  State<GameAppBar> createState() => _GameAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _GameAppBarState extends State<GameAppBar> {
  GameController controller = GameController.instance;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios),
        onPressed: () {
          controller.resetGame();
          Navigator.of(context).pop();
        },
      ),
      foregroundColor: Colors.white,
      backgroundColor: Colors.green,
      title: ValueListenableBuilder(
        valueListenable: controller.timer.time,
        builder: (context, int time, child) {
          final int minutes = time ~/ 60;
          final int seconds = time % 60;
          return Text(
            '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}',
            style: const TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          );
        },
      ),
    );
  }
}