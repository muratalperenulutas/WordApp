import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:word_app/controllers/app_controller.dart';
import 'package:word_app/services/dbService/database_helper.dart';

class MyAppBody extends StatefulWidget {
  const MyAppBody({super.key});

  @override
  State<MyAppBody> createState() => _MyAppBodyState();
}

class _MyAppBodyState extends State<MyAppBody> {
  final dbHelper = DatabaseHelper();
  List<Map<String, dynamic>> words =[];


  void initState() {
    super.initState();
    _initDatabase();
  }

  Future<void> _initDatabase() async {
    List<Map<String, dynamic>> randWords =
        await dbHelper.getRandomWords(wordListName: "words", count: 15);
    //print(randWords);

    setState(() {
      words = randWords;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    final AppController appController = Get.find<AppController>();
    return Column(
      children: [
        Obx(() {
          return Text(
              "Theme:${appController.isDarkTheme.value ? "Dark " : "Light " + appController.isScrollableWordsVertical.value.toString()}");
        }),
       
      ],
    );
  }
}
