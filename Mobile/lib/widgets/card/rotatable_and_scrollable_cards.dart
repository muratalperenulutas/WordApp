import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:word_app/controllers/app_controller.dart';
import 'package:word_app/widgets/card/back_side.dart';
import 'package:word_app/widgets/card/card_finish.dart';
import 'package:word_app/widgets/card/front_side.dart';

class RotatableScrollableCards extends StatefulWidget {
  final List<Map<String, dynamic>> words;
  final int index;
  final EdgeInsetsGeometry Padding;
  RotatableScrollableCards(
      { required this.words, this.index = 0,this.Padding=EdgeInsets.zero});

  @override
  _RotatableScrollableCardsState createState() =>
      _RotatableScrollableCardsState();
}

class _RotatableScrollableCardsState extends State<RotatableScrollableCards>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _isFront = true;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  void _flipCard() {
    setState(() {
      if (_isFront) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
      _isFront = !_isFront;
    });
  }

  @override
  Widget build(BuildContext context) {
    final AppController appController = Get.find<AppController>();
    if (widget.words.isEmpty) {
      return Center(child: CircularProgressIndicator());
    } else {
      return Obx(() {
              return PageView.builder(
                scrollDirection: appController.isScrollableWordsVertical.value
                    ? Axis.vertical
                    : Axis.horizontal,
                onPageChanged: (index) {
                  if (!_isFront) {
                    _flipCard();
                  }
                },
                itemCount: widget.words.length,
                /*physics: _isFront
                    ? AlwaysScrollableScrollPhysics()
                    : NeverScrollableScrollPhysics(),*/
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: _flipCard,
                    child: AnimatedBuilder(
                      animation: _animation,
                      builder: (context, child) {
                        //final isFront = _isFront;
                        final angle = _animation.value * 3.14;
                        //print(angle);
                        //print(isFront);

                        final transform = Matrix4.identity()
                          ..setEntry(3, 2, 0.001)
                          ..rotateY(angle);

                        return Transform(
                            transform: transform,
                            alignment: Alignment.center,
                            child: _controller.value > 0.5
                                ? BackSide(words: widget.words, index: index,padding: widget.Padding)
                                : FrontSide(words: widget.words, index: index,padding: widget.Padding,));
                      },
                    ),
                  );
                },
              );
            });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
