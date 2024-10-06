import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:word_app/services/dbService/database_helper.dart';
import 'package:word_app/widgets/card/rotatable_and_scrollable_cards.dart';

class ScrollableWords extends StatefulWidget {
  const ScrollableWords({super.key});

  @override
  State<ScrollableWords> createState() => _ScrollableWordsState();
}

class _ScrollableWordsState extends State<ScrollableWords> {
  final dbHelper = DatabaseHelper();
  List<Map<String, dynamic>> words =[];


  void initState() {
    super.initState();
    _initDatabase();
  }

  Future<void> _initDatabase() async {
    List<Map<String, dynamic>> randWords =
        await dbHelper.getRandomWords(wordListName: "Oxford_Lists_A1", count: 15);
    //print(randWords);

    setState(() {
      words = randWords;
    });
  }
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.height;
    return Scaffold(
      body:SafeArea(child: RotatableScrollableCards(words:words,Padding:EdgeInsets.symmetric(vertical: screenHeight*0.04,horizontal: screenWidth*0.04) ,)),);
  }
}