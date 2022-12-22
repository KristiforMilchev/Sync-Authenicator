import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

abstract class IAdvertisment {
  late InterstitialAd _interstitialAd;
  InterstitialAd get interstitialAd => _interstitialAd;

  void loadAd();
}
