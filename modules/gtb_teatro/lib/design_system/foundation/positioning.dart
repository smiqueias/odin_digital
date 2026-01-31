import 'dart:math';
import 'dart:ui';

Offset circleOffset({
  required double radius,
  required double angle,
}) {
  final distance = pi * 2.0 * angle / 360;

  return Offset(
    radius * sin(distance) + radius,
    radius * cos(distance) + radius,
  );
}
