import '../globals.dart';
import '../models/game_model.dart';
import 'dart:math';

class GameController {
  late GameState state;
  final Random _random = Random();
  GameController() {
    var item = wordlist[_random.nextInt(wordlist.length)];
    state = GameState(
        correctWord: item['word']!.toUpperCase(), hint: item["hint"]!);
    _generateRandomLetters(state.correctWord);
  }

  String get hint => state.hint;

  void selectWord(int index) {
    if (state.lowestIndex < maxFinalLetters &&
        !state.selectedText.contains(index)) {
      state.setSelectedText(state.lowestIndex, index);

      state.lowestIndex = state.selectedText.indexOf(-1);
      if (state.lowestIndex == -1) {
        _updateGameState();
        state.lowestIndex = maxFinalLetters;
      }
    }
  }

  void removeWord(int index) {
    if (state.selectedText[index] != -1) {
      if (index < state.lowestIndex) {
        state.lowestIndex = index;
      }
      state.setSelectedText(index, -1);
      state.won = null;
    }
  }

  void _updateGameState() {
    // String guessedWord =
    //     state.selectedText.map((index) => state.text[index]).toString();
    String guessedWord = "";
    for (int index in state.selectedText) {
      guessedWord += state.text[index];
    }
    state.won = guessedWord == state.correctWord;
  }

  /// This is an implementation of Fisher-Yates Algorithm
  String _shuffleWord(String word) {
    for (var i = word.length - 1; i > 0; i--) {
      int j = _random.nextInt(i);
      String temp = word[j];
      word = word.replaceRange(j, j + 1, word[i]);
      word = word.replaceRange(i, i + 1, temp);
    }
    return word;
  }

  void _generateRandomLetters(String correct) {
    // Add random letters to the correct word
    for (var i = 0; i < maxSelectableLetters - maxFinalLetters; i++) {
      int randomIndex = _random.nextInt(25) + 1;
      correct += alphabet[randomIndex];
    }
    state.text = _shuffleWord(correct);
  }
}
