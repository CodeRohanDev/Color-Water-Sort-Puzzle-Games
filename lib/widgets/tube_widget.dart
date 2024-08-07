import 'package:flutter/material.dart';
import '../models/tube.dart';

class TubeWidget extends StatelessWidget {
  final Tube tube;
  final VoidCallback onTap;

  TubeWidget({required this.tube, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: tube.colors.map((color) => Container(
          height: 20,
          width: 60,
          color: color,
          margin: EdgeInsets.symmetric(vertical: 2),
        )).toList(),
      ),
    );
  }
}
