import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:word_jumble/screens/game/game_page.dart';
import 'package:word_jumble/screens/summary/summary_page.dart';

GoRouter router = GoRouter(
  initialLocation: "/game",
  routes: [
    GoRoute(
      path: "/game",
      pageBuilder: (context, state) => _buildTransitionPage(const Game()),
      routes: [
        GoRoute(
          path: "summary",
          pageBuilder: (context, state) {
            final bool won = state.extra as bool;
            // final bool won = true;
            return _buildTransitionPage(
              SummaryPage(
                won: won,
              ),
            );
          },
        ),
      ],
    ),
  ],
);

Page<void> _buildTransitionPage(Widget child) {
  return CustomTransitionPage(
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) =>
        FadeTransition(
      opacity: animation,
      child: child,
    ),
  );
}
