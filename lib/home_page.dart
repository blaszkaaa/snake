import 'dart:async';

import 'package:flutter/material.dart';
import 'package:snake/blank_pixel.dart';
import 'package:snake/food_pixel.dart';
import 'package:snake/snake_pixel.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //grid dimensions
  int rowSize = 10;
  int totalNumberOfSquares = 100;

  //snake position
  List<int> snakePos = [
    0,
    1,
    2,
  ];

  //food position
  int foodPos = 55;

  //start game
  void startGame() {
    Timer.periodic(Duration(milliseconds: 200), (timer) {
      setState(() {
        //add a new head
        snakePos.add(snakePos.last + 1);
        //remowe the tail
        snakePos.removeAt(0);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          //high scores
          Expanded(
            child: Container(),
          ),
          //game grid
          Expanded(
            flex: 3,
            child: GestureDetector(
              onVerticalDragUpdate: (details) {
                if (details.delta.dy > 0) {
                  print("move down");
                } else if (details.delta.dy < 0) {
                  print("move up");
                }
              },
              onHorizontalDragUpdate: (details) {
                if (details.delta.dx > 0) {
                  print("move right");
                } else if (details.delta.dx < 0) {
                  print("move left");
                }
              },
              child: GridView.builder(
                  itemCount: totalNumberOfSquares,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: rowSize,
                  ),
                  itemBuilder: (context, index) {
                    if (snakePos.contains(index)) {
                      return const SnakePixel();
                    } else if (foodPos == index) {
                      return FoodPixel();
                    } else {
                      return const BlankPixel();
                    }
                  }),
            ),
          ),
          //play button
          Expanded(
            child: Container(
              child: Center(
                child: MaterialButton(
                  child: Text("PLAY"),
                  color: Colors.pink,
                  onPressed: startGame,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
