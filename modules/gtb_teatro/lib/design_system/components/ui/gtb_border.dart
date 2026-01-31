import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gtb_teatro/design_system/foundation/lerp.dart';

final class GtbBorderThemeData {
  const GtbBorderThemeData({
    required this.radiusZero,
    required this.radiusSmall,
    required this.radiusMedium,
    required this.radiusLarge,
    required this.radiusPill,
    required this.strokeZero,
    required this.strokeHairline,
    required this.strokeThin,
    required this.strokeThick,
    required this.strokeHeavy,
    required this.dashStyleSmall,
    required this.dashStyleMedium,
    required this.dashStyleLarge,
  });

  final Radius radiusZero;
  final Radius radiusSmall;
  final Radius radiusMedium;
  final Radius radiusLarge;
  final Radius radiusPill;
  final double strokeZero;
  final double strokeHairline;
  final double strokeThin;
  final double strokeThick;
  final double strokeHeavy;
  final GtbDashedBorderStyle dashStyleSmall;
  final GtbDashedBorderStyle dashStyleMedium;
  final GtbDashedBorderStyle dashStyleLarge;

  static GtbBorderThemeData lerp(GtbBorderThemeData a, GtbBorderThemeData b, double t) {
    return GtbBorderThemeData(
      radiusZero: Radius.lerp(a.radiusZero, b.radiusZero, t) ?? Radius.zero,
      radiusSmall: Radius.lerp(a.radiusSmall, b.radiusSmall, t) ?? Radius.zero,
      radiusMedium: Radius.lerp(a.radiusMedium, b.radiusMedium, t) ?? Radius.zero,
      radiusLarge: Radius.lerp(a.radiusLarge, b.radiusLarge, t) ?? Radius.zero,
      radiusPill: Radius.lerp(a.radiusPill, b.radiusPill, t) ?? Radius.zero,
      strokeZero: lerpDouble(a.strokeZero, b.strokeZero, t),
      strokeHairline: lerpDouble(a.strokeHairline, b.strokeHairline, t),
      strokeThin: lerpDouble(a.strokeThin, b.strokeThin, t),
      strokeThick: lerpDouble(a.strokeThick, b.strokeThick, t),
      strokeHeavy: lerpDouble(a.strokeHeavy, b.strokeHeavy, t),
      dashStyleSmall: t < 0.5 ? a.dashStyleSmall : b.dashStyleSmall,
      dashStyleMedium: t < 0.5 ? a.dashStyleMedium : b.dashStyleMedium,
      dashStyleLarge: t < 0.5 ? a.dashStyleLarge : b.dashStyleLarge,
    );
  }

  GtbBorderThemeData copyWith({
    Radius? radiusZero,
    Radius? radiusSmall,
    Radius? radiusMedium,
    Radius? radiusLarge,
    Radius? radiusPill,
    double? strokeZero,
    double? strokeHairline,
    double? strokeThin,
    double? strokeThick,
    double? strokeHeavy,
    GtbDashedBorderStyle? dashStyleSmall,
    GtbDashedBorderStyle? dashStyleMedium,
    GtbDashedBorderStyle? dashStyleLarge,
  }) {
    return GtbBorderThemeData(
      radiusZero: radiusZero ?? this.radiusZero,
      radiusSmall: radiusSmall ?? this.radiusSmall,
      radiusMedium: radiusMedium ?? this.radiusMedium,
      radiusLarge: radiusLarge ?? this.radiusLarge,
      radiusPill: radiusPill ?? this.radiusPill,
      strokeZero: strokeZero ?? this.strokeZero,
      strokeHairline: strokeHairline ?? this.strokeHairline,
      strokeThin: strokeThin ?? this.strokeThin,
      strokeThick: strokeThick ?? this.strokeThick,
      strokeHeavy: strokeHeavy ?? this.strokeHeavy,
      dashStyleSmall: dashStyleSmall ?? this.dashStyleSmall,
      dashStyleMedium: dashStyleMedium ?? this.dashStyleMedium,
      dashStyleLarge: dashStyleLarge ?? this.dashStyleLarge,
    );
  }
}

sealed class GtbBorderStyle {
  const GtbBorderStyle();

  const factory GtbBorderStyle.none() = GtbNoneBorderStyle;

  const factory GtbBorderStyle.solid() = GtbSolidBorderStyle;

  const factory GtbBorderStyle.dashed({required List<int> dashPattern}) = GtbDashedBorderStyle;
}

final class GtbNoneBorderStyle extends GtbBorderStyle {
  const GtbNoneBorderStyle();
}

final class GtbSolidBorderStyle extends GtbBorderStyle {
  const GtbSolidBorderStyle();
}

final class GtbDashedBorderStyle extends GtbBorderStyle {
  const GtbDashedBorderStyle({required this.dashPattern});

  final List<int> dashPattern;
}

class GtbBorderSide extends BorderSide {
  const GtbBorderSide({
    super.color,
    this.stroke = 0.0,
    this.borderStyle = const GtbNoneBorderStyle(),
  }) : super(width: stroke);

  static const none = GtbBorderSide();

  final double stroke;
  final GtbBorderStyle borderStyle;

  static GtbBorderSide lerp(GtbBorderSide a, GtbBorderSide b, double t) {
    if (t == 0.0) {
      return a;
    }

    if (t == 1.0) {
      return b;
    }

    final stroke = lerpDouble(a.stroke, b.stroke, t);

    if (stroke < 0.0) {
      return GtbBorderSide.none;
    } else if (a.style == b.style) {
      return GtbBorderSide(
        color: Color.lerp(a.color, b.color, t)!,
        stroke: stroke,
        borderStyle: a.borderStyle, // == b.style
      );
    } else {
      final colorA = switch (a.borderStyle) {
        GtbNoneBorderStyle() => a.color.withAlpha(0x00),
        GtbSolidBorderStyle() => a.color,
        GtbDashedBorderStyle() => a.color,
      };
      final colorB = switch (b.borderStyle) {
        GtbNoneBorderStyle() => b.color.withAlpha(0x00),
        GtbSolidBorderStyle() => b.color,
        GtbDashedBorderStyle() => b.color,
      };

      return GtbBorderSide(
        color: Color.lerp(colorA, colorB, t)!,
        stroke: stroke,
      );
    }
  }

  static GtbBorderSide? lerpNullable(GtbBorderSide? a, GtbBorderSide? b, double t) {
    if (a == null || b == null) {
      return t < 0.5 ? a : b;
    } else {
      return lerp(a, b, t);
    }
  }

  @override
  GtbBorderSide scale(double t) {
    return GtbBorderSide(
      color: color,
      stroke: stroke * t,
      borderStyle: t <= 0.0 ? const GtbBorderStyle.none() : borderStyle,
    );
  }

  @override
  Paint toPaint() {
    return switch (borderStyle) {
      GtbNoneBorderStyle() =>
        Paint()
          ..color = const Color(0x00000000)
          ..strokeWidth = 0.0
          ..style = PaintingStyle.stroke,
      GtbSolidBorderStyle() =>
        Paint()
          ..color = color
          ..strokeWidth = width
          ..style = PaintingStyle.stroke,
      GtbDashedBorderStyle() =>
        Paint()
          ..color = color
          ..strokeWidth = width
          ..style = PaintingStyle.stroke,
    };
  }

  @override
  bool operator ==(Object other) {
    return other is GtbBorderSide && //
        super == other && //
        borderStyle == other.borderStyle;
  }

  @override
  int get hashCode => Object.hash(super.hashCode, borderStyle);
}

class GtbBorder extends BoxBorder {
  const GtbBorder({
    required this.top,
    required this.right,
    required this.bottom,
    required this.left,
  });

  const GtbBorder.fromGtbBorderSide(GtbBorderSide side) //
    : top = side,
      right = side,
      bottom = side,
      left = side;

  const GtbBorder.symmetric({
    GtbBorderSide? vertical,
    GtbBorderSide? horizontal,
  }) : left = vertical ?? GtbBorderSide.none,
       top = horizontal ?? GtbBorderSide.none,
       right = vertical ?? GtbBorderSide.none,
       bottom = horizontal ?? GtbBorderSide.none;

  factory GtbBorder.all({
    Color color = const Color(0xFF000000),
    double stroke = 0,
    GtbBorderStyle style = const GtbSolidBorderStyle(),
  }) {
    final GtbBorderSide side = GtbBorderSide(
      color: color,
      stroke: stroke,
      borderStyle: style,
    );
    return GtbBorder.fromGtbBorderSide(side);
  }

  @override
  final GtbBorderSide top;

  /// The right side of this border.
  final GtbBorderSide right;

  @override
  final GtbBorderSide bottom;

  /// The left side of this border.
  final GtbBorderSide left;

  @override
  EdgeInsetsGeometry get dimensions {
    return EdgeInsets.fromLTRB(left.width, top.width, right.width, bottom.width);
  }

  @override
  bool get isUniform => _colorIsUniform && _widthIsUniform && _styleIsUniform;

  bool get _colorIsUniform {
    final Color topColor = top.color;
    return right.color == topColor && bottom.color == topColor && left.color == topColor;
  }

  bool get _widthIsUniform {
    final double topWidth = top.width;
    return right.width == topWidth && bottom.width == topWidth && left.width == topWidth;
  }

  bool get _styleIsUniform {
    final GtbBorderStyle topStyle = top.borderStyle;
    return right.borderStyle == topStyle &&
        bottom.borderStyle == topStyle &&
        left.borderStyle == topStyle;
  }

  @override
  GtbBorder scale(double t) {
    return GtbBorder(
      top: top.scale(t),
      right: right.scale(t),
      bottom: bottom.scale(t),
      left: left.scale(t),
    );
  }

  @override
  ShapeBorder? lerpFrom(ShapeBorder? a, double t) {
    if (a is GtbBorder) {
      return GtbBorder.lerp(a, this, t);
    }
    return super.lerpFrom(a, t);
  }

  @override
  ShapeBorder? lerpTo(ShapeBorder? b, double t) {
    if (b is GtbBorder) {
      return GtbBorder.lerp(this, b, t);
    }
    return super.lerpTo(b, t);
  }

  static GtbBorder? lerp(GtbBorder? a, GtbBorder? b, double t) {
    if (a == null && b == null) {
      return null;
    }

    if (a == null) {
      return b!.scale(t);
    }

    if (b == null) {
      return a.scale(1.0 - t);
    }

    return GtbBorder(
      top: GtbBorderSide.lerp(a.top, b.top, t),
      right: GtbBorderSide.lerp(a.right, b.right, t),
      bottom: GtbBorderSide.lerp(a.bottom, b.bottom, t),
      left: GtbBorderSide.lerp(a.left, b.left, t),
    );
  }

  void _paintUniformBorder(
    Canvas canvas,
    Rect rect,
    GtbBorderSide side,
    BorderRadius? borderRadius,
    BoxShape shape,
  ) {
    assert(side.borderStyle != const GtbBorderStyle.none());
    final double width = side.width;
    final Paint paint = side.toPaint();

    switch (shape) {
      case BoxShape.circle:
        assert(borderRadius == null, 'A borderRadius can only be given for rectangular boxes.');
        final double radius = (rect.shortestSide - width) / 2.0;
        canvas.drawCircle(rect.center, radius, paint);
      case BoxShape.rectangle:
        if (borderRadius != null) {
          final RRect outer = borderRadius.toRRect(rect);

          final Paint paintRadius = Paint()..color = side.color;
          if (width == 0.0) {
            paintRadius
              ..style = PaintingStyle.stroke
              ..strokeWidth = 0.0;
            canvas.drawRRect(outer, paintRadius);
          } else {
            final RRect inner = outer.deflate(width);
            canvas.drawDRRect(outer, inner, paintRadius);
          }
        } else {
          canvas.drawRect(rect.deflate(width / 2.0), paint);
        }
    }
  }

  void _paintDashedBorder(
    Canvas canvas,
    Rect rect,
    GtbBorderSide side,
    BorderRadius? borderRadius,
    BoxShape shape,
    List<int> dashPattern,
  ) {
    assert(side.borderStyle != const GtbBorderStyle.none());
    final Paint paint = side.toPaint();

    final Path outPath = Path();

    switch (shape) {
      case BoxShape.circle:
        assert(borderRadius == null, 'A borderRadius can only be given for rectangular boxes.');
        final double s = rect.shortestSide;
        outPath.addOval(
          Rect.fromLTWH(
            rect.left,
            rect.top + s / 2,
            s,
            s,
          ),
        );
      case BoxShape.rectangle:
        if (borderRadius != null) {
          final RRect outer = borderRadius.toRRect(rect);
          outPath.addRRect(outer);
        } else {
          outPath.addRect(rect);
        }
    }

    final PathMetrics metrics = outPath.computeMetrics();
    final Path drawPath = Path();

    for (final PathMetric me in metrics) {
      final double totalLength = me.length;
      int index = -1;

      for (double start = 0; start < totalLength;) {
        double to = start + dashPattern[(++index) % dashPattern.length];
        to = to > totalLength ? totalLength : to;

        if (index.isEven) {
          drawPath.addPath(me.extractPath(start, to), Offset.zero);
        }

        start = to;
      }
    }

    canvas.drawPath(drawPath, paint);
  }

  @override
  void paint(
    Canvas canvas,
    Rect rect, {
    TextDirection? textDirection,
    BoxShape shape = BoxShape.rectangle,
    BorderRadius? borderRadius,
  }) {
    if (isUniform) {
      switch (top.borderStyle) {
        case GtbNoneBorderStyle():
          break;
        case GtbSolidBorderStyle():
          _paintUniformBorder(canvas, rect, top, borderRadius, shape);
        case GtbDashedBorderStyle(:final dashPattern):
          _paintDashedBorder(canvas, rect, top, borderRadius, shape, dashPattern);
      }
    } else {
      assert(() {
        // We are ignoring _colorIsUniform here because we need it to lerp the border in the Search component. Because
        // of this, the drawing is not perfect. Ideally, we should instead remove all the uniformity logic, but provide
        // a way for the painter to properly draw a non-uniform border with radius.
        if (borderRadius != null && (!_widthIsUniform || !_styleIsUniform)) {
          // TODO(mateusfccp): Provide better implementation for non-uniform radius drawing
          throw FlutterError.fromParts(<DiagnosticsNode>[
            ErrorSummary('A borderRadius can only be given for a uniform Border.'),
            ErrorDescription('The following is not uniform:'),
            if (!_colorIsUniform) ErrorDescription('GtbBorderSide.color'),
            if (!_widthIsUniform) ErrorDescription('GtbBorderSide.width'),
            if (!_styleIsUniform) ErrorDescription('GtbBorderSide.borderStyle'),
          ]);
        }
        return true;
      }());
      assert(() {
        if (shape != BoxShape.rectangle) {
          throw FlutterError.fromParts(<DiagnosticsNode>[
            ErrorSummary('A Border can only be drawn as a circle if it is uniform'),
            ErrorDescription('The following is not uniform:'),
            if (!_colorIsUniform) ErrorDescription('GtbBorderSide.color'),
            if (!_widthIsUniform) ErrorDescription('GtbBorderSide.width'),
            if (!_styleIsUniform) ErrorDescription('GtbBorderSide.borderStyle'),
          ]);
        }
        return true;
      }());

      paintBorder(canvas, rect, top: top, right: right, bottom: bottom, left: left);
    }
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }

    if (other.runtimeType != runtimeType) {
      return false;
    }

    return other is GtbBorder && //
        other.top == top &&
        other.right == right &&
        other.bottom == bottom &&
        other.left == left;
  }

  @override
  int get hashCode => Object.hash(top, right, bottom, left);

  @override
  String toString() {
    if (isUniform) {
      return '${objectRuntimeType(this, 'Border')}.all($top)';
    }

    final List<String> arguments = <String>[
      if (top != GtbBorderSide.none) 'top: $top',
      if (right != GtbBorderSide.none) 'right: $right',
      if (bottom != GtbBorderSide.none) 'bottom: $bottom',
      if (left != GtbBorderSide.none) 'left: $left',
    ];
    return '${objectRuntimeType(this, 'Border')}(${arguments.join(", ")})';
  }
}

const defaultBorderTheme = GtbBorderThemeData(
  radiusZero: Radius.zero,
  radiusSmall: Radius.circular(4.0),
  radiusMedium: Radius.circular(8.0),
  radiusLarge: Radius.circular(16.0),
  radiusPill: Radius.circular(999.0),
  strokeZero: 0.0,
  strokeHairline: 0.5,
  strokeThin: 1.0,
  strokeThick: 1.5,
  strokeHeavy: 2.0,
  dashStyleSmall: GtbDashedBorderStyle(dashPattern: [2, 2]),
  dashStyleMedium: GtbDashedBorderStyle(dashPattern: [5, 4]),
  dashStyleLarge: GtbDashedBorderStyle(dashPattern: [8, 4]),
);
