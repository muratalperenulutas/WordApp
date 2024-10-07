import 'package:flutter/material.dart';
import 'package:word_app/services/dbService/database_helper.dart';
import 'package:word_app/widgets/card/rotatable_and_scrollable_cards.dart';

class ScrollableWords extends StatefulWidget {
  const ScrollableWords({super.key});

  @override
  State<ScrollableWords> createState() => _ScrollableWordsState();
}

class _ScrollableWordsState extends State<ScrollableWords> {
  final dbHelper = DatabaseHelper();
  List<Map<String, dynamic>> words = [];
    List<Map<String, dynamic>> dropdownValues = [];
  String dropdownValue = 'Oxford Lists A1';

  void initState() {
    super.initState();
    _initDatabase();
  }

  Future<void> _initDatabase() async {
    List<Map<String, dynamic>> randWords = await dbHelper.getRandomWords(
        wordListName: "Oxford_Lists_A1", count: 15);
        List<Map<String, dynamic>> downloadedLists =
        await dbHelper.getDownloadedWordListsInfos();

    //print(randWords);

    setState(() {
      words = randWords;
      dropdownValues = downloadedLists;
    });
  }

    Widget _buildDropdownRow(
      String label, String dropdownValue, List<dynamic> dropdownValues) {
    return Row(
      children: [
        Text(label),
        DropdownButton<String>(
          value: dropdownValue,
          onChanged: (String? newValue) {
            setState(() {
              dropdownValue = newValue!;
            });
          },
          items: dropdownValues
              .map((item) =>
                  item['wordListName'].toString().replaceAll("_", " "))
              .toList()
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        actions: [PopupMenuButton(
            icon: Icon(Icons.settings),
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildDropdownRow(
                          "Selected List: ", dropdownValue, dropdownValues),
                    ],
                  ),
                ),
              ];
            },
          ),],
      ),
      body: SafeArea(
          child: RotatableScrollableCards(
        words: words,
        Padding: EdgeInsets.symmetric(
            vertical: screenHeight * 0.04, horizontal: screenWidth * 0.04),
      )),
    );
  }
}