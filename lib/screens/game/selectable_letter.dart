import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:word_jumble/globals.dart';
import 'package:word_jumble/screens/game/selected_letter.dart';

import '../../models/game_model.dart';

class SelectableLetter extends StatelessWidget {
  final int index;
  final VoidCallback onTap;
  const SelectableLetter({required this.index, required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: curvedBox.copyWith(
          color: backgroundBoxColor,
        ),
        alignment: Alignment.center,
        width: 50,
        height: 50,
        margin: const EdgeInsets.all(10),
        child: NewSelectableLetter(index: index),
      ),
    );
  }
}

class OldSelectedLetter extends StatelessWidget {
  const OldSelectedLetter({
    super.key,
    required this.index,
  });

  final int index;

  @override
  Widget build(BuildContext context) {
    return Consumer<GameState>(
      builder: (context, state, child) {
        return AnimatedScale(
          scale: state.selectedText.contains(index) ? 0 : 1,
          curve: gameAnimationCurve,
          duration: gameAnimationDuration,
          child: Container(
            constraints: const BoxConstraints.expand(),
            alignment: Alignment.center,
            decoration: curvedBox.copyWith(
              color: Colors.white,
              boxShadow: <BoxShadow>[gameBoxShadow],
            ),
            child: Text(
              state.text[index],
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
          ),
        );
      },
    );
  }
}

class NewSelectableLetter extends StatelessWidget {
  final int index;
  const NewSelectableLetter({required this.index, super.key});

  bool _isActive(int index, List selectedText) {
    return selectedText.contains(index);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GameState>(
      builder: (context, state, child) {
        return AnimatedScale(
          scale: _isActive(index, state.selectedText) ? 0 : 1,
          duration: gameAnimationDuration,
          curve: gameAnimationCurve,
          child: Letter(text: state.text[index]),
        );
      },
    );
  }
}
