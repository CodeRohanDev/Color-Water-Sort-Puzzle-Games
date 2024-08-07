import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/tube.dart';

class GameProvider extends ChangeNotifier {
  List<Tube> tubes = [];
  List<List<Tube>> history = [];

  GameProvider() {
    loadGame();
  }

  void saveState() {
    history.add(List<Tube>.from(tubes.map((tube) => Tube(List<Color>.from(tube.colors)))));
  }

  void undo() {
    if (history.isNotEmpty) {
      tubes = history.removeLast();
      notifyListeners();
    }
  }

  void resetGame() {
    tubes = [
      Tube([Colors.red, Colors.red, Colors.green, Colors.green]),
      Tube([Colors.blue, Colors.blue, Colors.yellow, Colors.yellow]),
      Tube([]),
      Tube([]),
    ];
    saveGame();
    notifyListeners();
  }

  void pour(int fromIndex, int toIndex) {
    saveState();
    if (tubes[fromIndex].canPourInto(tubes[toIndex])) {
      tubes[fromIndex].pourInto(tubes[toIndex]);
      saveGame();
      notifyListeners();
    }
  }

  void saveGame() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Save your game state here
  }

  void loadGame() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Load your game state here
    resetGame();
  }
}
