import 'package:flutter/material.dart';


class RightDragTarget extends StatelessWidget {
  const RightDragTarget({
    super.key,
    required this.onDropped,
  });

  final Function onDropped;

  @override
  Widget build(BuildContext context) {
    return DragTarget<String>(
      onAccept: (data) {
        print("right");
        return onDropped();
      },
      /*onAccept: (data) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Başarılı!'),
            content: Text(data),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('Tamam'),
              ),
            ],
          ),
        );
      },*/
      onWillAccept: (data) {
        return true;
      },
      builder: (context, candidateData, rejectedData) {
        return Container(
          color: candidateData.isNotEmpty
              ? Colors.green.withOpacity(0.5)
              : Colors.red.withOpacity(0.5),
        );
      },
    );
  }
}
