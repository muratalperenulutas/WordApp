import 'dart:convert';
import 'dart:ffi';
import 'package:get/get.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:web_socket_channel/io.dart';
import 'package:word_app/constants/server_url.dart';
import 'package:word_app/controllers/download_controller.dart';
import 'package:word_app/models/word_list_model.dart';
import 'package:word_app/services/dbService/database_helper.dart';
import 'package:word_app/models/word.dart';

class WebSocketClient {
  final IOWebSocketChannel channel;
  final DatabaseHelper _databaseHelper = DatabaseHelper();
  final Function onUiUpdate;
  final DownloadController downloadController = Get.find<DownloadController>();

  WebSocketClient({required this.onUiUpdate})
      : channel = IOWebSocketChannel.connect(Uri.parse(serverUrl)) {
    channel.stream.listen(
      (message) {
        _handleMessage(message);
      },
    );
  }

  void GET_WORD_LISTS_INFOS() {
    String jsonMessage = jsonEncode({'command': 'GET_WORD_LISTS_INFOS'});
    channel.sink.add(jsonMessage);
  }

  void GET_WORDS_FROM_LIST(String listName) {
    String jsonMessage = jsonEncode({
      'command': 'GET_WORDS_FROM_LIST',
      'params': {"listName": listName}
    });
    channel.sink.add(jsonMessage);
  }

  Future<void> _handleMessage(dynamic message) async {
    final jsonData = jsonDecode(message);
    print(jsonData);

    if (jsonData['command'] == 'WORDS_FROM_LIST') {
      String wordListName = jsonData["data"]["listName"];
      int wordCount = jsonData["data"]['wordCount'];
      final _isWordListsAlreadyExist =
          await _databaseHelper.isWordListsAlreadyDownloaded(wordListName);
      if (_isWordListsAlreadyExist == 0) {
        for (int i = 0; i < jsonData['data']['words'].length; i++) {
          word_model model = word_model.fromJson(jsonData['data']['words'][i]);
          _databaseHelper.insertWord(
              wordListName: wordListName, wordModel: model);
          downloadController.updateProgress(wordListName,(i + 1) / wordCount);
        }
      }
      if (wordCount == jsonData['data']['words'].length) {
        _databaseHelper.updateWordListAsDownloaded(wordListName: wordListName);
        onUiUpdate();
        downloadController.downloadSuccess(wordListName);
      } else {
        //delete unmatched lists words
        print("Words count not match!");
      }
    } else if (jsonData['command'] == 'WORD_LISTS') {
    
      for (var listData in jsonData['data']) {
        bool result=await _databaseHelper.isWordListsInfoAlreadyExist(listData['listName']);
        if(result){
          print(result);
        word_list_model wordListModel = word_list_model.fromJson(listData);
        _databaseHelper.insertWordListInfo(wordListModel: wordListModel);
        }
      }
      onUiUpdate();
    }
  }

  void close() {
    channel.sink.close();
  }
}


//DatabaseHelper.isWordListNameExist