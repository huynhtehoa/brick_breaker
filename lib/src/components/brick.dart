import 'package:brick_breaker/src/brick_breaker.dart';
import 'package:brick_breaker/src/config.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import 'components.dart';

class Brick extends RectangleComponent with HasGameReference<BrickBreaker>, CollisionCallbacks {
  Brick({
    required super.position,
    required Color color,
  }): super(
    size: Vector2(brickWidth, brickHeight),
    anchor: Anchor.center,
    paint: Paint()
      ..color = color
      ..style = PaintingStyle.fill,
    children: [RectangleHitbox()],
  );

  @override
  void onCollisionStart(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);
    removeFromParent();
    game.score.value++;

    if (game.world.children.query<Brick>().length == 1) {
      game.playState = PlayState.won;

      game.world.removeAll(game.children.query<Ball>());
      game.world.removeAll(game.children.query<Bat>());
    }
  }
}