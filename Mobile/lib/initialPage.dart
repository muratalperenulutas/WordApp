import 'package:flutter/material.dart';
import 'package:word_app/my_app_body.dart';
import 'package:word_app/side_menu_panel.dart';


class initialPage extends StatelessWidget {
  const initialPage({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
            appBar: AppBar(
              title: Text(
                "Word App",
              ),
              toolbarHeight: screenHeight * 0.06,
              leading: Builder(
                builder: (context) => IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                ),
              ),
            ),
            drawer: SideMenuPanel(),
            body: MyAppBody(),
          );
  }
}