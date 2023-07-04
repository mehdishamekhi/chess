enum ChessPieceTypes {
  pawn,
  bishop,
  knight,
  rook,
  queen,
  king,
}

class ChessPiece {
  final ChessPieceTypes types;
  final bool iswhite;
  final String imagepath;
  ChessPiece({
    required this.types,
    required this.iswhite,
    required this.imagepath,
  });
}
