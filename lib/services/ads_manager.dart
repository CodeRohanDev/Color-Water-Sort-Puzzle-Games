import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdsManager {
  static RewardedAd? _rewardedAd;
  static InterstitialAd? _interstitialAd;
  static BannerAd? _bannerAd;

  static void loadRewardedAd(Function onAdLoaded) {
    RewardedAd.load(
      adUnitId: 'ca-app-pub-7598941016544840/7802515818',
      request: AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (RewardedAd ad) {
          _rewardedAd = ad;
          onAdLoaded();
        },
        onAdFailedToLoad: (LoadAdError error) {
          print('RewardedAd failed to load: $error');
          _rewardedAd = null;
        },
      ),
    );
  }

  static void showRewardedAd(Function onAdWatched) {
    if (_rewardedAd != null) {
      _rewardedAd!.show(
        onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {
          onAdWatched();
        },
      );
      _rewardedAd = null;
      loadRewardedAd(() {});
    }
  }

  static void loadInterstitialAd() {
    InterstitialAd.load(
      adUnitId: 'ca-app-pub-7598941016544840/9799959939',
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          _interstitialAd = ad;
        },
        onAdFailedToLoad: (LoadAdError error) {
          print('InterstitialAd failed to load: $error');
          _interstitialAd = null;
        },
      ),
    );
  }

  static void showInterstitialAd() {
    if (_interstitialAd != null) {
      _interstitialAd!.show();
      _interstitialAd = null;
      loadInterstitialAd();
    }
  }

  static void loadBannerAd() {
    _bannerAd = BannerAd(
      adUnitId: 'ca-app-pub-7598941016544840/6547110635',
      size: AdSize.banner,
      request: AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) => print('BannerAd loaded.'),
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          ad.dispose();
          print('BannerAd failed to load: $error');
        },
      ),
    )..load();
  }

  static BannerAd? get bannerAd => _bannerAd;
}
