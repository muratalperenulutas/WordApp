import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:word_app/controllers/download_controller.dart';

class DownloadIndicator extends StatelessWidget {
  final DownloadTask task;
  final Function onPressed;

  const DownloadIndicator(
      {Key? key, required this.task, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
    switch (task.state.value) {
      case DownloadState.idle:
        return IconButton(icon: Icon(Icons.download), onPressed: () => onPressed());
      case DownloadState.downloading:
        return CircularProgressIndicator();
      case DownloadState.success:
        return Icon(Icons.check, color: Colors.green);
      case DownloadState.failure:
        return Icon(Icons.error, color: Colors.red);
    }
     });
  }
}
