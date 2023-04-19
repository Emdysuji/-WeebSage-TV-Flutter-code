import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/services.dart';

class VideoPlayerWidget extends StatefulWidget {
  final String videoUrl;

  VideoPlayerWidget({required this.videoUrl});

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late WebViewController _controller;

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);

    return Scaffold(
      body: WebView(
        initialUrl: widget.videoUrl.replaceAll('"', ''),
        javascriptMode: JavascriptMode.unrestricted,
        navigationDelegate: (NavigationRequest request) {
          return NavigationDecision.prevent;
        },
        onWebViewCreated: (controller) {
          _controller = controller;
          _loadBlocker();
        },
      ),
    );
  }

  void _loadBlocker() async {
    String adBlockScript = await rootBundle.loadString('assets/ad-blocker.js');
    await _controller.runJavascriptReturningResult(adBlockScript);
  }
}
