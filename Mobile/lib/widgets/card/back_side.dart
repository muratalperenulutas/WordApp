import 'package:flutter/material.dart';

class BackSide extends StatelessWidget {
  const BackSide({
    super.key,
    required this.words,
    required this.index,
    this.padding=EdgeInsets.zero
  });


  final List<Map<String, dynamic>> words;
  final int index;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Padding(padding: padding,
      child: Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()..scale(-1.0, 1.0, 1.0),
          child: Container(
              color: Colors.blue[300],
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    words[index]['meaning1'],
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  ),
                  Text(
                    words[index]['meaning2'],
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  ),
                  Text(
                    words[index]['meaning3'],
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  ),
                ],
              )),
        ),
    );
  }
}


