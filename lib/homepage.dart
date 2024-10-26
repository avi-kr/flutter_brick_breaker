import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Ball variable
  double ballX = 0;
  double ballY = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[100],
      body: Center(
        child: Stack(
          children: [
            // Ball
            Container(
              alignment: Alignment(ballX, ballY),
              child: Container(
                height: 15,
                width: 15,
                decoration: BoxDecoration(
                  color: Colors.purple,
                  shape: BoxShape.circle
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
