import 'package:flutter/material.dart';

const String alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
const int maxFinalLetters = 5;
const int maxSelectableLetters = 10;

class GameState extends ChangeNotifier {
  List<int> selectedText = List.filled(maxFinalLetters, -1);
  String text = "";
  int lowestIndex = 0;
  late String correctWord;
  late String hint;
  bool? _won;
  GameState({required this.correctWord, required this.hint});

  bool? get won => _won;
  set won(bool? value) {
    if (won != value) {
      _won = value;
      notifyListeners();
    }
  }

  void setSelectedText(int index, int value) {
    selectedText[index] = value;
    notifyListeners();
  }
}
