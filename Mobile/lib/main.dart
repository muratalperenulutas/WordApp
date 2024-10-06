import 'package:flutter/material.dart';
import 'package:word_app/app.dart';
import 'package:get/get.dart';
import 'package:word_app/controllers/app_controller.dart';
import 'package:word_app/services/randomWordService/random_word.dart';

void main() {
   WidgetsFlutterBinding.ensureInitialized();
  final AppController appController = Get.put(AppController());
  RandomWordService().initialize;
  //RandomWordService().getRandomWords(3,"oxfordA1");

  runApp(const MyApp());
}
