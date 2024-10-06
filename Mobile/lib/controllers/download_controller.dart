import 'package:get/get.dart';

enum DownloadState { idle, downloading, success, failure }

class DownloadTask {
  final String id;
  var state = DownloadState.idle.obs;
  var progress = 0.0.obs;

  DownloadTask(this.id);
}

class DownloadController extends GetxController {
  var tasks = <DownloadTask>[].obs; 

  void addTask(String id){
  final task = DownloadTask(id);
  tasks.add(task);
  }

  void startDownload(String id) {
    final task = tasks.firstWhere((task) => task.id == id);
    task.state.value = DownloadState.downloading;
    task.progress.value = 0.0;
  }

  void updateProgress(String id, double value) {
    final task = tasks.firstWhere((task) => task.id == id);
    task.progress.value = value;
  }

  void downloadSuccess(String id) {
    final task = tasks.firstWhere((task) => task.id == id);
    task.state.value = DownloadState.success;
    task.progress.value = 1.0;
  }

  void downloadFailure(String id) {
    final task = tasks.firstWhere((task) => task.id == id);
    task.state.value = DownloadState.failure;
    task.progress.value = 0.0;
  }

  void resetDownloads() {
    tasks.clear();
  }
}
