import 'package:flutter/material.dart';

const wordlist = [
  {"word": "fable", "hint": "a short tale that teaches a moral"},
  {"word": "heist", "hint": "a theft, especially from a bank"},
  {"word": "jolly", "hint": "happy and cheerful"},
  {"word": "lemon", "hint": "a yellow citrus fruit with acidic juice"},
  {"word": "plush", "hint": "luxurious, soft, and thick"},
  {
    "word": "silly",
    "hint": "having or showing a lack of common sense or judgement"
  },
  {
    "word": "stunt",
    "hint":
        "an unusual or difficult feat of daring or skill, often performed to attract attention"
  },
  {
    "word": "truce",
    "hint":
        "an agreement between enemies or opponents to stop fighting or arguing for a certain time"
  },
  {
    "word": "vogue",
    "hint": "something that is fashionable or popular at a particular time"
  },
  {"word": "whirl", "hint": "move or cause to move rapidly around and around"}
];

const Duration gameAnimationDuration = Duration(milliseconds: 300);
const Curve gameAnimationCurve = Curves.easeInQuart;
const Curve gameShakeAnimationCurve = SawTooth(4);

const BoxShadow gameBoxShadow = BoxShadow(
  color: Colors.black12,
  blurRadius: 10,
);
BoxDecoration curvedBox = BoxDecoration(borderRadius: BorderRadius.circular(8));
const backgroundBoxColor = Color.fromRGBO(131, 100, 232, .4);
