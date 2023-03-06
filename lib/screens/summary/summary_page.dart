import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:word_jumble/globals.dart';

class SummaryPage extends StatelessWidget {
  final bool won;
  late final Gradient backgroundGradient;
  SummaryPage({super.key, required this.won}) {
    backgroundGradient = won ? winBackgroundGradient : lossBackgroundGradient;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DecoratedBox(
        decoration: BoxDecoration(
          gradient: backgroundGradient,
        ),
        child: SizedBox.expand(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  won ? 'Congrats!!! You won' : 'Too bad, You failed',
                  style: const TextStyle(
                    fontSize: 32,
                    color: Colors.white,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  context.pushReplacement("/game");
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.white),
                  foregroundColor:
                      MaterialStateProperty.all(backgroundGradient.colors[1]),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                child: const Text(
                  "Go to the next stage",
                  style: TextStyle(fontSize: 20),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
