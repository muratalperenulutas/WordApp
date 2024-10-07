import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:word_app/controllers/app_controller.dart';
import 'package:word_app/initialPage.dart';
import 'package:word_app/lang/app_translations.dart';
import 'package:word_app/pages/draggable_word_cards_page/draggable_word_cards_page.dart';
import 'package:word_app/pages/scrollable_words_page.dart';
import 'package:word_app/pages/settings_page.dart';
import 'package:word_app/pages/word_lists_page.dart';
import 'package:word_app/themes/app_theme.dart';

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final AppController appController = Get.put(AppController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return GetMaterialApp(
        translations: AppTranslations(),
        locale: Locale(appController.selectedLanguage.value == 'English' ? 'en' : 'tr'),
        fallbackLocale: Locale('en', 'US'),
          initialRoute: '/',
          getPages: [
            GetPage(name: '/', page: () => initialPage()),
            GetPage(name: '/settings', page: () => SettingsPage()),
            GetPage(name: '/draggable', page: () => DraggableWordCards()),
            GetPage(name: '/scrollable', page: () => ScrollableWords()),
            GetPage(name: '/wordLists', page: () => MyWordListsPage()),
          ],
          debugShowCheckedModeBanner: false,
          //theme: Get.find<AppController>().isDarkTheme.value?ThemeData.dark():ThemeData.light(),
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: appController.isDarkTheme.value
              ? ThemeMode.dark
              : ThemeMode.light,
          home: initialPage());
    });
  }
}
