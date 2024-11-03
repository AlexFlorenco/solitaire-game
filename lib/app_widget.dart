import 'package:flutter/material.dart';
import 'package:solitaire/app/controller/timer_controller.dart';
import 'package:solitaire/app/pages/splash_page.dart';
import 'package:solitaire/app/service/ads_service.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');
BuildContext get globalContext => rootNavigatorKey.currentState!.context;

class AppWidget extends StatefulWidget {
  const AppWidget({super.key});

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.resumed:
        TimerController.instance.startTimer();
        if (AdsService.pausedByAd) {
          AdsService.pausedByAd = false;
          return;
        }
        AdsService.loadAndShowBackgroundAd(globalContext, callback: () {});
        break;
      case AppLifecycleState.paused:
        TimerController.instance.pauseTimer();
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Solitaire',
      home: const SplashPage(),
      navigatorKey: rootNavigatorKey,
    );
  }
}
