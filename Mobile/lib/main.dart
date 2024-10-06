import 'package:flutter/material.dart';
import 'package:word_app/app.dart';
import 'package:word_app/services/randomWordService/random_word.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  RandomWordService().initialize;
  //RandomWordService().getRandomWords(3,"oxfordA1");

  runApp(MyApp());
}
