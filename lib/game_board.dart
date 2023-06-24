import 'package:chess/components/square.dart';
import 'package:chess/helper/helper_methodes.dart';
import 'package:flutter/material.dart';

class GameBoard extends StatelessWidget {
  const GameBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 8,
          ),
          itemCount: 8 * 8,
          itemBuilder: (BuildContext context, int index) {
            return Square(
              iswhite: iswhite(index),
            );
          },
        ),
      ),
    );
  }
}
