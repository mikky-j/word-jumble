import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:word_jumble/screens/game/selectable_letter.dart';
import 'package:word_jumble/screens/game/selected_letter.dart';

import '../../controllers/game_controller.dart';

class Game extends StatefulWidget {
  const Game({
    super.key,
  });

  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game> {
  late GameController controller;
  @override
  void initState() {
    controller = GameController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        return controller.state;
      },
      child: Scaffold(
        body: DecoratedBox(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment(0, 0),
              end: Alignment(0, 1),
              colors: [
                Color.fromRGBO(211, 151, 250, 1),
                Color.fromRGBO(131, 100, 232, 1),
              ],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 24.0, horizontal: 20),
                child: Text(
                  "Word Hint\n${controller.hint}",
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
              SelectedLetter(gameController: controller),
              const Spacer(),
              SizedBox(
                width: 400,
                child: Wrap(
                  alignment: WrapAlignment.spaceEvenly,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: List.generate(
                    10,
                    (index) => SelectableLetter(
                      index: index,
                      onTap: () {
                        controller.selectWord(index);
                      },
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
