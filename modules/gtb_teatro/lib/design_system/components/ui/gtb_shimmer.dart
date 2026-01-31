import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:gtb_teatro/design_system/color_scheme/color_scheme_provider.dart';
import 'package:shimmer/shimmer.dart';

enum GtbShimmerFit {
  loose,
  expand,
  passthrough,
}

/// A widget that renders a shimmer effect over its [child].
///
/// The shimmer effect will be applied to the entire [child]. This means that
/// if you want to synchronize the shimmer effect animation between many
/// children, you may pass, for instance, an entire column/row of widgets as
/// the [child] of this widget.
///
/// If [isLoading] is false, the shimmer effect won't be rendered over the shimmer. This
/// status may be accessed by children though `GtbShimmer.of(context).isLoading`, as long
/// as the shimmer is present in the `context`.
///
/// The shimmer effect will be blended with the painted widget with [BlendMode.srcIn]. If you
/// think the result is different than the expected one, check [BlendMode] documentation for
/// details about how the blending happens.
///
/// ```dart
/// GtbShimmer(
///   child: Row(
///     children: [
///       const GtbShimmerCover.circle(radius: 36.0 / 2.0),
///       GtbSpacing.xxs,
///       Column(
///         crossAxisAlignment: CrossAxisAlignment.start,
///         mainAxisSize: MainAxisSize.min,
///         children: const [
///           GtbSpacing.xxs,
///           GtbShimmerCover(child: SizedBox(width: 300.0, height: 16.0)),
///           GtbSpacing.xxs,
///           GtbShimmerCover(child: SizedBox(width: 300.0, height: 16.0)),
///           GtbSpacing.xxs,
///           GtbShimmerCover(child: SizedBox(width: 250.0, height: 16.0)),
///         ],
///       ),
///     ],
///   ),
/// )
/// ```
///
/// See also:
///
///  * [ShimmerBox], a pre-built box widget.
///  * [GtbShimmerCover], which is a cover frame to be used over its `child`.
final class GtbShimmer extends StatelessWidget {
  const GtbShimmer({
    required this.child,
    super.key,
    this.switchAnimationDuration = const Duration(milliseconds: 300),
    this.switchInCurve = Curves.easeIn,
    this.switchOutCurve = Curves.easeIn,
    this.fit = GtbShimmerFit.passthrough,
    this.isLoading = true,
  });

  final Duration switchAnimationDuration;
  final Curve switchInCurve;
  final Curve switchOutCurve;
  final GtbShimmerFit fit;
  final bool isLoading;
  final Widget child;

  static _InheritedShimmer of(BuildContext context) {
    final loader = context.dependOnInheritedWidgetOfExactType<_InheritedShimmer>();

    if (loader != null) {
      return loader;
    } else {
      throw FlutterError.fromParts(
        <DiagnosticsNode>[
          ErrorSummary('No _InheritedShimmer was found in the element tree.'),
          ErrorDescription(
            '${context.widget.runtimeType} widgets require a GtbShimmer '
            'widget ancestor. Through a GtbShimmer it is possible to change '
            'from a shimmer effect to a real implementation.',
          ),
          ...context.describeMissingAncestor(expectedAncestorType: _InheritedShimmer),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = GtbThemeProvider.of(context).appColorScheme;

    return _InheritedShimmer(
      baseColor: colorScheme.specialShimmerBase.colors[1],
      highlightColor: colorScheme.specialShimmerBase.colors[0],
      switchAnimationDuration: switchAnimationDuration,
      switchInCurve: switchInCurve,
      switchOutCurve: switchOutCurve,
      isLoading: isLoading,
      child: _ShimmerEffect(
        fit: fit,
        child: child,
      ),
    );
  }
}

class _InheritedShimmer extends InheritedWidget {
  const _InheritedShimmer({
    required super.child,
    required this.baseColor,
    required this.highlightColor,
    this.switchAnimationDuration = const Duration(milliseconds: 300),
    this.switchInCurve = Curves.linear,
    this.switchOutCurve = Curves.linear,
    this.isLoading = true,
  });

  final Color baseColor;
  final Color highlightColor;
  final Duration switchAnimationDuration;
  final Curve switchInCurve;
  final Curve switchOutCurve;
  final bool isLoading;

  @override
  bool updateShouldNotify(_InheritedShimmer oldWidget) {
    return oldWidget.isLoading != isLoading || //
        oldWidget.switchInCurve != switchInCurve ||
        oldWidget.switchOutCurve != switchOutCurve ||
        oldWidget.switchAnimationDuration != switchAnimationDuration ||
        oldWidget.baseColor != baseColor ||
        oldWidget.highlightColor != highlightColor ||
        oldWidget.switchInCurve != switchInCurve;
  }
}

/// A surface that covers its [child] while a shimmer is in process.
///
/// This is useful when the [child] drawing surface does not correspond to
/// the intended surface for the shimmer to be drawn. For instance, a [Text]
/// under [GtbShimmerRegion] will have the shimmer effect drawn over is letters. However,
/// It's usually intended to have a box representing the text instead. This can be
/// achieved by wrapping the [Text] in a [GtbShimmerCover].
///
/// [GtbShimmerCover] will take the space that its child takes as much as possible,
/// considering its [shape].
///
/// This widget **must** be inside a [GtbShimmerRegion] widget to work, because it depends
/// on the loading state provided by it. If not, an error will be thrown at runtime.
///
/// ```dart
/// Column(
///   children: [
///     ...
///     const GtbShimmer(
///       child: GtbShimmerCover(
///         child: Text('Carregando'),
///       ),
///     ),
///     const GtbShimmer(
///       child: Text('Carregando'),
///     ),
///     ...
///   ],
/// )
/// ```
///
/// In the example above, the result will be different for each Text, as specified before.
///
/// See also:
///
///  * [GtbShimmerRegion], the parent widget which provides the shimmer effects to all widgets,
/// including this one.
final class GtbShimmerCover extends StatelessWidget {
  const GtbShimmerCover({
    required this.child,
    super.key,
    this.borderRadius = 4.0,
    this.shimmerPadding = EdgeInsets.zero,
  });

  final double? borderRadius;
  final EdgeInsets shimmerPadding;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final shimmer = GtbShimmer.of(context);
    final borderRadius = Radius.circular(this.borderRadius ?? 0);

    return shimmer.isLoading
        ? ClipRRect(
            clipper: _PaddingClipper(shimmerPadding, borderRadius),
            child: ColoredBox(
              color: shimmer.baseColor,
              child: Visibility(
                maintainSize: true,
                maintainState: true,
                maintainAnimation: true,
                visible: false,
                child: child,
              ),
            ),
          )
        : child;
  }
}

final class _ShimmerEffect extends StatelessWidget {
  const _ShimmerEffect({
    required this.fit,
    required this.child,
  });

  final GtbShimmerFit fit;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final shimmer = GtbShimmer.of(context);
    final isLoading = shimmer.isLoading;
    final baseColor = GtbShimmer.of(context).baseColor;
    final highlightColor = GtbShimmer.of(context).highlightColor;

    return AnimatedSwitcher(
      duration: shimmer.switchAnimationDuration,
      reverseDuration: shimmer.switchAnimationDuration,
      switchInCurve: shimmer.switchInCurve,
      switchOutCurve: shimmer.switchOutCurve,
      layoutBuilder: (currentChild, previousChildren) {
        return Stack(
          fit: switch (fit) {
            GtbShimmerFit.loose => StackFit.loose,
            GtbShimmerFit.expand => StackFit.expand,
            GtbShimmerFit.passthrough => StackFit.passthrough,
          },
          children: [
            if (currentChild == null)
              ...previousChildren.map(
                (child) {
                  return Positioned(
                    left: 0.0,
                    top: 0.0,
                    right: 0.0,
                    child: child,
                  );
                },
              ),
            if (currentChild != null) currentChild,
          ],
        );
      },
      child: isLoading
          ? Shimmer.fromColors(
              period: const Duration(milliseconds: 800),
              baseColor: baseColor,
              highlightColor: highlightColor,
              child: child,
            )
          : child,
    );
  }
}

final class _PaddingClipper extends CustomClipper<RRect> {
  _PaddingClipper(this.padding, this.radius);

  final EdgeInsets padding;
  final Radius radius;

  @override
  RRect getClip(Size size) {
    final left = padding.left;
    final top = padding.top;
    final right = max(left, size.width - padding.right);
    final bottom = max(top, size.height - padding.bottom);
    return RRect.fromLTRBR(left, top, right, bottom, radius);
  }

  @override
  bool shouldReclip(_PaddingClipper oldClipper) {
    return padding != oldClipper.padding || radius != oldClipper.radius;
  }
}
