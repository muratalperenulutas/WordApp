import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:word_app/controllers/app_controller.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    final AppController appController = Get.find<AppController>();
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Column(
        children: [
          Obx(() => SwitchListTile(
            title: Text('Dark Theme'),
            value: appController.isDarkTheme.value,
            onChanged: (bool value) {
              appController.toggleTheme();
            },
          )),
          Obx(() => ListTile(
            title: Text('Swipple Words Direction'),
            trailing: DropdownButton<String>(
              value: appController.isScrollableWordsVertical.value ? 'Vertical' : 'Horizontal',
              onChanged: (String? newValue) {
                appController.toggleSwippleDirection();
              },
              items: <String>['Horizontal', 'Vertical']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          )),
          Obx(() => ListTile(
            title: Text('Language'),
            trailing: DropdownButton<String>(
              value: appController.selectedLanguage.value,
              onChanged: (String? newValue) {
                appController.setLanguage(newValue!);
              },
              items: <String>['English', 'Turkish']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          )),
        ],
      ),
    );
  }
}
