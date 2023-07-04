import 'package:chess/components/piece.dart';
import 'package:chess/value/colors.dart';
import 'package:flutter/material.dart';

class Square extends StatelessWidget {
  final bool iswhite;
  final ChessPiece? piece;
  const Square({
    required this.iswhite,
    required this.piece,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: iswhite ? backgroundcolor : foregroundcolor,
      child: piece != null
          ? Image.asset(
              piece!.imagepath,
              color: piece!.iswhite ? Colors.white : Colors.black,
            )
          : null,
    );
  }
}
