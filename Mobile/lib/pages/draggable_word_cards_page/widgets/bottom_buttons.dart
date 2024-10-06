import 'package:flutter/material.dart';


class BottomButtons extends StatelessWidget {
  const BottomButtons({
    super.key,
    required this.onTap,
  });

  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.orange,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                InkWell(
                  onTap: () {
                    print("forgot");
                    return onTap();
                  },
                  child: const Column(
                    children: [
                      Icon(Icons.turn_left_outlined, size: 40),
                      SizedBox(height: 8),
                      Text("Forgot"),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(width: 40),
            Column(
              children: [
                InkWell(
                  onTap: () {
                    print("Remember");
                    return onTap();
                  },
                  child: const Column(
                    children: [
                      Icon(Icons.turn_right_outlined, size: 40),
                      SizedBox(height: 8),
                      Text("Remember"),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}
