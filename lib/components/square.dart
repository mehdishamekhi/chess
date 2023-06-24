import 'package:flutter/material.dart';

class Square extends StatelessWidget {
  final bool iswhite;
  const Square({required this.iswhite, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: iswhite ? Colors.grey : const Color.fromARGB(255, 31, 31, 31),
    );
  }
}
