import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:native_ad/helper_class.dart';

class NativeAdView extends StatefulWidget {
  const NativeAdView({Key? key}) : super(key: key);

  @override
  _NativeAdViewState createState() => _NativeAdViewState();
}

class _NativeAdViewState extends State<NativeAdView> {
  late NativeAd _ad;
  bool _isAdLoaded = false;

  @override
  void initState() {
    super.initState();

    _ad = NativeAd(
      adUnitId: AdHelper.nativeAdUnitId,
      factoryId: 'listTile',
      request: const AdRequest(),
      listener: NativeAdListener(
        onAdLoaded: (_) {
          setState(() {
            _isAdLoaded = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          // Releases an ad resource when it fails to load
          ad.dispose();

          print('Ad load failed (code=${error.code} message=${error.message})');
        },
      ),
    );

    _ad.load();
  }

  @override
  void dispose() {
    super.dispose();
    _ad.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (_isAdLoaded) ...{
          Container(
            child: AdWidget(ad: _ad),
            height: 120,
            alignment: Alignment.center,
          )
        } else ...{
          Container(
            height: 100,
            color: Colors.black,
          )
        }
      ],
    );
  }
}
