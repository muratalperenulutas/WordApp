import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SideMenuPanel extends StatelessWidget {
  const SideMenuPanel({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.6,
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
                    child: Text(//image
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
                      Get.back();
                      Get.toNamed('/wordLists');
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.swipe_vertical_rounded),
                    title: const Text('Scrollable Words'),
                    onTap: () {
                      Get.back();
                      Get.toNamed('/scrollable');
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.library_books_outlined),
                    title: const Text('Draggable Word Cards'),
                    onTap: () {
                      Get.back();
                      Get.toNamed('/draggable');
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.settings),
                    title: const Text('Settings'),
                    onTap: () {
                      Get.back();
                      Get.toNamed('/settings');
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
                    return const AboutDialog(
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
