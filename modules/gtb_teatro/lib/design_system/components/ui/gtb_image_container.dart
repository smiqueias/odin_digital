import 'package:flutter/widgets.dart';
import 'package:gtb_teatro/design_system/gtb_teatro.dart';

enum GtbImageContainerShape {
  rounded,
  squared,
}

enum GtbImageContainerSize {
  size16(16.0),
  size24(24.0),
  size32(32.0),
  size40(40.0),
  size48(48.0),
  size64(64.0),
  size80(80.0),
  size96(96.0),
  size112(112.0),
  size160(160.0),
  size240(240.0)
  ;

  const GtbImageContainerSize(this.value);

  final double value;
}

class GtbImageContainer extends StatelessWidget {
  const GtbImageContainer({
    required this.image,
    super.key,
    this.size,
    this.shape,
    this.hasOutline,
  });

  final Widget image;
  final GtbImageContainerSize? size;
  final GtbImageContainerShape? shape;
  final bool? hasOutline;

  @override
  Widget build(BuildContext context) {
    final theme = GtbImageContainerTheme.of(context);
    final size = this.size ?? theme.size;
    final shape = this.shape ?? theme.shape;
    final hasOutline = this.hasOutline ?? theme.hasOutline;

    return Container(
      width: size.value,
      height: size.value,
      decoration: BoxDecoration(
        color: theme.backgroundColor,
        border: hasOutline
            ? GtbBorder.all(
                color: theme.outlineColor,
                stroke: theme.outlineStroke,
              )
            : null,
        borderRadius: switch (shape) {
          GtbImageContainerShape.rounded => null,
          GtbImageContainerShape.squared => BorderRadius.all(theme.radius),
        },
        shape: switch (shape) {
          GtbImageContainerShape.rounded => BoxShape.circle,
          GtbImageContainerShape.squared => BoxShape.rectangle,
        },
      ),
      child: switch (shape) {
        GtbImageContainerShape.rounded => ClipOval(child: image),
        GtbImageContainerShape.squared => ClipRRect(
          borderRadius: BorderRadius.all(theme.radius),
          child: image,
        ),
      },
    );
  }
}

final class GtbImageContainerTheme extends InheritedTheme {
  const GtbImageContainerTheme({
    required super.child,
    required this.data,
    super.key,
  });

  final GtbImageContainerThemeData data;

  static GtbImageContainerThemeData of(BuildContext context) {
    final theme = context.dependOnInheritedWidgetOfExactType<GtbImageContainerTheme>();
    return theme?.data ?? GtbThemeProvider.of(context).imageContainerTheme;
  }

  @override
  bool updateShouldNotify(GtbImageContainerTheme oldWidget) {
    return oldWidget.data != data;
  }

  @override
  Widget wrap(BuildContext context, Widget child) {
    return GtbImageContainerTheme(
      data: data,
      child: child,
    );
  }
}

final class GtbImageContainerThemeData {
  GtbImageContainerThemeData({
    required this.size,
    required this.shape,
    required this.backgroundColor,
    required this.outlineColor,
    required this.outlineStroke,
    required this.radius,
    required this.hasOutline,
  });

  final GtbImageContainerSize size;
  final GtbImageContainerShape shape;
  final Color backgroundColor;
  final Color outlineColor;
  final double outlineStroke;
  final Radius radius;
  final bool hasOutline;

  static GtbImageContainerThemeData lerp(
    GtbImageContainerThemeData a,
    GtbImageContainerThemeData b,
    double t,
  ) {
    return GtbImageContainerThemeData(
      size: t < 0.5 ? a.size : b.size,
      shape: t < 0.5 ? a.shape : b.shape,
      backgroundColor: Color.lerp(a.backgroundColor, b.backgroundColor, t)!,
      outlineColor: Color.lerp(a.outlineColor, b.outlineColor, t)!,
      outlineStroke: lerpDouble(a.outlineStroke, b.outlineStroke, t),
      radius: Radius.lerp(a.radius, b.radius, t)!,
      hasOutline: lerpBool(a.hasOutline, b.hasOutline, t),
    );
  }

  GtbImageContainerThemeData copyWith({
    GtbImageContainerSize? size,
    GtbImageContainerShape? shape,
    Color? backgroundColor,
    Color? outlineColor,
    double? outlineStroke,
    Radius? radius,
    bool? hasOutline,
  }) {
    return GtbImageContainerThemeData(
      size: size ?? this.size,
      shape: shape ?? this.shape,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      outlineColor: outlineColor ?? this.outlineColor,
      outlineStroke: outlineStroke ?? this.outlineStroke,
      radius: radius ?? this.radius,
      hasOutline: hasOutline ?? this.hasOutline,
    );
  }
}

GtbImageContainerThemeData createDefaultImageContainerTheme({
  required GtbColorScheme colorScheme,
  required GtbBorderThemeData borderTheme,
  required GtbTypography typography,
}) {
  return GtbImageContainerThemeData(
    size: GtbImageContainerSize.size48,
    shape: GtbImageContainerShape.rounded,
    backgroundColor: colorScheme.neutralBase,
    outlineColor: colorScheme.outlineBase,
    outlineStroke: borderTheme.strokeThin,
    radius: borderTheme.radiusSmall,
    hasOutline: true,
  );
}
