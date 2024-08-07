// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/game_provider.dart';
import '../widgets/tube_widget.dart';
import '../services/ads_manager.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class GameScreen extends StatefulWidget {
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  @override
  void initState() {
    super.initState();
    AdsManager.loadRewardedAd(() {});
    AdsManager.loadInterstitialAd();
    AdsManager.loadBannerAd();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => GameProvider(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Color Water Sort Puzzle'),
          actions: [
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                Provider.of<GameProvider>(context, listen: false).resetGame();
              },
            ),
            IconButton(
              icon: Icon(Icons.undo),
              onPressed: () {
                Provider.of<GameProvider>(context, listen: false).undo();
              },
            ),
            IconButton(
              icon: Icon(Icons.skip_next),
              onPressed: () {
                AdsManager.showRewardedAd(() {
                  Provider.of<GameProvider>(context, listen: false).resetGame();
                });
              },
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: Consumer<GameProvider>(
                builder: (context, gameProvider, child) {
                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    itemCount: gameProvider.tubes.length,
                    itemBuilder: (context, index) {
                      return TubeWidget(
                        tube: gameProvider.tubes[index],
                        onTap: () {
                          // Handle tap to pour liquid
                        },
                      );
                    },
                  );
                },
              ),
            ),
            if (AdsManager.bannerAd != null)
              Container(
                height: AdsManager.bannerAd!.size.height.toDouble(),
                width: AdsManager.bannerAd!.size.width.toDouble(),
                child: AdWidget(ad: AdsManager.bannerAd!),
              ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    AdsManager.bannerAd?.dispose();
    super.dispose();
  }
}
