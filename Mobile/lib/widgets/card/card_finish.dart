import 'package:flutter/material.dart';
class CardFinish extends StatelessWidget {
  const CardFinish({super.key,required this.cardNumber});
  final int cardNumber;

  @override
  Widget build(BuildContext context) {
    return Container(alignment: Alignment.center,child: Text("Congratulations! You finished ${cardNumber} card."));
  }
}
