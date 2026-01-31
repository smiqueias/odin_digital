import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:gtb_teatro/design_system/foundation/lerp.dart';

import 'constants.dart';
import 'fonts.dart';

final class GtbFontSize {
  const GtbFontSize({
    required this.xxs,
    required this.xs,
    required this.sm,
    required this.base,
    required this.md,
    required this.lg,
    required this.xl,
    required this.xxl,
    required this.xxxl,
    required this.xxxxl,
  });

  final double xxs;
  final double xs;
  final double sm;
  final double base;
  final double md;
  final double lg;
  final double xl;
  final double xxl;
  final double xxxl;
  final double xxxxl;

  static GtbFontSize lerp(GtbFontSize a, GtbFontSize b, double t) {
    return GtbFontSize(
      xxs: lerpDouble(a.xxs, b.xxs, t),
      xs: lerpDouble(a.xs, b.xs, t),
      sm: lerpDouble(a.sm, b.sm, t),
      base: lerpDouble(a.base, b.base, t),
      md: lerpDouble(a.md, b.md, t),
      lg: lerpDouble(a.lg, b.lg, t),
      xl: lerpDouble(a.xl, b.xl, t),
      xxl: lerpDouble(a.xxl, b.xxl, t),
      xxxl: lerpDouble(a.xxxl, b.xxxl, t),
      xxxxl: lerpDouble(a.xxxxl, b.xxxxl, t),
    );
  }

  GtbFontSize copyWith({
    double? xxs,
    double? xs,
    double? sm,
    double? base,
    double? md,
    double? lg,
    double? xl,
    double? xxl,
    double? xxxl,
    double? xxxxl,
  }) {
    return GtbFontSize(
      xxs: xxs ?? this.xxs,
      xs: xs ?? this.xs,
      sm: sm ?? this.sm,
      base: base ?? this.base,
      md: md ?? this.md,
      lg: lg ?? this.lg,
      xl: xl ?? this.xl,
      xxl: xxl ?? this.xxl,
      xxxl: xxxl ?? this.xxxl,
      xxxxl: xxxxl ?? this.xxxxl,
    );
  }
}

final class GtbFontWeight {
  const GtbFontWeight({
    required this.regular,
    required this.bold,
  });

  final FontWeight regular;
  final FontWeight bold;

  static GtbFontWeight lerp(GtbFontWeight a, GtbFontWeight b, double t) => t < 0.5 ? a : b;

  GtbFontWeight copyWith({
    FontWeight? regular,
    FontWeight? bold,
  }) {
    return GtbFontWeight(
      regular: regular ?? this.regular,
      bold: bold ?? this.bold,
    );
  }
}

final class GtbLineHeight {
  const GtbLineHeight({
    required this.small,
    required this.medium,
    required this.large,
  });

  final double small;
  final double medium;
  final double large;

  static GtbLineHeight lerp(GtbLineHeight a, GtbLineHeight b, double t) {
    return GtbLineHeight(
      small: lerpDouble(a.small, b.small, t),
      medium: lerpDouble(a.medium, b.medium, t),
      large: lerpDouble(a.large, b.large, t),
    );
  }

  GtbLineHeight copyWith({
    double? small,
    double? medium,
    double? large,
  }) {
    return GtbLineHeight(
      small: small ?? this.small,
      medium: medium ?? this.medium,
      large: large ?? this.large,
    );
  }
}

const _baseTextStyle = TextStyle(
  leadingDistribution: TextLeadingDistribution.even,
  letterSpacing: 0.0,
  package: kTeatroPackage,
);

final class GtbTypography {
  GtbTypography({
    required this.fontFamily,
    required this.fontSize,
    required this.fontWeight,
    required this.lineHeight,
  }) : displayBase = _baseTextStyle.copyWith(
         fontFamily: fontFamily,
         fontSize: fontSize.xl,
         height: lineHeight.large,
         fontWeight: fontWeight.regular,
       ),
       displayBaseUnderline = _baseTextStyle.copyWith(
         fontFamily: fontFamily,
         fontSize: fontSize.xl,
         height: lineHeight.large,
         fontWeight: fontWeight.regular,
         decoration: TextDecoration.underline,
       ),
       titleBase = _baseTextStyle.copyWith(
         fontFamily: fontFamily,
         fontSize: fontSize.lg,
         height: lineHeight.medium,
         fontWeight: fontWeight.regular,
       ),
       titleSmall = _baseTextStyle.copyWith(
         fontFamily: fontFamily,
         fontSize: fontSize.md,
         height: lineHeight.medium,
         fontWeight: fontWeight.regular,
       ),
       bodyBase = _baseTextStyle.copyWith(
         fontFamily: fontFamily,
         fontSize: fontSize.base,
         height: lineHeight.large,
         fontWeight: fontWeight.regular,
       ),
       bodyBaseUnderline = _baseTextStyle.copyWith(
         fontFamily: fontFamily,
         fontSize: fontSize.base,
         height: lineHeight.large,
         fontWeight: fontWeight.regular,
         decoration: TextDecoration.underline,
       ),
       bodyBaseStrikethrough = _baseTextStyle.copyWith(
         fontFamily: fontFamily,
         fontSize: fontSize.base,
         height: lineHeight.large,
         fontWeight: fontWeight.regular,
         decoration: TextDecoration.lineThrough,
       ),
       bodySmall = _baseTextStyle.copyWith(
         fontFamily: fontFamily,
         fontSize: fontSize.sm,
         height: lineHeight.large,
         fontWeight: fontWeight.regular,
       ),
       bodySmallUnderline = _baseTextStyle.copyWith(
         fontFamily: fontFamily,
         fontSize: fontSize.sm,
         height: lineHeight.large,
         fontWeight: fontWeight.regular,
         decoration: TextDecoration.underline,
       ),
       bodySmallStrikethrough = _baseTextStyle.copyWith(
         fontFamily: fontFamily,
         fontSize: fontSize.sm,
         height: lineHeight.large,
         fontWeight: fontWeight.regular,
         decoration: TextDecoration.lineThrough,
       ),
       captionBase = _baseTextStyle.copyWith(
         fontFamily: fontFamily,
         fontSize: fontSize.xs,
         height: lineHeight.large,
         fontWeight: fontWeight.regular,
       ),
       captionBaseStrikethrough = _baseTextStyle.copyWith(
         fontFamily: fontFamily,
         fontSize: fontSize.xs,
         height: lineHeight.large,
         fontWeight: fontWeight.regular,
         decoration: TextDecoration.lineThrough,
       ),
       labelBase = _baseTextStyle.copyWith(
         fontFamily: fontFamily,
         fontSize: fontSize.base,
         height: lineHeight.medium,
         fontWeight: fontWeight.regular,
       ),
       labelBaseUnderline = _baseTextStyle.copyWith(
         fontFamily: fontFamily,
         fontSize: fontSize.base,
         height: lineHeight.medium,
         fontWeight: fontWeight.regular,
         decoration: TextDecoration.underline,
       ),
       labelBaseStrikethrough = _baseTextStyle.copyWith(
         fontFamily: fontFamily,
         fontSize: fontSize.base,
         height: lineHeight.medium,
         fontWeight: fontWeight.regular,
         decoration: TextDecoration.lineThrough,
       ),
       labelSmall = _baseTextStyle.copyWith(
         fontFamily: fontFamily,
         fontSize: fontSize.sm,
         height: lineHeight.medium,
         fontWeight: fontWeight.regular,
       ),
       labelSmallUnderline = _baseTextStyle.copyWith(
         fontFamily: fontFamily,
         fontSize: fontSize.sm,
         height: lineHeight.medium,
         fontWeight: fontWeight.regular,
         decoration: TextDecoration.underline,
       ),
       labelSmallStrikethrough = _baseTextStyle.copyWith(
         fontFamily: fontFamily,
         fontSize: fontSize.sm,
         height: lineHeight.medium,
         fontWeight: fontWeight.regular,
         decoration: TextDecoration.lineThrough,
       ),
       labelTiny = _baseTextStyle.copyWith(
         fontFamily: fontFamily,
         fontSize: fontSize.xs,
         height: lineHeight.medium,
         fontWeight: fontWeight.regular,
       ),
       labelMicro = _baseTextStyle.copyWith(
         fontFamily: fontFamily,
         fontSize: fontSize.xxs,
         height: lineHeight.medium,
         fontWeight: fontWeight.regular,
       );

  final String fontFamily;
  final GtbFontSize fontSize;
  final GtbFontWeight fontWeight;
  final GtbLineHeight lineHeight;

  final TextStyle displayBase;
  final TextStyle displayBaseUnderline;
  final TextStyle titleBase;
  final TextStyle titleSmall;
  final TextStyle bodyBase;
  final TextStyle bodyBaseUnderline;
  final TextStyle bodyBaseStrikethrough;
  final TextStyle bodySmall;
  final TextStyle bodySmallUnderline;
  final TextStyle bodySmallStrikethrough;
  final TextStyle captionBase;
  final TextStyle captionBaseStrikethrough;
  final TextStyle labelBase;
  final TextStyle labelBaseStrikethrough;
  final TextStyle labelBaseUnderline;
  final TextStyle labelSmall;
  final TextStyle labelSmallUnderline;
  final TextStyle labelSmallStrikethrough;
  final TextStyle labelTiny;
  final TextStyle labelMicro;

  GtbTypography copyWith({
    String? fontFamily,
    GtbFontSize? fontSize,
    GtbFontWeight? fontWeight,
    GtbLineHeight? lineHeight,
  }) {
    return GtbTypography(
      fontFamily: fontFamily ?? this.fontFamily,
      fontSize: fontSize ?? this.fontSize,
      fontWeight: fontWeight ?? this.fontWeight,
      lineHeight: lineHeight ?? this.lineHeight,
    );
  }

  static GtbTypography lerp(GtbTypography a, GtbTypography b, double t) {
    return GtbTypography(
      fontFamily: t > 0.5 ? a.fontFamily : b.fontFamily,
      fontSize: GtbFontSize.lerp(a.fontSize, b.fontSize, t),
      fontWeight: GtbFontWeight.lerp(a.fontWeight, b.fontWeight, t),
      lineHeight: GtbLineHeight.lerp(a.lineHeight, b.lineHeight, t),
    );
  }
}

final defaultTypography = GtbTypography(
  fontFamily: FontFamily.fontFamily,
  fontSize: const GtbFontSize(
    xxs: 10.0,
    xs: 12.0,
    sm: 14.0,
    base: 16.0,
    md: 18.0,
    lg: 24.0,
    xl: 28.0,
    xxl: 32.0,
    xxxl: 48.0,
    xxxxl: 64.0,
  ),
  fontWeight: const GtbFontWeight(
    regular: FontWeight.w400,
    bold: FontWeight.w700,
  ),
  lineHeight: GtbLineHeight(
    small: 1.00,
    medium: switch (defaultTargetPlatform) {
      TargetPlatform.iOS => 1.05,
      TargetPlatform.android ||
      TargetPlatform.fuchsia ||
      TargetPlatform.linux ||
      TargetPlatform.macOS ||
      TargetPlatform.windows => 1.25,
    },
    large: switch (defaultTargetPlatform) {
      TargetPlatform.iOS => 1.25,
      TargetPlatform.android ||
      TargetPlatform.fuchsia ||
      TargetPlatform.linux ||
      TargetPlatform.macOS ||
      TargetPlatform.windows => 1.50,
    },
  ),
);
