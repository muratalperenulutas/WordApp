import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:word_app/controllers/app_controller.dart';
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
  List<Map<String, dynamic>> dropdownValues = [];


  void initState() {
    super.initState();
    _initDatabase();
  }

  Future<void> _initDatabase() async {
    List<Map<String, dynamic>> randWords = await dbHelper.getRandomWordsFromList(
        wordListName: appController.selectedScrollableWordsPageList.value.replaceAll(" ", "_"), count: 15);
        List<Map<String, dynamic>> downloadedLists =
        await dbHelper.getDownloadedWordListsInfos();
        print(appController.selectedScrollableWordsPageList.value);

    //print(randWords);

    setState(() {
      words = randWords;
      dropdownValues = downloadedLists;
    });
  }

  void _showDropdownBottomSheet(BuildContext context,
   List<dynamic> dropdownValues) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      List<DropdownMenuItem<String>> dropdownItems = dropdownValues
          .map((item) =>
              item['wordListName'].toString().replaceAll("_", " "))
          .toList()
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList();

      if (!dropdownItems.any((item) => item.value == appController.selectedScrollableWordsPageList.value.replaceAll("_", " "))) {
        appController.setScrollableWordsPageList(dropdownItems.isNotEmpty ? dropdownItems.first.value! : "");
      }

      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Obx(()=>
            ListTile(
              title: Text("Selected List"),
              trailing: DropdownButton<String>(
                value: appController.selectedScrollableWordsPageList.value.isEmpty ? null : appController.selectedScrollableWordsPageList.value.replaceAll("_", " "),
                onChanged: (String? newValue) {
                  setState(() {
                    appController.setScrollableWordsPageList(newValue!);
                    _initDatabase();
                  });
                },
                items: dropdownItems,
              ),
            ),),
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
        actions: [IconButton(
            icon: Icon(Icons.settings),
            onPressed: (){_showDropdownBottomSheet(context,dropdownValues);},
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