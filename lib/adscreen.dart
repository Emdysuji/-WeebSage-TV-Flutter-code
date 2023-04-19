import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class AdsScreen extends StatefulWidget {
  const AdsScreen({Key? key}) : super(key: key);

  @override
  _AdsScreenState createState() => _AdsScreenState();
}

class _AdsScreenState extends State<AdsScreen> {
  String adLink =
      "https://www.highrevenuegate.com/t755x7bifm?key=60e48fab4ffe93b6bec6cfaaee182f49";
  int secondsLeft = 20;

  @override
  void initState() {
    super.initState();
    // Start a countdown timer when the widget is created
    // and update the secondsLeft variable every second
    Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        secondsLeft--;
      });
      if (secondsLeft == 0) {
        timer.cancel();
        if (Navigator.canPop(context)) {
          Navigator.pop(context);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 17, 17, 17),
        title: const Text('The Sage Ads Screen'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Text('$secondsLeft seconds left'),
          ),
        ],
      ),
      body: Stack(
        children: [
          WebView(
            initialUrl: adLink,
            javascriptMode: JavascriptMode.unrestricted,
            navigationDelegate: (NavigationRequest request) {
              launch(adLink);
              return NavigationDecision.navigate;
            },
          ),
          FutureBuilder(
            future: Future.delayed(const Duration(seconds: 20)),
            initialData: null,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                Navigator.pop(context);
              }
              return SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }
}
