import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:word_app/controllers/app_controller.dart';
import 'package:word_app/my_app_body.dart';
import 'package:word_app/side_menu_panel.dart';
import 'package:word_app/themes/app_theme.dart';

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final AppController appController = Get.put(AppController());

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Obx(() {
      return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          //theme: Get.find<AppController>().isDarkTheme.value?ThemeData.dark():ThemeData.light(),
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: appController.isDarkTheme.value
              ? ThemeMode.dark
              : ThemeMode.light,
          home: Scaffold(
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
          ));
    });
  }
}
