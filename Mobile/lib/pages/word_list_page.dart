import 'package:flutter/material.dart';
import 'package:word_app/services/dbService/database_helper.dart';

class MyWordListPage extends StatefulWidget {
  final String wordListName;
  MyWordListPage({required this.wordListName});

  @override
  _MyWordListPageState createState() => _MyWordListPageState();
}

class _MyWordListPageState extends State<MyWordListPage> {
  final dbHelper = DatabaseHelper();
  List<Map<String, dynamic>> words = [];

  @override
  void initState() {
    super.initState();
    _initDatabase();
  }

  Future<void> _initDatabase() async {

    List<Map<String, dynamic>> allWords = await dbHelper.getAllListsWords(widget.wordListName);
    
    //print(allWords.length);
    setState(() {
       words = allWords;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.wordListName),
      ),
      body: ListView.builder(
        itemCount: words.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(words[index]['word']),
            subtitle: Text(words[index]['meaning1']+"    "+words[index]['meaning2']+"    "+words[index]['meaning3'] ),
          );
        },
      )
    );
  }
}
