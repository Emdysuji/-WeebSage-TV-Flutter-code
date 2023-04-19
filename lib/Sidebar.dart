import 'package:flutter/material.dart';
import 'adscreen.dart';
import 'package:fluttericon/linearicons_free_icons.dart';
import 'package:fluttericon/font_awesome5_icons.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({
    Key? key,
    required this.websites,
    required this.loadUrl,
  }) : super(key: key);

  final List<String> websites;
  final Function(String url) loadUrl;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: const Color.fromARGB(255, 17, 17, 17),
        child: ListView.separated(
          // Use ListView.separated instead of ListView
          padding: EdgeInsets.zero,
          itemBuilder: (BuildContext context, int index) {
            switch (index) {
              case 0:
                return const DrawerHeader(
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 215, 24, 24),
                    image: DecorationImage(
                      image: AssetImage('lib/assets/Image/animeBackgroun.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: null,
                );
              case 1:
                return ListTile(
                  leading: const Icon(LineariconsFree.film_play,
                      color: Colors.white),
                  title: const Text('WeebSage Anime'),
                  textColor: const Color.fromARGB(255, 255, 255, 255),
                  onTap: () {
                    loadUrl(websites[0]);
                    Navigator.pop(context);
                  },
                );
              case 2:
                return ListTile(
                  leading:
                      const Icon(FontAwesome5.book_open, color: Colors.white),
                  title: const Text('WeebSage Mange'),
                  textColor: const Color.fromARGB(255, 255, 255, 255),
                  onTap: () {
                    loadUrl(websites[1]);
                    Navigator.pop(context);
                  },
                );
              case 3:
                return ListTile(
                  leading:
                      const Icon(FontAwesome5.book_open, color: Colors.white),
                  title: const Text('WeebSage Manhwa'),
                  textColor: const Color.fromARGB(255, 255, 255, 255),
                  onTap: () {
                    loadUrl(websites[2]);
                    Navigator.pop(context);
                  },
                );
              case 4:
                return ListTile(
                  leading: const Icon(FontAwesome5.search, color: Colors.white),
                  title: const Text('Anime Search'),
                  textColor: const Color.fromARGB(255, 255, 255, 255),
                  onTap: () {
                    loadUrl(websites[3]);
                    Navigator.pop(context);
                  },
                );
              case 5:
                return ListTile(
                  leading:
                      const Icon(FontAwesome5.gamepad, color: Colors.white),
                  title: const Text('Anime Games'),
                  textColor: const Color.fromARGB(255, 255, 255, 255),
                  onTap: () {
                    loadUrl(websites[7]);
                    Navigator.pop(context);
                  },
                );
              case 6:
                return ListTile(
                  leading:
                      const Icon(FontAwesome5.buysellads, color: Colors.white),
                  title: const Text('Support us by viewing Ads'),
                  textColor: const Color.fromARGB(255, 255, 255, 255),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => AdsScreen(),
                      ),
                    );
                  },
                );

              default:
                return const SizedBox.shrink();
            }
          },
          separatorBuilder: (BuildContext context, int index) {
            if (index > 0) {
              // Add the Divider widget for index > 0
              return const Divider(
                color: Colors.red,
                height: 1.0,
                thickness: 1.0,
                indent: 16.0,
                endIndent: 16.0,
              );
            }
            return const SizedBox.shrink();
          },
          itemCount: 7, // Set the number of items to 7
        ),
      ),
    );
  }
}
