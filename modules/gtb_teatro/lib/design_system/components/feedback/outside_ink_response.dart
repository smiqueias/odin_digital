import 'package:flutter/material.dart';

final class GtbOutsideInkResponse extends StatelessWidget {
  final Widget child;
  final GestureTapUpCallback? onTapUp;
  final GestureTapDownCallback? onTapDown;
  final GestureTapCallback? onTapCancel;
  final GestureTapCallback? onTap;
  final double horizontalSplash;
  final double verticalSplash;
  final Color highlightColor;
  final BorderRadius borderRadius;

  const GtbOutsideInkResponse({
    super.key,
    required this.child,
    this.onTapUp,
    this.onTapDown,
    this.onTapCancel,
    this.onTap,
    this.horizontalSplash = 8.0,
    this.verticalSplash = 8.0,
    this.highlightColor = Colors.transparent,
    this.borderRadius = const BorderRadius.all(Radius.circular(4.0)),
  });

  @override
  Widget build(BuildContext context) {
    return _CustomInkResponse(
      horizontalSplash: horizontalSplash,
      verticalSplash: verticalSplash,
      borderRadius: borderRadius,
      onTap: onTap,
      highlightColor: highlightColor,
      onTapCancel: onTapCancel,
      onTapDown: onTapDown,
      onTapUp: onTapUp,
      child: child,
    );
  }
}

final class _CustomInkResponse extends InkResponse {
  final double horizontalSplash;
  final double verticalSplash;

  _CustomInkResponse({
    super.child,
    super.onTapUp,
    super.onTapDown,
    super.onTapCancel,
    super.onTap,
    super.borderRadius,
    super.highlightColor,
    required this.horizontalSplash,
    required this.verticalSplash,
  });

  @override
  RectCallback? getRectCallback(RenderBox referenceBox) {
    return () {
      return Rect.fromLTWH(
        -horizontalSplash,
        -verticalSplash,
        2.0 * horizontalSplash + referenceBox.size.width,
        2.0 * verticalSplash + referenceBox.size.height,
      );
    };
  }
}
