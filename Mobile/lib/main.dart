import 'package:flutter/material.dart';
import 'package:word_app/app.dart';
import 'package:word_app/services/randomWordService/random_word.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  RandomWordService().initialize;
  //RandomWordService().getRandomWords(3,"oxfordA1");
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp(MyApp());
  });
}
