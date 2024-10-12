import 'package:flutter/material.dart';
import 'package:word_app/services/dbService/database_helper.dart';

class MainPageBody extends StatefulWidget {
  const MainPageBody({super.key});

  @override
  State<MainPageBody> createState() => _MainPageBodyState();
}

class _MainPageBodyState extends State<MainPageBody> {
  final TextEditingController _wordController = TextEditingController();
  final dbHelper = DatabaseHelper();
  var meaningText = "";
  List<Map<String, dynamic>> words = [];

  void initState() {
    super.initState();
  }

  Future<void> getWordMeaning(String word) async {
    final result = await dbHelper.getMeaningByWord(word);
    setState(() {
      if (result.isNotEmpty) {
        meaningText = result[0]["meaning2"]+" "+result[0]["meaning1"]+" "+result[0]["meaning3"];
      } else {
        meaningText = 'Değer bulunamadı';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(width * 0.05),
          child: Column(
            children: [
              Container(
                height: height * 0.3,
                width: width,
                color: Colors.grey[900],
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      const Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text("English"),
                            Icon(Icons.arrow_right_alt_sharp),
                            Text("Turkish"),
                          ],
                        ),
                      ),
                      TextField(
                        controller: _wordController,
                        onTapOutside: (event) {
                          getWordMeaning(_wordController.text);
                        },
                      ),

                    ],
                  ),
                ),
              ),Container(
                height: height * 0.25,
                width: width,
                color: Colors.grey[800],
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      Text(meaningText)
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
