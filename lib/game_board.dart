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

  //the currently selected piece on the chessboard
  // if no piece is selcted , this is null
  ChessPiece? selectedpiece;

  //The row index of the selected piece
  // defualt value -1 indicated no piece is currently selected
  int selectedrow = -1;

  //The column index of the selected piece
  // defualt value -1 indicated no piece is currently selected
  int selcetedcolumn = -1;

  // A list of valid moves for the currently selected piece
  //each move is represented as a list with 2 elements: row and column
  List<List<int>> validmoves = [];
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
    newboard[0][0] = ChessPiece(
      types: ChessPieceTypes.rook,
      iswhite: false,
      imagepath: 'assets/images/Rook.png',
    );
    newboard[0][7] = ChessPiece(
      types: ChessPieceTypes.rook,
      iswhite: false,
      imagepath: 'assets/images/Rook.png',
    );
    newboard[7][0] = ChessPiece(
      types: ChessPieceTypes.rook,
      iswhite: true,
      imagepath: 'assets/images/Rook.png',
    );
    newboard[7][7] = ChessPiece(
      types: ChessPieceTypes.rook,
      iswhite: true,
      imagepath: 'assets/images/Rook.png',
    );

    // place knights
    newboard[0][1] = ChessPiece(
      types: ChessPieceTypes.knight,
      iswhite: false,
      imagepath: 'assets/images/Knight.png',
    );
    newboard[0][6] = ChessPiece(
      types: ChessPieceTypes.knight,
      iswhite: false,
      imagepath: 'assets/images/Knight.png',
    );
    newboard[7][1] = ChessPiece(
      types: ChessPieceTypes.knight,
      iswhite: true,
      imagepath: 'assets/images/Knight.png',
    );
    newboard[7][6] = ChessPiece(
      types: ChessPieceTypes.knight,
      iswhite: true,
      imagepath: 'assets/images/Knight.png',
    );

    // place bishops
    newboard[0][2] = ChessPiece(
      types: ChessPieceTypes.bishop,
      iswhite: false,
      imagepath: 'assets/images/Bishop.png',
    );
    newboard[0][5] = ChessPiece(
      types: ChessPieceTypes.bishop,
      iswhite: false,
      imagepath: 'assets/images/Bishop.png',
    );

    newboard[7][5] = ChessPiece(
      types: ChessPieceTypes.bishop,
      iswhite: true,
      imagepath: 'assets/images/Bishop.png',
    );
    newboard[7][2] = ChessPiece(
      types: ChessPieceTypes.bishop,
      iswhite: true,
      imagepath: 'assets/images/Bishop.png',
    );

    //place queens
    newboard[0][3] = ChessPiece(
      types: ChessPieceTypes.queen,
      iswhite: false,
      imagepath: 'assets/images/Queen.png',
    );
    newboard[7][4] = ChessPiece(
      types: ChessPieceTypes.queen,
      iswhite: true,
      imagepath: 'assets/images/Queen.png',
    );

    //place kings
    newboard[0][4] = ChessPiece(
      types: ChessPieceTypes.king,
      iswhite: false,
      imagepath: 'assets/images/King.png',
    );
    newboard[7][3] = ChessPiece(
      types: ChessPieceTypes.king,
      iswhite: true,
      imagepath: 'assets/images/King.png',
    );
    board = newboard;
  }

  // User slected a piece
  void pieceselected(int row, int column) {
    setState(() {
      //selected a piece if there is a piese in that position
      if (board[row][column] != null) {
        selectedpiece = board[row][column];
        selectedrow = row;
        selcetedcolumn = column;
      }

      //if a piece is selected, calculate it's valid move
      validmoves =
          calulateRawValidMoves(selectedrow, selcetedcolumn, selectedpiece);
    });
  }

  //caclulate raw valid moves
  List<List<int>> calulateRawValidMoves(
      int row, int column, ChessPiece? piece) {
    List<List<int>> candidateMoves = [];

    //different directions based on their color
    int direction = piece!.iswhite ? -1 : 1;

    switch (piece.types) {
      case ChessPieceTypes.pawn:
        //pawns can move forward if the square in not occupied
        if (isinboard(row + direction, column) &&
            board[row + direction][column] == null) {
          candidateMoves.add([row + direction, column]);
        }
        // pawns can move 2 squares forward if they are at their initial position
        if ((row == 1 && !piece.iswhite) || (row == 6 && piece.iswhite)) {
          if (isinboard(row + 2 * direction, column) &&
              board[row + 2 * direction][column] == null &&
              board[row + direction][column] == null) {
            candidateMoves.add([row + 2 * direction, column]);
          }
        }
        // pawns can kill diagonally
        if (isinboard(row + direction, column - 1) &&
            board[row + direction][column - 1] != null &&
            board[row + direction][column - 1]!.iswhite) {
          candidateMoves.add([row + direction, column - 1]);
        }
        if (isinboard(row + direction, column + 1) &&
            board[row + direction][column + 1] != null &&
            board[row + direction][column + 1]!.iswhite) {
          candidateMoves.add([row + direction, column + 1]);
        }
        break;

      case ChessPieceTypes.rook:
        //horizontal and vertical directions
        var directions = [
          [-1, 0], //up
          [1, 0], //down
          [0, -1], //left
          [0, 1], //right
        ];
        for (var direction in directions) {
          var i = 1;
          while (true) {
            var newrow = row + i * direction[0];
            var newcol = column + i * direction[1];
            if (!isinboard(newrow, newcol)) {
              break;
            }
            if (board[newrow][newcol] != null) {
              if (board[newrow][newcol]!.iswhite != piece.iswhite) {
                candidateMoves.add([newrow, newcol]); //kill
              }
              break; //blocked
            }
            candidateMoves.add([newrow, newcol]);
            i++;
          }
        }
        break;
      case ChessPieceTypes.knight:
        //all eight possible L shapes the knight can move
        var KnightMove = [
          [-2, -1], //up 2 left 1
          [-2, 1], //up 2 right 1
          [-1, -2], //up 1 left 2
          [-1, 2], //up 1 right 2
          [1, -2], //down 1 left 2
          [1, 2], //down 1 right 2
          [2, -1], //down 2 left 1
          [2, 1], //down 2 right 1
        ];
        for (var move in KnightMove) {
          var newrow = row + move[0];
          var newcol = column + move[1];
          if (!isinboard(newrow, newcol)) {
            continue;
          }
          if (board[newrow][newcol] != null) {
            if (board[newrow][newcol]!.iswhite != piece.iswhite) {
              candidateMoves.add([newrow, newcol]); //capture
            }
            continue; // blocked
          }
          candidateMoves.add([newrow, newcol]);
        }

        break;
      case ChessPieceTypes.bishop:
        break;
      case ChessPieceTypes.queen:
        break;
      case ChessPieceTypes.king:
        break;
    }
    return candidateMoves;
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

            //check if this square is selected
            bool isselct = selectedrow == row && selcetedcolumn == column;
            //check if this square is a valid move
            bool isvalidmove = false;
            for (var position in validmoves) {
              //compare row and column
              if (position[0] == row && position[1] == column) {
                isvalidmove = true;
              }
            }

            return Square(
              iswhite: iswhite(index),
              piece: board[row][column],
              isslected: isselct,
              isvalidmove: isvalidmove,
              onTap: () => pieceselected(row, column),
            );
          },
        ),
      ),
    );
  }
}
