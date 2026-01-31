import 'package:flutter/material.dart';
import 'package:gtb_teatro/design_system/gtb_teatro.dart';

final class GtbGlobalLoader extends StatelessWidget {
  const GtbGlobalLoader({
    super.key,
    this.size = 64.0,
    this.strokeWidth = 3.2,
    this.color,
  });

  final Color? color;
  final double size;
  final double strokeWidth;

  @override
  Widget build(BuildContext context) {
    final theme = GtbThemeProvider.of(context);

    return _GlobalLoader(
      color: color ?? theme.appColorScheme.onColorEmphasisHigh,
      size: size,
      strokeWidth: strokeWidth,
    );
  }
}

enum GtbGlobalLoaderSmallSize {
  size16(16.0, 13.3),
  size24(24.0, 20.0)
  ;

  const GtbGlobalLoaderSmallSize(this.totalSize, this.internalSize);

  final double totalSize;
  final double internalSize;
}

final class GtbGlobalLoaderSmall extends StatelessWidget {
  const GtbGlobalLoaderSmall({
    super.key,
    this.size = GtbGlobalLoaderSmallSize.size24,
    this.color,
  });

  final GtbGlobalLoaderSmallSize size;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final theme = GtbThemeProvider.of(context);

    return Padding(
      padding: EdgeInsets.all((size.totalSize - size.internalSize) / 2),
      child: _GlobalLoader(
        color: color ?? theme.appColorScheme.onColorEmphasisHigh,
        size: size.internalSize,
        strokeWidth: switch (size) {
          GtbGlobalLoaderSmallSize.size16 => 0.65,
          GtbGlobalLoaderSmallSize.size24 => 1.0,
        },
      ),
    );
  }
}

final class _GlobalLoader extends StatelessWidget {
  const _GlobalLoader({
    required this.color,
    required this.size,
    required this.strokeWidth,
  });

  final Color color;
  final double size;
  final double strokeWidth;

  @override
  Widget build(BuildContext context) {
    return SizedBox.fromSize(
      size: Size.square(size),
      child: CircularProgressIndicator(
        color: color,
        strokeWidth: strokeWidth,
      ),
    );
  }
}
