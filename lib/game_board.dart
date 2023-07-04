import 'package:chess/components/piece.dart';
import 'package:chess/components/square.dart';
import 'package:chess/helper/helper_methodes.dart';
import 'package:flutter/material.dart';

class GameBoard extends StatefulWidget {
  const GameBoard({super.key});

  @override
  State<GameBoard> createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {
  //2-dimentional list represent the chess board
  //with each position possibly containing a chess piece

  late List<List<ChessPiece?>> board;
  //initialaize the board
  @override
  void initState() {
    super.initState();
    _inintializeboard();
  }

  void _inintializeboard() {
    //initialize the board with nulls, meaning no pieces in those positions
    List<List<ChessPiece?>> newboard = List.generate(
      8,
      (index) => List.generate(
        8,
        (index) => null,
      ),
    );

    //place pawns
    for (int i = 0; i < 8; i++) {
      newboard[1][i] = ChessPiece(
        types: ChessPieceTypes.pawn,
        iswhite: false,
        imagepath: 'assets/images/Pawn.png',
      );
      newboard[6][i] = ChessPiece(
        types: ChessPieceTypes.pawn,
        iswhite: true,
        imagepath: 'assets/images/Pawn.png',
      );
    }

    // place rooks

    // place knights

    // place bishops

    //place queens

    //place kings

    board = newboard;
  }

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
            //get row and col position of this square
            int row = index ~/ 8;
            int column = index % 8;

            return Square(
              iswhite: iswhite(index),
              piece: board[row][column],
            );
          },
        ),
      ),
    );
  }
}
