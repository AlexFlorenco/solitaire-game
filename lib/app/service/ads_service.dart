import 'package:ads/ads.dart';
import 'package:flutter/material.dart';

class AdsService {
  static bool pausedByAd = false;

  static void setup() {
    AdSetup.setupAdUnits(
      appOpenAdUnit: 'ca-app-pub-3940256099942544/9257395921',
      bannerAdUnit: 'ca-app-pub-3940256099942544/9214589741',
      rewardedAdUnit: 'ca-app-pub-3940256099942544/5224354917',
      interstitialGlobalAdUnit: 'ca-app-pub-3940256099942544/1033173712',
      interstitialAppOpenAdUnit: 'ca-app-pub-3940256099942544/1033173712',
      interstitialBackgroundAdUnit: 'ca-app-pub-3940256099942544/1033173712',
      interstitialNotificationAdUnit: 'ca-app-pub-3940256099942544/1033173712',
    );
  }

  static void loadAndShowAppOpenAd({required VoidCallback callback}) {
    AppOpenAdManager.instance.loadAndShowAd(
      callback: () => callback(),
    );
  }

  static void advanceLoadInterstitialAd() {
    InterstitialAdManager.instance.loadAd();
  }

  static void showInterstitialAd({required VoidCallback callback}) {
    InterstitialAdManager.instance.showAndLoadNextAd(
      callback: () => callback(),
    );
    pausedByAd = true;
  }

  static void advanceLoadRewardedAd(BuildContext context) {
    RewardedAdManager.instance.loadAd(context, advanceLoad: true);
  }

  static void showRewardedAd(BuildContext context,
      {required VoidCallback callback}) {
    RewardedAdManager.instance.loadAndShowAd(
      context,
      callback: () => callback(),
    );
    pausedByAd = true;
  }

  static void loadAndShowBackgroundAd(
    BuildContext context, {
    required VoidCallback callback,
  }) {
    ReengagementInterstitialAdManager.instance.loadAndShowAd(
      context,
      type: ReengagementInterstitialTypes.background,
      callback: () => callback(),
    );
    pausedByAd = true;
  }
}
