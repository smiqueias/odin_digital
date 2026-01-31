import 'package:flutter/material.dart';

final class GtbInkWell extends StatelessWidget {
  const GtbInkWell({
    required this.child,
    super.key,
    this.onTapUp,
    this.onTapDown,
    this.onTapCancel,
    this.onTap,
    this.borderRadius = const BorderRadius.all(Radius.circular(4.0)),
    this.customBorder,
  }) : horizontalSplashOverflow = 0.0,
       verticalSplashOverflow = 0.0;

  const GtbInkWell.outsideResponse({
    required this.child,
    super.key,
    this.onTapUp,
    this.onTapDown,
    this.onTapCancel,
    this.onTap,
    this.borderRadius = const BorderRadius.all(Radius.circular(4.0)),
    this.customBorder,
    this.horizontalSplashOverflow = 8.0,
    this.verticalSplashOverflow = 8.0,
  });

  final Widget child;
  final GestureTapUpCallback? onTapUp;
  final GestureTapDownCallback? onTapDown;
  final GestureTapCallback? onTapCancel;
  final GestureTapCallback? onTap;
  final BorderRadius borderRadius;
  final ShapeBorder? customBorder;
  final double horizontalSplashOverflow;
  final double verticalSplashOverflow;

  @override
  Widget build(BuildContext context) {
    return _CustomInkResponse(
      overlayColor: WidgetStatePropertyAll(Theme.of(context).splashColor),
      borderRadius: borderRadius,
      customBorder: customBorder,
      horizontalSplashOverflow: horizontalSplashOverflow,
      verticalSplashOverflow: verticalSplashOverflow,
      onTapUp: onTapUp,
      onTapDown: onTapDown,
      onTapCancel: onTapCancel,
      onTap: onTap,
      child: child,
    );
  }
}

final class _CustomInkResponse extends InkResponse {
  const _CustomInkResponse({
    super.onTapDown,
    super.onTapUp,
    super.onTapCancel,
    super.onTap,
    super.child,
    super.overlayColor,
    super.borderRadius = const BorderRadius.all(Radius.circular(4.0)),
    super.customBorder,
    this.horizontalSplashOverflow = 8.0,
    this.verticalSplashOverflow = 8.0,
  }) : super(
         containedInkWell: true,
         highlightShape: BoxShape.rectangle,
       );

  final double horizontalSplashOverflow;
  final double verticalSplashOverflow;

  @override
  RectCallback? getRectCallback(RenderBox referenceBox) {
    return () {
      return Rect.fromLTWH(
        -horizontalSplashOverflow,
        -verticalSplashOverflow,
        2.0 * horizontalSplashOverflow + referenceBox.size.width,
        2.0 * verticalSplashOverflow + referenceBox.size.height,
      );
    };
  }
}
