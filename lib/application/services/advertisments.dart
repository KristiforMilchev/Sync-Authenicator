// ignore_for_file: avoid_print

import 'dart:io';

import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:synctest/infrastructure/iadvertisment.dart';

class Advertisments implements IAdvertisment {
  late InterstitialAd _interstitialAd;
  @override
  InterstitialAd get interstitialAd => _interstitialAd;

  Future<InitializationStatus> initialization;

  Advertisments(this.initialization);

  String get banerAdUnitId => Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/1033173712'
      : 'ca-app-pub-3940256099942544/4411468910';

  @override
  void loadAd() {
    InterstitialAd.load(
        adUnitId: '<ad unit id>',
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            // Keep a reference to the ad so you can show it later.
            // ignore: unnecessary_this
            this._interstitialAd = ad;
          },
          onAdFailedToLoad: (LoadAdError error) {
            print('InterstitialAd failed to load: $error');
          },
        ));

    _interstitialAd.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (InterstitialAd ad) =>
          print('%ad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        print('$ad onAdDismissedFullScreenContent.');
        ad.dispose();
      },
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
        print('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
      },
      onAdImpression: (InterstitialAd ad) => print('$ad impression occurred.'),
    );
  }
}
