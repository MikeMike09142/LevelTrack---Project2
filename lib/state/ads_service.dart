import 'dart:io' show Platform;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'app_state.dart' as vm;
import '../config/ads_config.dart';

class AdsService {
  AdsService._();
  static final AdsService instance = AdsService._();

  RewardedAd? _rewardedAd;
  bool _initialized = false;
  String? _lastLoadError;

  Future<void> initialize() async {
    if (_initialized) return;
    if (!kIsWeb) {
      await MobileAds.instance.initialize();
    }
    _initialized = true;
  }

  String get rewardedUnitId {
    if (kIsWeb) return 'web-fallback';
    if (Platform.isAndroid) {
      // Prefer production ID provided via --dart-define
      final prod = AdsConfig.rewardedAndroidId;
      if (prod != null && prod.isNotEmpty) return prod;
      // Fallback to Google test ad unit for Rewarded
      return 'ca-app-pub-3940256099942544/5224354917';
    }
    // iOS: prefer dart-define, otherwise test unit id
    final prodIos = AdsConfig.rewardedIosId;
    if (prodIos != null && prodIos.isNotEmpty) return prodIos;
    return 'ca-app-pub-3940256099942544/1712485313';
  }

  Future<void> preloadRewarded() async {
    if (kIsWeb) return; // no real ads on web
    // If ads are permanently removed, do not load ads.
    if (vm.AppState.instance.areAdsRemoved.value) return;

    await initialize();
    await RewardedAd.load(
      adUnitId: rewardedUnitId,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          _rewardedAd = ad;
          _lastLoadError = null;
        },
        onAdFailedToLoad: (error) {
          _rewardedAd = null;
          _lastLoadError = '${error.code}: ${error.message}';
          debugPrint('RewardedAd failed to load: $_lastLoadError');
        },
      ),
    );
  }

  Future<bool> showRewardedToUnlock(BuildContext context, {int? levelNumber}) async {
    // If ads are permanently removed, unlock immediately.
    if (vm.AppState.instance.areAdsRemoved.value) {
      if (levelNumber != null) {
        vm.AppState.instance.unlockLevelByAd(levelNumber);
      }
      return true;
    }

    await initialize();
    // Skip ads if already unlocked or in admin mode
    if (levelNumber != null) {
      final idx = vm.AppState.instance.levels.value.indexWhere((l) => l.number == levelNumber);
      if (idx >= 0) {
        final lvl = vm.AppState.instance.levels.value[idx];
        if (lvl.adUnlocked == true) {
          return true;
        }
      }
    }
    // Admin mode removed; no bypass.
    if (kIsWeb) {
      // Simulate a short wait on web; do not block navigation with real ads
      if (!context.mounted) return false;
      final ok = await showDialog<bool>(
        context: context,
        barrierDismissible: false,
        builder: (ctx) {
          return AlertDialog(
            title: const Text('Watch Ad to Unlock'),
            content: const Text('Ads are not available on Web. Unlocking for preview.'),
            actions: [
              TextButton(onPressed: () => Navigator.of(ctx).pop(true), child: const Text('Continue')),
            ],
          );
        },
      );
      if (ok == true && levelNumber != null) {
        vm.AppState.instance.unlockLevelByAd(levelNumber);
      }
      return ok == true;
    }

    // If not preloaded, try loading now
    if (_rewardedAd == null) {
      await preloadRewarded();
    }
    final ad = _rewardedAd;
    if (ad == null) {
      // Failed to load — inform user and do not unlock
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Unable to load ad. ${_lastLoadError ?? 'Please try again.'}')),
        );
      }
      return false;
    }

    bool earned = false;
    ad.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (_) {
        _rewardedAd?.dispose();
        _rewardedAd = null;
        // Preload next ad
        preloadRewarded();
      },
      onAdFailedToShowFullScreenContent: (_, error) {
        _rewardedAd?.dispose();
        _rewardedAd = null;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Ad failed to show. ${error.message}')),
        );
      },
    );

    await ad.show(onUserEarnedReward: (_, reward) {
      earned = true;
      if (levelNumber != null) {
        vm.AppState.instance.unlockLevelByAd(levelNumber);
      }
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Reward earned! Level unlocked.')),
      );
    });

    return earned;
  }

  // Show a rewarded ad after finishing a section. Does not change unlock state.
  Future<void> showRewardedAfterSection(
    BuildContext context, {
    String? sectionName,
    int? levelNumber,
  }) async {
    // If ads are permanently removed, do not show ad.
    if (vm.AppState.instance.areAdsRemoved.value) return;

    await initialize();

    if (kIsWeb) {
      // Inform user in web preview; real ads only on Android/iOS
      if (!context.mounted) return;
      await showDialog<void>(
        context: context,
        barrierDismissible: true,
        builder: (ctx) => AlertDialog(
          title: const Text('Ad Preview'),
          content: const Text('Ads are not available on Web. Skipping ad.'),
          actions: [
            TextButton(onPressed: () => Navigator.of(ctx).pop(), child: const Text('OK')),
          ],
        ),
      );
      return;
    }

    // If not preloaded, try loading now
    if (_rewardedAd == null) {
      await preloadRewarded();
    }
    final ad = _rewardedAd;
    if (ad == null) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Unable to load ad. ${_lastLoadError ?? 'Please try again.'}')),
        );
      }
      return;
    }

    ad.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (_) {
        _rewardedAd?.dispose();
        _rewardedAd = null;
        preloadRewarded();
      },
      onAdFailedToShowFullScreenContent: (_, error) {
        _rewardedAd?.dispose();
        _rewardedAd = null;
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Ad failed to show. ${error.message}')),
          );
        }
      },
    );

    await ad.show(onUserEarnedReward: (_, reward) {
      // No unlock here; just acknowledge reward earning.
      final label = sectionName != null ? ' for $sectionName' : '';
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Thanks for watching! Reward earned$label.')),
        );
      }
    });
  }
}