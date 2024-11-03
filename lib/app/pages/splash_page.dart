import 'package:ads/ads.dart';
import 'package:flutter/material.dart';
import 'package:solitaire/app/pages/home_page.dart';
import 'package:solitaire/app/service/ads_service.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final AppOpenAdManager appOpenAdManager = AppOpenAdManager.instance;

  @override
  void initState() {
    super.initState();
    AdsService.setup();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      AdsService.loadAndShowAppOpenAd(callback: () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      });
      AdsService.advanceLoadInterstitialAd();
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.green,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.style,
              color: Colors.white,
              size: 64,
            ),
            SizedBox(height: 16),
            Text(
              'Solitaire',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
