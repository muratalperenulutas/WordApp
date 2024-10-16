import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppController extends GetxController {
  var isDarkTheme = false.obs;
  var isScrollableWordsVertical = true.obs;
  var selectedLanguage = 'English'.obs;
  var selectedScrollableWordsPageList = ''.obs;
  var selectedDraggableWordsPageList = ''.obs;

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
    selectedLanguage.value = prefs.getString("selectedLanguage") ?? 'Turkish';
    switch (selectedLanguage.value) {
      case 'English':
        Get.updateLocale(Locale('en', 'US'));
        break;
      case 'Turkish':
        Get.updateLocale(Locale('tr', 'TR'));
      default:
    }
    selectedScrollableWordsPageList.value =
        prefs.getString("selectedScrollableWordsPageList") ?? "";
    selectedDraggableWordsPageList.value =
        prefs.getString("selectedDraggableWordsPageList") ?? "";
  }

  void _savePreferences() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isDarkTheme', isDarkTheme.value);
    prefs.setBool('scrollableWordsVertical', isScrollableWordsVertical.value);
  }

  void toggleTheme() {
    isDarkTheme.value = !isDarkTheme.value;
    _savePreferences();
  }

  void toggleSwippleDirection() {
    isScrollableWordsVertical.value = !isScrollableWordsVertical.value;
    _savePreferences();
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

  void setScrollableWordsPageList(String wordListName) async {
    selectedScrollableWordsPageList.value = wordListName;
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('selectedScrollableWordsPageList', wordListName);
  }

    void setDraggableWordsPageList(String wordListName) async {
    selectedDraggableWordsPageList.value = wordListName;
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('selectedDraggableWordsPageList', wordListName);
  }
}
