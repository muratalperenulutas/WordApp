import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppController extends GetxController {
  var isDarkTheme = false.obs;
  var isScrollableWordsVertical = true.obs;
  var selectedLanguage = 'English'.obs;
  var selectedScrollableWordsPageListId = ''.obs;
  var selectedDraggableWordsPageListId = ''.obs;

  @override
  void onInit() {
    super.onInit();
    _loadPreferences();
  }

  void _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    isDarkTheme.value = prefs.getBool('isDarkTheme') ?? false;
    isScrollableWordsVertical.value =
        prefs.getBool('scrollableWordsVertical') ?? false;
    selectedLanguage.value = prefs.getString("selectedLanguage") ?? 'English';
    switch (selectedLanguage.value) {
      case 'English':
        Get.updateLocale(Locale('en', 'US'));
        break;
      case 'Turkish':
        Get.updateLocale(Locale('tr', 'TR'));
      default:
    }
    selectedScrollableWordsPageListId.value =
        prefs.getString("selectedScrollableWordsPageListId") ?? "";
    selectedDraggableWordsPageListId.value =
        prefs.getString("selectedDraggableWordsPageListId") ?? "";
  }

  void toggleTheme() async {
    isDarkTheme.value = !isDarkTheme.value;
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isDarkTheme', isDarkTheme.value);
  }

  void toggleSwippleDirection() async {
    final prefs = await SharedPreferences.getInstance();
    isScrollableWordsVertical.value = !isScrollableWordsVertical.value;
    prefs.setBool('scrollableWordsVertical', isScrollableWordsVertical.value);
  }

  void setLanguage(String language) async {
    selectedLanguage.value = language;
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('selectedLanguage', language);
    switch (language) {
      case 'English':
        Get.updateLocale(Locale('en', 'US'));
        break;
      case 'Turkish':
        Get.updateLocale(Locale('tr', 'TR'));
      default:
    }
  }

  void setScrollableWordsPageListId(String wordListName) async {
    selectedScrollableWordsPageListId.value = wordListName;
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('selectedScrollableWordsPageListId', wordListName);
  }

    void setDraggableWordsPageListId(String wordListName) async {
    selectedDraggableWordsPageListId.value = wordListName;
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('selectedDraggableWordsPageListId', wordListName);
  }
}
