import 'dart:async';

import 'package:brick_breaker/ball.dart';
import 'package:brick_breaker/brick.dart';
import 'package:brick_breaker/coverscreen.dart';
import 'package:brick_breaker/gameoverscreen.dart';
import 'package:brick_breaker/player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

enum direction { UP, DOWN }

class _HomePageState extends State<HomePage> {
  // Ball variable
  double ballX = 0;
  double ballY = 0;
  var ballDirection = direction.DOWN;

  // Brick Variable
  double brickX = 0;
  double brickY = -0.9;
  double brickWidth = 0.4; // out of 2
  double brickHeight = 0.05; // out of 2
  bool brickBroken = false; // out of 2

  // Player variable
  double playerX = -0.2;
  double playerWidth = 0.4; // out of 2

  // Game Settings
  bool hasGameStarted = false;
  bool isGameOver = false;

  void startGame() {
    hasGameStarted = true;
    Timer.periodic(Duration(milliseconds: 10), (timer) {
      // update direction
      updateDirection();
      // move ball
      moveBall();

      // check if player dead
      if (isPlayerDead()) {
        timer.cancel();
        isGameOver = true;
      }

      // check if brick is hit
      checkForBrokenBricks();
    });
  }

  void checkForBrokenBricks() {
    // checks for when ball hits bottom of brick
    if (ballX >= brickX &&
        ballX <= brickX + brickWidth &&
        ballY <= brickY + brickHeight &&
        brickBroken == false) {
      setState(() {
        brickBroken = true;
      });
    }
  }

  // is player dead
  bool isPlayerDead() {
    // player dies if ball reaches the bottom of screen
    if (ballY >= 1) {
      return true;
    }

    return false;
  }

  // move ball
  void moveBall() {
    setState(() {
      if (ballDirection == direction.DOWN) {
        ballY += 0.01;
      } else if (ballDirection == direction.UP) {
        ballY -= 0.01;
      }
    });
  }

  // update the direction of the ball
  void updateDirection() {
    setState(() {
      if (ballY >= 0.9 && ballX >= playerX && ballX <= playerX + playerWidth) {
        ballDirection = direction.UP;
      } else if (ballY <= -0.9) {
        ballDirection = direction.DOWN;
      }
    });
  }

  // Move player left
  void moveLeft() {
    // only move left if moving left does not move player off the screen
    if (!(playerX - 0.2 < -1)) {
      setState(() {
        playerX -= 0.2;
      });
    }
  }

  // Move Player right
  void moveRight() {
    // only move right if moving right does not move player off the screen
    if (!(playerX + playerWidth >= 1)) {
      // setState(() {
      playerX += 0.2;
      // });
    }
  }

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      focusNode: FocusNode(),
      autofocus: true,
      onKey: (event) {
        if (event.isKeyPressed(LogicalKeyboardKey.arrowLeft)) {
          moveLeft();
        } else if (event.isKeyPressed(LogicalKeyboardKey.arrowRight)) {
          moveRight();
        }
      },
      child: GestureDetector(
        onTap: startGame,
        child: Scaffold(
          backgroundColor: Colors.purple[100],
          body: Center(
            child: Stack(
              children: [
                // tap to play
                Coverscreen(hasGameStarted: hasGameStarted),

                // Gamer Over Screen
                GameOverScreen(isGameOver: isGameOver),

                // Ball
                MyBall(ballX: ballX, ballY: ballY),

                // Player
                MyPlayer(
                  playerX: playerX,
                  playerWidth: playerWidth,
                ),

                // Bricks
                Brick(
                  brickX: brickX,
                  brickY: brickY,
                  brickWidth: brickWidth,
                  brickHeight: brickHeight,
                  brickBroken: brickBroken,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
