import 'dart:async';
import 'package:flutter/material.dart';

class TimerController {
  TimerController._();
  static final TimerController instance = TimerController._();

  ValueNotifier<int> time = ValueNotifier<int>(0);
  Timer? timer;
  int _elapsedTime = 0;

  void startTimer() {
    timer?.cancel();
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _elapsedTime += 1;
      time.value = _elapsedTime;
    });
  }

  void pauseTimer() {
    timer?.cancel();
  }

  void stopTimer() {
    timer?.cancel();
    _elapsedTime = 0;
    time.value = 0;
  }

  void resetTimer() {
    stopTimer();
    startTimer();
  }
}