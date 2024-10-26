import 'package:flutter/material.dart';

class Brick extends StatelessWidget {
  final brickX;
  final brickY;
  final brickWidth; // out of 2
  final brickHeight; // out of 2
  final bool brickBroken;

  Brick(
      {this.brickX,
      this.brickY,
      this.brickWidth,
      this.brickHeight,
      required this.brickBroken});

  @override
  Widget build(BuildContext context) {
    return brickBroken
        ? Container()
        : Container(
            alignment: Alignment(brickX, brickY),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Container(
                height: MediaQuery.of(context).size.height * brickHeight / 2,
                width: MediaQuery.of(context).size.width * brickWidth / 2,
                color: Colors.deepPurple,
              ),
            ),
          );
  }
}
