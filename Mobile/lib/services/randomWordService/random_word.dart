
/*
import 'package:word_app/services/dbService/database_helper.dart';

class RandomWordService {
  static final RandomWordService _instance = RandomWordService._internal();
  RandomWordService._internal();

  factory RandomWordService() {
    return _instance;
  }
  final Map<String, List<Map<String, dynamic>>> _wordCache = {};

  Future<void> _loadWords(String wordListName, int count) async {
    print(wordListName + count.toString());
    if (_wordCache[wordListName] == null ||
        _wordCache[wordListName]!.length < 50) {
      final List<Map<String, dynamic>> maps = await DatabaseHelper()
          .getRandomWordsFromList(wordListId: wordListName, count: count);
      //print(maps);
      _wordCache[wordListName] ??=[];
      _wordCache[wordListName]!.addAll(maps);
    }
  }

  Future<void> initialize(int count) async {
    final List<Map<String, dynamic>> wordLists =
        await DatabaseHelper().getDownloadedWordListsInfos();
    for (var wordList in wordLists) {
      String wordListName = wordList['wordListName'];
      await _loadWords(wordListName, count);
    }
  }

  Future<List<Map<String, dynamic>>> getRandomWords(
      int count, String wordListName) async {
    await _loadWords(wordListName, count);
    final List<Map<String, dynamic>> words = _wordCache[wordListName]!;
    List<Map<String, dynamic>> result = [];
    //print(words);
    for (int i = 0; i < count && words.isNotEmpty; i++) {
      result.add(words.removeAt(0));
    }
    print(result);

    return result;
  }
}
*/
