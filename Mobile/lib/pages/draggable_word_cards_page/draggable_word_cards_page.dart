import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:word_app/controllers/app_controller.dart';
import 'package:word_app/models/word_list_model.dart';
import 'package:word_app/pages/draggable_word_cards_page/widgets/bottom_buttons.dart';
import 'package:word_app/services/dbService/database_helper.dart';
import 'package:word_app/widgets/card/rotatable_and_draggable_cards.dart';
import 'package:word_app/pages/draggable_word_cards_page/widgets/left_drag_target.dart';
import 'package:word_app/pages/draggable_word_cards_page/widgets/right_drag_target.dart';

class DraggableWordCards extends StatefulWidget {
  const DraggableWordCards({super.key});

  @override
  State<DraggableWordCards> createState() => _DraggableWordCardsState();
}

class _DraggableWordCardsState extends State<DraggableWordCards> {
  final dbHelper = DatabaseHelper();
  List<Map<String, dynamic>> words = [];
  int index = 0;
  final AppController appController = Get.find<AppController>();
  int count = 0;
  List<Map<String, dynamic>> downloadedWordLists = [];


  void initState() {
    super.initState();
    _initDatabase();
  }

  Future<void> _initDatabase() async {
    List<Map<String, dynamic>> randWords = await dbHelper
        .getRandomWordsFromList(wordListId: appController.selectedDraggableWordsPageListId.value, count: 5);
    List<Map<String, dynamic>> downloadedLists =
        await dbHelper.getDownloadedWordListsInfos();
    //print(randWords);

    setState(() {
      words = randWords;
      downloadedWordLists = downloadedLists;
    });
  }

  Widget _buildRowWithCounter(int count) {
    return Row(
      mainAxisSize: MainAxisSize.min ,
      children: [
        IconButton(
          onPressed: () {
            setState(() {
              count--;
            });
          },
          icon: Icon(Icons.remove),
        ),
        Text(count.toString(),style: TextStyle(fontSize: 17),),
        IconButton(
          onPressed: () {
            setState(() {
              count++;
            });
          },
          icon: Icon(Icons.add),
        ),
      ],
    );
  }



  void _increaseIndex() {
    if (index < words.length) {
      setState(() {
        index++;
      });
    }
  }
  void _showDropdownBottomSheet(BuildContext context,List<dynamic> downloadedWordLists) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {

      List<DropdownMenuItem<String>> dropdownItems = downloadedWordLists
            .map((json) => word_list_model.fromJson(json))
            .map<DropdownMenuItem<String>>((wordListModel) {
          return DropdownMenuItem<String>(
            value: wordListModel.wordListId,
            child: Text(wordListModel.wordListName),
          );
        }).toList();

        if (!dropdownItems.any((item) =>
            item.value ==
            appController.selectedScrollableWordsPageListId.value)) {
          appController.setDraggableWordsPageListId(
              dropdownItems.isNotEmpty ? dropdownItems.first.value! : "");
        }

      
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text("Word count:"),
                trailing: _buildRowWithCounter(3),
              ),

              ListTile(
                title: Text("Remember count:"),
                trailing: _buildRowWithCounter(5)
              ),
              
              Obx(()=>ListTile(
                title: Text("Selected List"),
                trailing: DropdownButton<String>(
                  value: appController.selectedDraggableWordsPageListId.value.isEmpty ? null : appController.selectedDraggableWordsPageListId.value,
                  onChanged: (String? newValue) {
                    setState(() {
                      appController.setDraggableWordsPageListId(newValue!);
                      _initDatabase();
                    });
                  },
                  items:dropdownItems
                ),

              ),)
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: (){_showDropdownBottomSheet(context,downloadedWordLists);},
          ),
        ],
        title: Text('Draggable Word Cards'),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 7,
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: LeftDragTarget(onDropped: () => _increaseIndex()),
                ),
                Expanded(
                  flex: 3,
                  child: buildDraggableWidget(context, height * 0.45, width),
                ),
                Expanded(
                  flex: 1,
                  child: RightDragTarget(
                    onDropped: () => _increaseIndex(),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
              flex: 1,
              child: BottomButtons(
                onTap: () => _increaseIndex(),
              )),
        ],
      ),
    );
  }

  Widget buildDraggableWidget(
      BuildContext context, double screenHeight, double screenWidth) {
    return Draggable<String>(
      data: index < words.length ? words[index]["id"].toString() : "0",
      child: Container(
        height: screenHeight,
        //color: Colors.blue,
        child: RotatableDraggableCards(
          words: words,
          index: index,
        ),
      ),
      feedback: Container(
        height: screenHeight,
        width: screenWidth * 0.6,
        color: Colors.blue.withOpacity(0.5),
        child: Center(
          child: Scaffold(
              body: RotatableDraggableCards(
            words: words,
            index: index,
          )),
        ),
      ),
      childWhenDragging: Container(
        height: screenHeight,
        //color: Colors.grey,
        child: RotatableDraggableCards(
          words: words,
          index: index + 1,
        ),
      ),
    );
  }
}
