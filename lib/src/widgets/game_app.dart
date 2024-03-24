
import 'package:brick_breaker/src/widgets/overlay_screen.dart';
import 'package:brick_breaker/src/widgets/score_card.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../brick_breaker.dart';
import '../config.dart';

class GameApp extends StatefulWidget {
  const GameApp({super.key});

  @override
  State<GameApp> createState() => _GameAppState();
}

class _GameAppState extends State<GameApp> {
  late final BrickBreaker game;

  @override
  void initState() {
    super.initState();
    game = BrickBreaker();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        textTheme: GoogleFonts.pressStart2pTextTheme().apply(
          bodyColor: const Color(0xff184e77),
          displayColor: const Color(0xff184e77),
        ),
      ),
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xffa9d6e5),
                Color(0xfff2e8cf),
              ],
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Center(
                child: Column(
                  children: [
                    ScoreCard(score: game.score),
                    FittedBox(
                      child: SizedBox(
                        width: gameWidth,
                        height: gameHeight,
                        child: GameWidget.controlled(
                          gameFactory: BrickBreaker.new,
                          overlayBuilderMap: {
                            PlayState.welcome.name: (BuildContext context, BrickBreaker game) => Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                    // const OverlayScreen(
                                    //   title: 'TAP TO PLAY',
                                    //   subtitle: 'User arrow keys or swipe',
                                    // ),
                                    Text(
                                      'Select Difficulty',
                                      style: Theme.of(context).textTheme.headlineLarge,
                                    ),
                                    const SizedBox(height: 16),
                                    ListBody(
                                        children: [
                                          for (var d in difficultyModifiers)
                                            Center(
                                              child: Column(
                                                children: [
                                                  TextButton(
                                                    child: Text(
                                                      '$d',
                                                      style: Theme.of(context).textTheme.headlineMedium,
                                                    ),
                                                    onPressed: () {
                                                      game.difficulty.value = d;
                                                      game.startGame();
                                                    },
                                                  ),
                                                  const SizedBox(height: 8),
                                                ]
                                              )
                                            ),
                                        ],
                                      ),
                                  ],
                                ),
                              ),
                            PlayState.gameOver.name: (context, game) =>
                              const OverlayScreen(
                                title: 'G A M E   O V E R',
                                subtitle: 'Tap to Play again',
                              ),
                            PlayState.won.name: (context, game) =>
                              const OverlayScreen(
                                title: 'Y O U   W O N ! ! !',
                                subtitle: 'Tap to Play again',
                              ),
                          },
                        ),
                      ),
                    ),
                  ],
              ),
            ),
            ),
          ),
        ),
      ),
    );
  }
}