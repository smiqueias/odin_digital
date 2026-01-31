import 'package:gap/gap.dart';

abstract final class GtbGapValue {
  static const xxxs = 4.0;
  static const xxs = 8.0;
  static const xs = 16.0;
  static const sm = 24.0;
  static const md = 32.0;
  static const lg = 40.0;
  static const xl = 48.0;
  static const xxl = 64.0;
  static const xxxl = 128.0;
}

abstract final class GtbGap {
  static const xxxs = Gap(GtbGapValue.xxxs);
  static const xxs = Gap(GtbGapValue.xxs);
  static const xs = Gap(GtbGapValue.xs);
  static const sm = Gap(GtbGapValue.sm);
  static const md = Gap(GtbGapValue.md);
  static const lg = Gap(GtbGapValue.lg);
  static const xl = Gap(GtbGapValue.xl);
  static const xxl = Gap(GtbGapValue.xxl);
  static const xxxl = Gap(GtbGapValue.xxxl);
}

abstract final class GtbSliverGap {
  static const xxxs = SliverGap(GtbGapValue.xxxs);
  static const xxs = SliverGap(GtbGapValue.xxs);
  static const xs = SliverGap(GtbGapValue.xs);
  static const sm = SliverGap(GtbGapValue.sm);
  static const md = SliverGap(GtbGapValue.md);
  static const lg = SliverGap(GtbGapValue.lg);
  static const xl = SliverGap(GtbGapValue.xl);
  static const xxl = SliverGap(GtbGapValue.xxl);
  static const xxxl = SliverGap(GtbGapValue.xxxl);
}

abstract final class GtbPaddingValue {
  static const xxxs = 4.0;
  static const xxs = 8.0;
  static const xs = 16.0;
  static const sm = 24.0;
  static const md = 32.0;
  static const lg = 40.0;
  static const xl = 48.0;
  static const xxl = 64.0;
}
