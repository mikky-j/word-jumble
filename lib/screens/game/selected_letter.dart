import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:word_jumble/controllers/game_controller.dart';
import 'package:word_jumble/globals.dart';
import 'package:word_jumble/models/game_model.dart';

class SelectedLetter extends StatefulWidget {
  final GameController gameController;
  const SelectedLetter({required this.gameController, super.key});

  @override
  State<SelectedLetter> createState() => _SelectedLetterState();
}

class _SelectedLetterState extends State<SelectedLetter>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late final List<Animation<double>> _tweens;

  List<Animation<double>> _getTweens(int tweenNumber) {
    return List.generate(
      tweenNumber,
      (index) {
        // double interval = 1 / tweenNumber;
        double interval = 0.2;
        double begin = interval * index;
        return Tween(
          begin: 0.0,
          end: 90 / 360,
        ).animate(
          CurvedAnimation(
            parent: _controller,
            curve: Interval(
              begin,
              begin + interval,
              curve: gameAnimationCurve,
            ),
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1250))
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          setState(() {});
        }
      });

    _tweens = _getTweens(5);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool _isActive(int index, List<int> selectedList) {
    return selectedList[index] != -1;
  }

  String _getText(int index) {
    int textIndex = widget.gameController.state.selectedText[index];
    return widget.gameController.state.text[textIndex];
  }

  bool _getWon() {
    return widget.gameController.state.won ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GameState>(
      builder: (context, state, _) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(
              5,
              (index) =>
                  _buildButton(_isActive(index, state.selectedText), index)),
        );
      },
    );
  }

  Widget _buildButton(bool active, int index) {
    return GestureDetector(
      onTap: () {
        if (!_controller.isAnimating) {
          widget.gameController.removeWord(index);
        }
        if (_controller.isCompleted) {
          _controller.reset();
        }
      },
      child: Container(
        // color: Colors.blueGrey,
        width: 50,
        height: 50,
        decoration: curvedBox.copyWith(
          color: backgroundBoxColor,
        ),
        child: AnimatedScale(
          duration: gameAnimationDuration,
          curve: gameAnimationCurve,
          scale: active ? 1 : 0,
          onEnd: () {
            if (index == 4 && active) {
              _controller.forward();
              setState(() {});
            }
          },
          child: RotationTransition(
            turns: _tweens[index],
            child: Letter(
              index: index,
              started: _controller.isAnimating,
              text: active ? _getText(index) : "",
              done: _controller.isCompleted,
              won: _getWon(),
            ),
          ),
        ),
      ),
    );
  }
}

class Letter extends StatelessWidget {
  final bool started, done, won;
  final int index;
  final String text;
  const Letter({
    this.started = false,
    this.done = false,
    required this.text,
    this.won = false,
    this.index = 0,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double begin = index * 0.2;
    double end = begin + 0.2;

    return AnimatedContainer(
      duration: gameAnimationDuration,
      decoration: curvedBox.copyWith(
        color: done ? Colors.white : const Color.fromRGBO(255, 255, 254, 1),
        boxShadow: [gameBoxShadow],
      ),
      onEnd: () {
        if (done) {
          context.pushReplacement("/game/summary", extra: won);
        }
      },
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 1250),
        curve: Interval(begin, end),
        onEnd: () {},
        opacity: started || done ? 0 : 1,
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 20,
              color: Color.fromRGBO(116, 88, 207, 1),
              fontFamily: "Roboto",
            ),
          ),
        ),
      ),
    );
  }
}
