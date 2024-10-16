import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:word_app/controllers/app_controller.dart';
import 'package:word_app/models/word_list_model.dart';
import 'package:word_app/services/dbService/database_helper.dart';
import 'package:word_app/widgets/card/rotatable_and_scrollable_cards.dart';

class ScrollableWords extends StatefulWidget {
  const ScrollableWords({super.key});

  @override
  State<ScrollableWords> createState() => _ScrollableWordsState();
}

class _ScrollableWordsState extends State<ScrollableWords> {
  final AppController appController = Get.find<AppController>();
  final dbHelper = DatabaseHelper();
  List<Map<String, dynamic>> words = [];
  List<Map<String, dynamic>> downloadedWordLists = [];

  void initState() {
    super.initState();
    _initDatabase();
  }

  Future<void> _initDatabase() async {
    List<Map<String, dynamic>> randWords =
        await dbHelper.getRandomWordsFromList(
            wordListId: appController.selectedScrollableWordsPageListId.value,
            count: 15);
    List<Map<String, dynamic>> downloadedLists =
        await dbHelper.getDownloadedWordListsInfos();

    //print(randWords);

    setState(() {
      words = randWords;
      downloadedWordLists = downloadedLists;
    });
  }

  void _showDropdownBottomSheet(
      BuildContext context, List<dynamic> downloadedWordLists) {
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
          appController.setScrollableWordsPageListId(
              dropdownItems.isNotEmpty ? dropdownItems.first.value! : "");
        }

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Obx(
                () => ListTile(
                  title: Text("Selected List"),
                  trailing: DropdownButton<String>(
                    value: appController
                            .selectedScrollableWordsPageListId.value.isEmpty
                        ? null
                        : appController.selectedScrollableWordsPageListId.value,
                    onChanged: (String? newValue) {
                      setState(() {
                        appController.setScrollableWordsPageListId(newValue!);
                        _initDatabase();
                      });
                    },
                    items: dropdownItems,
                  ),
                ),
              ),
              Obx(() => ListTile(
                    title: Text('Swipple_Words_Direction'.tr),
                    trailing: DropdownButton<String>(
                      value: appController.isScrollableWordsVertical.value
                          ? 'Vertical'
                          : 'Horizontal',
                      onChanged: (String? newValue) {
                        appController.toggleSwippleDirection();
                      },
                      items: <String>['Horizontal', 'Vertical']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value.tr),
                        );
                      }).toList(),
                    ),
                  )),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              _showDropdownBottomSheet(context, downloadedWordLists);
            },
          ),
        ],
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
