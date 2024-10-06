import 'package:flutter/material.dart';
import 'package:word_app/constants/colors.dart';

class FrontSide extends StatelessWidget {
  const FrontSide({
    super.key,
    required this.words,
    required this.index,
    this.padding=EdgeInsets.zero,

  }) ;

  final List<Map<String, dynamic>> words;
  final int index;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:padding,
      child: Container(
          color: cardColors[index % cardColors.length],
          alignment: Alignment.center,
          child: Text(
            words[index]['word'],
            style: TextStyle(color: Colors.white, fontSize: 24),
          ),
        ),
    );
  }
}