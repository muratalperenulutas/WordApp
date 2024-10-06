import 'package:flutter/material.dart';
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

  int count = 0;
  List<Map<String, dynamic>> dropdownValues=[];
  String dropdownValue = 'Oxford Lists A1';

  void initState() {
    super.initState();
    _initDatabase();
  }

  Future<void> _initDatabase() async {
    List<Map<String, dynamic>> randWords = await dbHelper
        .getRandomWordsFromList(wordListName: "Oxford_Lists_B2", count: 5);
    List<Map<String, dynamic>> downloadedLists=await dbHelper.getDownloadedWordListsInfos();
    //print(randWords);

    setState(() {
      words = randWords;
      dropdownValues=downloadedLists;
    });
  }

  void _increaseIndex() {
    if (index < words.length) {
      setState(() {
        index++;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        actions: [
          PopupMenuButton(
            icon: Icon(Icons.settings),
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text('Word Count: '),
                          IconButton(
                              onPressed: () {
                                setState(() {
                                  count--;
                                });
                              },
                              icon: Icon(Icons.remove)),
                          Text(count.toString()),
                          IconButton(
                              onPressed: () {
                                setState(() {
                                  count++;
                                });
                              },
                              icon: Icon(Icons.add))
                        ],
                      ),
                      Row(children: [
                        Text("Selected List: "),
                        
                        DropdownButton<String>(
                          value: dropdownValue,
                          onChanged: (String? newValue) {
                            setState(() {
                              dropdownValue = newValue!;
                            });
                          },   
                          items: dropdownValues.map((item) => item['wordListName'].toString().replaceAll("_"," ")).toList()
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ]),
                      
                      Row(
                        children: [
                          Text("Remember count:"),
                          IconButton(
                              onPressed: () {
                                setState(() {
                                  count--;
                                });
                              },
                              icon: Icon(Icons.remove)),
                          Text(count.toString()),
                          IconButton(
                              onPressed: () {
                                setState(() {
                                  count++;
                                });
                              },
                              icon: Icon(Icons.add))
                        ],
                      )
                    ],
                  ),
                ),
              ];
            },
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
