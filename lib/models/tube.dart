import 'package:flutter/material.dart';

class Tube {
  List<Color> colors;

  Tube(this.colors);

  bool canPourInto(Tube other) {
    if (colors.isEmpty) return false;
    if (other.colors.length >= 4) return false;
    if (other.colors.isEmpty) return true;
    return other.colors.last == colors.last;
  }

  void pourInto(Tube other) {
    while (colors.isNotEmpty && other.colors.length < 4) {
      other.colors.add(colors.removeLast());
    }
  }
}
