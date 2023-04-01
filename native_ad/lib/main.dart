import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:native_ad/home_screen.dart';
import 'package:native_ad/share.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: NativeAdScreen(),
    ),
  );
}

class NativeAdScreen extends StatefulWidget {
  const NativeAdScreen({Key? key}) : super(key: key);

  @override
  State<NativeAdScreen> createState() => _NativeAdScreenState();
}

class _NativeAdScreenState extends State<NativeAdScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ShareScreen()),
            );
            // Navigator.of(context).pushReplacementNamed("ShareScreen");
          },
          child: const Icon(Icons.add),
        ),
        appBar: AppBar(
          title: const Text('Native Ad'),
          centerTitle: true,
        ),
        // body: ElevatedButton(
        //   onPressed: () {
        //     Navigator.of(context).pushNamed('HomeScreen');
        //   },
        //   child: const Text("next page"),
        // ),
        body: ListView.builder(
          itemCount: 15,
          itemBuilder: (context, index) {
            if (index % 2 == 0) {
              return const NativeAdView();
            } else {
              return Container(
                height: 100,
                color: Colors.amber,
              );
            }
          },
        ),
        // body: ListView.builder(
        //   shrinkWrap: true,
        //   itemCount: 15,
        //   itemBuilder: (context, index) {
        //     if (index % 2 == 0) {
        //       return _ad != null
        //           ? Container(
        //               height: 120,
        //               alignment: Alignment.center,
        //               child: AdWidget(ad: _ad, key: Key(index.toString())),
        //             )
        //           : Container(
        //               height: 100,
        //               color: Colors.black,
        //             );
        //       ;
        //     } else {
        //       return Container(
        //         height: 100,
        //         color: Colors.red,
        //       );
        //     }
        //   },
        // ),
      ),
    );
  }
}
