import 'package:get/get.dart';

enum DownloadState { idle, downloading, success, failure }

class DownloadController extends GetxController {
  var downloadState = DownloadState.idle.obs;
  var progress = 0.0.obs;

  void startDownload() {
    downloadState.value = DownloadState.downloading;
    progress.value = 0.0;
  }

  void updateProgress(double value) {
    progress.value = value;
  }

  void downloadSuccess() {
    downloadState.value = DownloadState.success;
    progress.value = 1.0;
  }

  void downloadFailure() {
    downloadState.value = DownloadState.failure;
    progress.value = 0.0;
  }
}
