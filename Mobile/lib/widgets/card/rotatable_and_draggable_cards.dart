import 'package:flutter/material.dart';
import 'package:word_app/widgets/card/back_side.dart';
import 'package:word_app/widgets/card/card_finish.dart';
import 'package:word_app/widgets/card/front_side.dart';

class RotatableDraggableCards extends StatefulWidget {
  final List<Map<String, dynamic>> words;
  final int index;
  RotatableDraggableCards(
      {required this.words, this.index = 0});

  @override
  _RotatableDraggableCardsState createState() =>
      _RotatableDraggableCardsState();
}

class _RotatableDraggableCardsState extends State<RotatableDraggableCards>
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
    
    if (widget.words.isEmpty) {
      return Center(child: CircularProgressIndicator());
    } else {
      return widget.index<(widget.words.length)?
          Stack(alignment: Alignment.center, children: [
            widget.index<(widget.words.length-1)?
              FrontSide(words: widget.words, index: widget.index+1):CardFinish(cardNumber: widget.words.length,),
              GestureDetector(
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
                        child: _controller.value>0.5?
                            BackSide(words: widget.words, index: widget.index)
                            :FrontSide(words: widget.words, index: widget.index)
                          
                        );
                  },
                ),
              ),
            ]):CardFinish(cardNumber:widget.words.length);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
