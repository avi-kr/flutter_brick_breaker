import 'package:flutter/material.dart';

class Coverscreen extends StatelessWidget {
  final hasGameStarted;

  Coverscreen({required this.hasGameStarted});

  @override
  Widget build(BuildContext context) {
    return hasGameStarted
        ? Container()
        : Container(
            alignment: Alignment(0, -0.2),
            child: Text(
              'tap to play',
              style: TextStyle(
                color: Colors.purple[400],
              ),
            ),
          );
  }
}
