import 'package:chess/components/piece.dart';
import 'package:chess/value/colors.dart';
import 'package:flutter/material.dart';

class Square extends StatelessWidget {
  final bool iswhite;
  final ChessPiece? piece;
  final bool isslected;
  final bool isvalidmove;
  final void Function()? onTap;
  const Square({
    required this.iswhite,
    required this.piece,
    required this.isslected,
    required this.onTap,
    required this.isvalidmove,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Color? squercolor;
    //if selected ,square is green
    if (isslected) {
      squercolor = Colors.green;
    } else if (isvalidmove) {
      squercolor = const Color.fromARGB(255, 139, 221, 142);
    }
    //otherwise , square is white or black
    else {
      squercolor = iswhite ? backgroundcolor : foregroundcolor;
    }
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: squercolor,
        child: piece != null
            ? Image.asset(
                piece!.imagepath,
                color: piece!.iswhite ? Colors.white : Colors.black,
              )
            : null,
      ),
    );
  }
}
