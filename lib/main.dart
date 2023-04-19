import 'dart:async';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'sidebar.dart';
import 'vidplayer.dart';
import 'package:flutter/services.dart';
import 'adscreen.dart';
import 'package:vibration/vibration.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

// ignore: use_key_in_widget_constructors
class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: const Center(
        child:
            CircularProgressIndicator(color: Color.fromARGB(255, 215, 24, 24)),
      ),
    );
  }
}

class _MyAppState extends State<MyApp> {
  late WebViewController controller;
  String _currentUrl = 'https://animension.to/';
  String videoUrl = '';
  bool showFloatingActionButton = false;
  String srcUrl = '';
  bool _showLoadingScreen = false;
  bool streamText = false;
  bool isNotLoadedYet = true;
  late String fileName;
  String adLink =
      "https://www.highrevenuegate.com/t755x7bifm?key=60e48fab4ffe93b6bec6cfaaee182f49";
  List<Map<String, String>> links = [];

  // List of websites to be loaded when the corresponding button is pressed
  final List<String> _websites = [
    'https://animension.to/',
    'https://mangasee123.com/',
    'https://comick.app/home',
    'https://myanimelist.net/anime.php',
    'https://animension.to/search?dub=0&sort=az',
    'https://mangasee123.com/search/',
    'https://comick.app/search',
    'https://heylink.me/Weeb_Sage/',
    'https://stream-together.org/',
    'https://anihdplay.com/',
    'https://gogodownload.net/',
    'https://sto144',
    'https://sbone.pro/',
    'https://www.mp4upload.com/',
    'https://www.taptap.io/',
    'https://www.mediafire.com/'
  ];
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // Method called when a side tab button is pressed
  void _loadUrl(String url) {
    setState(() {
      _currentUrl = url;
    });
    controller.loadUrl(_currentUrl);
  }

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 20), () {
      setState(() {
        isNotLoadedYet = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: isNotLoadedYet
          ? const AdsScreen()
          : Builder(
              builder: (context) => WillPopScope(
                onWillPop: () async {
                  final bool canGoBack = await controller.canGoBack();
                  if (canGoBack) {
                    controller.goBack();
                    return false;
                  } else {
                    return true;
                  }
                },
                child: Scaffold(
                  key: _scaffoldKey,
                  appBar: AppBar(
                    backgroundColor: const Color.fromARGB(255, 17, 17, 17),
                    title: const Text('WeebSage Tv'),
                    leading: IconButton(
                      icon: const Icon(Icons.menu),
                      color: const Color.fromARGB(255, 215, 24, 24),
                      onPressed: () {
                        _scaffoldKey.currentState?.openDrawer();
                      },
                    ),
                  ),
                  body: Stack(
                    children: [
                      WebView(
                        initialUrl: _currentUrl,
                        javascriptMode: JavascriptMode.unrestricted,
                        navigationDelegate: (NavigationRequest request) {
                          if (request.url
                                  .contains('https://gogodownload.net') ||
                              request.url.contains('https://sto144')) {
                            launch(request.url);
                            launch(adLink);
                          }
                          if (request.url
                                  .contains('https://www.mediafire.com/') ||
                              request.url.contains('https://www.taptap.io/')) {
                            launch(adLink);
                            launch(request.url);
                            return NavigationDecision.prevent;
                          }
                          final onlyUrl = request.url;
                          if (_websites
                              .any((websites) => onlyUrl.contains(websites))) {
                            return NavigationDecision.navigate;
                          } else if (request.url ==
                              'https://comick.app/user/login') {
                            return NavigationDecision.prevent;
                          } else {
                            return NavigationDecision.prevent;
                          }
                        },
                        onPageStarted: (String url) {
                          setState(() {
                            _showLoadingScreen = true;
                          });
                          if (url.contains("https://stream-together.org/")) {
                            setState(() {
                              _showLoadingScreen = false;
                              streamText = true;
                            });
                          } else {
                            setState(() {
                              streamText = false;
                            });
                          }
                        },
                        onPageFinished: (String url) async {
                          if (url.contains("https://stream-together.org/")) {
                            controller.runJavascriptReturningResult('''
var element = document.getElementById('brand-logo md-0 mt-5 text-center');
      if (element != null) {
        element.remove();
      }
      ''');

                            // creating a new FloatingActionButton
                            final srcUrl = await controller
                                .runJavascriptReturningResult('''
                             var video = document.getElementById('embed-video');
                             if (video != null) {
                                video.getAttribute('src');
                            } else {
                            '';
                            }
                            ''');
                            setState(() {
                              videoUrl = srcUrl;
                            });
                          } else {
                            setState(() {
                              videoUrl = '';
                              showFloatingActionButton = false;
                            });
                          }
                          if (videoUrl.contains("https")) {
                            setState(() {
                              showFloatingActionButton = true;
                              Vibration.vibrate(duration: 1000);
                            });
                          }

                          if (_currentUrl == _websites[0] ||
                              url.contains(_websites[0])) {
                            controller.runJavascriptReturningResult('''
var elements = document.querySelectorAll('body, *');
    for (var i = 0; i < elements.length; i++) {
      var color = window.getComputedStyle(elements[i]).getPropertyValue('color');
      var backgroundColor = window.getComputedStyle(elements[i]).getPropertyValue('background-color');
      if (color == 'rgb(61, 166, 223)' || color == '#3da6df') {
        elements[i].style.color = 'rgb(215, 24, 24)';
      }
      if (backgroundColor == 'rgb(49, 159, 218)' || backgroundColor == '#319fda') {
        elements[i].style.backgroundColor = 'rgb(215, 24, 24)';
      }
      if (backgroundColor == 'rgb(35, 135, 189)' || backgroundColor == '#2387bd') {
        elements[i].style.backgroundColor = 'rgb(215, 24, 24)';
      }
      if (backgroundColor == 'rgb(72, 186, 243)' || backgroundColor == '#48baf3') {
        elements[i].style.backgroundColor = 'red';
      }
      if (backgroundColor == 'rgb(86, 197, 253)' || backgroundColor == '#56c5fd') {
        elements[i].style.backgroundColor = 'red';
      }
      if (backgroundColor == 'rgb(43, 43, 43)' || backgroundColor == '#2b2b2b') {
        elements[i].style.backgroundColor = 'rgb(139, 0, 0)';
      }
      if (backgroundColor == 'rgb(39, 112, 151)' || backgroundColor == '#277097') {
        elements[i].style.backgroundColor = 'rgb(139, 0, 0)';
      }
      if (backgroundColor == 'rgb(33 44 50);' || backgroundColor == '#212c32') {
        elements[i].style.backgroundColor = 'rgb(17, 17, 17)';
      }
    }
      var element = document.getElementById('message_global');
      if (element != null) {
        element.remove();
      }
      var element = document.querySelector('.th');
if (element != null) {
  element.remove();
}


      var element = document.getElementById('footer');
      if (element != null) {
        element.remove();
      }
       ''');
                          } else if (_currentUrl == _websites[1] ||
                              url.contains(_websites[1])) {
                            controller.runJavascriptReturningResult('''
      var element = document.getElementById('Nav');
      if (element != null) {
        element.remove();
      }
      var element = document.getElementById('footer');
      if (element != null) {
        element.remove();
      }
       ''');
                          } else if (_currentUrl == _websites[2] ||
                              url.contains(_websites[2])) {
                            controller.runJavascriptReturningResult(
                                "document.getElementsByTagName('header')[0].style.display='none'");
                            controller.runJavascriptReturningResult('''
      var element = document.getElementById('navbar');
      if (element != null) {
        element.remove();
      }
       document.querySelectorAll('div.py-0.lg\\:container.text-center.m-auto.mt-3')
              .forEach(function(div) {
                div.classList.remove('py-0', 'lg:container', 'text-center', 'm-auto', 'mt-3');
              });       
       ''');
                          } else if (_currentUrl == _websites[3] ||
                              url.contains(_websites[3])) {
                            controller.runJavascriptReturningResult('''
      var element = document.getElementById('headerSmall');
      if (element != null) {
        element.remove();
      }

      var element = document.getElementById('menu');
      if (element != null) {
        element.remove();
      }

      var element = document.getElementById('footer');
      if (element != null) {
        element.remove();
      }
       ''');
                          }
                          setState(() {
                            _showLoadingScreen = false;
                          });
                        },
                        onWebViewCreated: (WebViewController controller) {
                          this.controller = controller;
                          _loadBlocker();
                        },
                      ),
                      if (_showLoadingScreen) LoadingScreen(),
                      if (streamText)
                        Positioned(
                          top: MediaQuery.of(context).size.height / 3,
                          left: 0,
                          right: 0,
                          bottom: MediaQuery.of(context).size.height / 3,
                          child: Container(
                            color: Colors.black.withOpacity(0.9),
                            child: Center(
                              child: showFloatingActionButton
                                  ? IconButton(
                                      icon: Icon(Icons.play_circle_fill),
                                      color: Colors.white,
                                      iconSize: 50,
                                      onPressed: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                VideoPlayerWidget(
                                                    videoUrl: videoUrl),
                                          ),
                                        );
                                      },
                                    )
                                  : Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: const [
                                        CircularProgressIndicator(),
                                        SizedBox(height: 10),
                                        Text(
                                          "To stream online, wait for the video to load.\nTo download, click the button below.",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ],
                                    ),
                            ),
                          ),
                        ),
                    ],
                  ),
                  floatingActionButton: FloatingActionButton(
                    backgroundColor: const Color.fromARGB(170, 215, 24, 24),
                    child: showFloatingActionButton
                        ? const Icon(Icons.play_arrow, size: 32)
                        : const Icon(Icons.search, size: 32),
                    onPressed: () async {
                      if (showFloatingActionButton == true) {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) =>
                                VideoPlayerWidget(videoUrl: videoUrl),
                          ),
                        );
                      } else {
                        if (_currentUrl == _websites[0]) {
                          controller.loadUrl(_websites[4]);
                        } else if (_currentUrl == _websites[1]) {
                          controller.loadUrl(_websites[5]);
                        } else if (_currentUrl == _websites[2]) {
                          controller.loadUrl(_websites[6]);
                        } else if (_currentUrl == _websites[3]) {
                          controller.loadUrl(_websites[3]);
                        }
                      }
                    },
                  ),
                  drawer: Sidebar(
                    websites: _websites,
                    loadUrl: _loadUrl,
                  ),
                ),
              ),
            ),
    );
  }

  void _loadBlocker() async {
    String adBlockScript = await rootBundle.loadString('assets/ad-blocker.js');
    await controller.runJavascriptReturningResult(adBlockScript);
  }
}
