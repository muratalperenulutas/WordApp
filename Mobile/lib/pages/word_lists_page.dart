import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:word_app/controllers/download_controller.dart';
import 'package:word_app/services/clientService/websocket.dart';
import 'package:word_app/services/dbService/database_helper.dart';
import 'package:word_app/pages/word_list_page.dart';
import 'package:word_app/widgets/download_progress_indicator.dart';

class MyWordListsPage extends StatefulWidget {
  @override
  _MyWordListsPageState createState() => _MyWordListsPageState();
}

class _MyWordListsPageState extends State<MyWordListsPage> {
  final DownloadController downloadController = Get.put(DownloadController());
  final dbHelper = DatabaseHelper();
  late WebSocketClient webSocketClient;
  List<Map<String, dynamic>> downloadedWordLists = [];
  List<Map<String, dynamic>> downloadableWordLists = [];

  @override
  void initState() {
    super.initState();
    webSocketClient = WebSocketClient(onUiUpdate: _initDatabase);
    _initDatabase();
  }

  Future<void> _initDatabase() async {
    List<Map<String, dynamic>> getDownloadedWordLists =
        await dbHelper.getDownloadedWordListsInfos();
    List<Map<String, dynamic>> getDownloadableWordLists =
        await dbHelper.getDownloadableWordListsInfos();
    /*
    print(getDownloadableWordLists);
    print(getDownloadableWordLists.length);
    print(getDownloadedWordLists);
    print(getDownloadedWordLists.length);
    */
    setState(() {
      downloadableWordLists = getDownloadableWordLists;
      downloadedWordLists = getDownloadedWordLists;
      //print(lists);
    });
  }

  void _showDownloadableLists() {
    downloadController.resetDownloads();
    if (downloadableWordLists.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("No downloadable lists available!")),
      );
    } else {
      showModalBottomSheet(
        context: context,
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: downloadableWordLists.map((list) {
              downloadController.addTask(list['wordListName']);
              return ListTile(
                subtitle: Text(
                  list['wordCount'].toString() + " words",
                ),
                title: Text(list['wordListName'].replaceAll("_", " ")),
                trailing:DownloadIndicator(
                    task: downloadController.tasks.firstWhere((task) => task.id == list['wordListName']),
                    onPressed: () {
                      downloadController.startDownload(list['wordListName']);
                      webSocketClient.GET_WORDS_FROM_LIST(list['wordListName']);
                    },
                ));
              
            }).toList(),
          );
        },
      );
    }
  }

  void _confirmDeleteList(int index) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 5),
              Text(
                'Delete List?',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                'Are you sure you want to delete the list "${downloadedWordLists[index]['wordListName'].replaceAll("_", " ")}"?',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Cancel'),
                  ),
                  SizedBox(width: 10),
                  TextButton(
                    onPressed: () async {
                      //await dbHelper.deleteWordList(lists[index]['dbName']);
                      setState(() {
                        downloadedWordLists.removeAt(index);
                      });
                      Navigator.pop(context);
                    },
                    child: Text('Delete'),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    ); /*
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Delete List'),
          content: Text(
              'Are you sure you want to delete the list "${lists[index]['wordListName']}"?'),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Delete'),
              onPressed: () async {
              //await dbHelper.deleteWordList(lists[index]['dbName']);
                setState(() {
                  lists.removeAt(index);
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );*/
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Word Lists'),
        actions: [
          IconButton(
            icon: Icon(Icons.download),
            onPressed: () async {
              webSocketClient.GET_WORD_LISTS_INFOS();
            },
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () async {
              dbHelper.deleteAllWords();
            },
          ),
        ],
      ),
      body: downloadedWordLists.length == 0
          ? Center(
              child: Text("There is no list yet."),
            )
          : ListView.builder(
              itemCount: downloadedWordLists.length,
              itemBuilder: (context, index) {
                return ListTile(
                  subtitle: Text(
                    downloadedWordLists[index]['wordCount'].toString() +
                        " words",
                  ),
                  title: Text(downloadedWordLists[index]['wordListName']
                      .replaceAll("_", " ")),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MyWordListPage(
                          wordListName: downloadedWordLists[index]
                              ['wordListName'],
                        ),
                      ),
                    );
                  },
                  onLongPress: () {
                    print("long press");
                    _confirmDeleteList(index);
                  },
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: _showDownloadableLists,
      ),
    );
  }
}
