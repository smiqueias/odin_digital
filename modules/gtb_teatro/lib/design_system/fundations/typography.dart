import 'package:flutter/material.dart';
import 'package:gtb_teatro/design_system/fundations/fonts.dart';

final class GtbFontSize {
  final double xs_12;
  final double xl_14;
  final double sm_16;
  final double sl_18;
  final double md_24;
  final double lg_32;

  GtbFontSize({
    required this.xs_12,
    required this.xl_14,
    required this.sm_16,
    required this.md_24,
    required this.sl_18,
    required this.lg_32,
  });

  GtbFontSize copyWith({
    double? xs_12,
    double? xl_14,
    double? sm_16,
    double? sl_18,
    double? md_24,
    double? lg_32,
  }) {
    return GtbFontSize(
      xs_12: xs_12 ?? this.xs_12,
      xl_14: xl_14 ?? this.xl_14,
      sm_16: sm_16 ?? this.sm_16,
      sl_18: sl_18 ?? this.sl_18,
      md_24: md_24 ?? this.md_24,
      lg_32: lg_32 ?? this.lg_32,
    );
  }
}

final class GtbFontWeight {
  final FontWeight regular;
  final FontWeight bold;
  final FontWeight semibold;

  GtbFontWeight({
    required this.regular,
    required this.bold,
    required this.semibold,
  });

  GtbFontWeight copyWith({
    FontWeight? regular,
    FontWeight? bold,
    FontWeight? semibold,
  }) {
    return GtbFontWeight(
      regular: regular ?? this.regular,
      bold: bold ?? this.bold,
      semibold: semibold ?? this.semibold,
    );
  }
}

final class GtbLineHeight {
  final double small;

  final double large;

  GtbLineHeight({required this.small, required this.large});

  GtbLineHeight copyWith({double? small, double? large}) {
    return GtbLineHeight(
      small: small ?? this.small,
      large: large ?? this.large,
    );
  }
}

const _baseTextStyle = TextStyle(fontFamily: FontFamily.fontFamily);

final class GtbTypography {
  final String fontFamily;
  final GtbFontSize fontSize;
  final GtbFontWeight fontWeight;
  final GtbLineHeight lineHeight;

  final TextStyle input;
  final TextStyle button;
  final TextStyle subtitle;
  final TextStyle tag;
  final TextStyle textMd;
  final TextStyle textLarge;
  final TextStyle textMdDone;
  final TextStyle textSm;
  final TextStyle textSmDone;

  GtbTypography({
    required this.fontSize,
    required this.fontFamily,
    required this.fontWeight,
    required this.lineHeight,
  }) : input = _baseTextStyle.copyWith(
         fontSize: fontSize.xl_14,
         fontWeight: fontWeight.bold,
         fontFamily: fontFamily,
         height: lineHeight.large,
       ),
       textLarge = _baseTextStyle.copyWith(
         fontSize: fontSize.lg_32,
         fontWeight: fontWeight.bold,
         fontFamily: fontFamily,
         height: lineHeight.large,
       ),
       button = _baseTextStyle.copyWith(
         fontSize: fontSize.sm_16,
         fontWeight: fontWeight.bold,
         fontFamily: fontFamily,
         height: lineHeight.large,
       ),
       subtitle = _baseTextStyle.copyWith(
         fontSize: fontSize.xl_14,
         fontWeight: fontWeight.semibold,
         fontFamily: fontFamily,
         height: lineHeight.small,
       ),
       tag = _baseTextStyle.copyWith(
         fontSize: fontSize.xs_12,
         fontWeight: fontWeight.bold,
         fontFamily: fontFamily,
         height: lineHeight.small,
       ),
       textMd = _baseTextStyle.copyWith(
         fontSize: fontSize.xl_14,
         fontWeight: fontWeight.regular,
         fontFamily: fontFamily,
       ),
       textMdDone = _baseTextStyle.copyWith(
         fontSize: fontSize.xl_14,
         fontWeight: fontWeight.regular,
         decoration: TextDecoration.underline,
         fontFamily: fontFamily,
         height: lineHeight.large,
       ),
       textSm = _baseTextStyle.copyWith(
         fontSize: fontSize.xs_12,
         fontWeight: fontWeight.regular,
         fontFamily: fontFamily,
         height: lineHeight.large,
       ),
       textSmDone = _baseTextStyle.copyWith(
         fontSize: fontSize.xs_12,
         fontWeight: fontWeight.regular,
         decoration: TextDecoration.underline,
         fontFamily: fontFamily,
         height: lineHeight.large,
       );
}

final defaultTypography = GtbTypography(
  fontFamily: FontFamily.fontFamily,
  lineHeight: GtbLineHeight(small: 1.2, large: 1.4),
  fontSize: GtbFontSize(
    xs_12: 12.0,
    xl_14: 14.0,
    sm_16: 16.0,
    sl_18: 18.0,
    md_24: 24.0,
    lg_32: 32.0,
  ),
  fontWeight: GtbFontWeight(
    regular: FontWeight.w400,
    bold: FontWeight.w700,
    semibold: FontWeight.w300,
  ),
);
