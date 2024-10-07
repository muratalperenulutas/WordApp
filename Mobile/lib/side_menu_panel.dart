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
                  DrawerHeader(
                    duration: Duration(milliseconds: 100),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                    ),
                    child: Text(//image
                      'Menu'.tr,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.list_alt),
                    title: Text('Word_Lists'.tr),
                    onTap: () {
                      Get.back();
                      Get.toNamed('/wordLists');
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.swipe_vertical_rounded),
                    title: Text('Scrollable_Word_Cards'.tr),
                    onTap: () {
                      Get.back();
                      Get.toNamed('/scrollable');
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.library_books_outlined),
                    title: Text('Draggable_Word_Cards'.tr),
                    onTap: () {
                      Get.back();
                      Get.toNamed('/draggable');
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.settings),
                    title: Text('Settings'.tr),
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
              title: Text('About'.tr),
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
