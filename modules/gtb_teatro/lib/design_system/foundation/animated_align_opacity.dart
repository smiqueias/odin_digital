import 'dart:math';

import 'package:flutter/widgets.dart';

const _kDefaultDuration = Duration(milliseconds: 300);

final class AnimatedAlignOpacity extends ImplicitlyAnimatedWidget {
  const AnimatedAlignOpacity({
    required this.child,
    super.key,
    this.alignment = Alignment.center,
    this.heightFactor = 1.0,
    this.widthFactor = 1.0,
    super.curve = Curves.easeInOut,
    super.duration = _kDefaultDuration,
    super.onEnd,
  }) : builder = null;

  const AnimatedAlignOpacity.builder({
    required this.builder,
    super.key,
    this.alignment = Alignment.center,
    this.heightFactor = 1.0,
    this.widthFactor = 1.0,
    super.curve = Curves.easeInOut,
    super.duration = _kDefaultDuration,
    super.onEnd,
  }) : child = null;

  final Alignment alignment;
  final Widget? child;
  final WidgetBuilder? builder;
  final double heightFactor;
  final double widthFactor;

  @override
  AnimatedWidgetBaseState<AnimatedAlignOpacity> createState() => _AnimatedAlignOpacityState();
}

class _AnimatedAlignOpacityState extends AnimatedWidgetBaseState<AnimatedAlignOpacity> {
  AlignmentGeometryTween? _alignmentTween;
  Tween<double>? _heightFactorTween;
  Tween<double>? _widthFactorTween;
  Tween<double>? _opacityTween;

  @override
  void forEachTween(TweenVisitor<dynamic> visitor) {
    _alignmentTween =
        visitor(
              _alignmentTween,
              widget.alignment,
              (dynamic value) => AlignmentGeometryTween(begin: value as AlignmentGeometry),
            )
            as AlignmentGeometryTween?;

    _heightFactorTween =
        visitor(
              _heightFactorTween,
              widget.heightFactor,
              (dynamic value) => Tween<double>(begin: value as double),
            )
            as Tween<double>?;

    _widthFactorTween =
        visitor(
              _widthFactorTween,
              widget.widthFactor,
              (dynamic value) => Tween<double>(begin: value as double),
            )
            as Tween<double>?;

    _opacityTween =
        visitor(
              _opacityTween,
              min(widget.widthFactor, widget.heightFactor),
              (dynamic value) => Tween<double>(begin: value as double),
            )
            as Tween<double>?;
  }

  @override
  Widget build(BuildContext context) {
    final alignment = _alignmentTween!.evaluate(animation)!;
    final heightFactor = _heightFactorTween?.evaluate(animation) ?? 1.0;
    final widthFactor = _widthFactorTween?.evaluate(animation) ?? 1.0;
    final opacity = _opacityTween?.evaluate(animation) ?? 1.0;

    if (heightFactor > 0.0 && widthFactor > 0.0) {
      return Opacity(
        opacity: opacity,
        child: ClipRect(
          child: Align(
            alignment: alignment,
            heightFactor: heightFactor,
            widthFactor: widthFactor,
            child: widget.child ?? widget.builder?.call(context),
          ),
        ),
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}
