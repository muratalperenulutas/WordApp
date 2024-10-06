import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:word_app/pages/settings_page.dart';
import 'package:word_app/pages/scrollable_words_page.dart';
import 'package:word_app/pages/draggable_word_cards_page/draggable_word_cards_page.dart';
import 'package:word_app/pages/word_lists_page.dart';

class SideMenuPanel extends StatelessWidget {
  const SideMenuPanel({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.5,
      child: Drawer(
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  const DrawerHeader(
                    duration: Duration(milliseconds: 100),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                    ),
                    child: Text(
                      'Menu',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.list_alt),
                    title: const Text('Word Lists'),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MyWordListsPage()
                        ),
                      );
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.swipe_vertical_rounded),
                    title: const Text('Scrollable Words'),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ScrollableWords()
                          
                        ),
                      );
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.settings),
                    title: const Text('Settings'),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SettingsPage(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.library_books_outlined),
                    title: const Text('Draggable Word Cards'),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DraggableWordCards(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('About'),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AboutDialog(
                      applicationVersion: "1.0.0",
                      applicationName: "Word App",
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}


//no