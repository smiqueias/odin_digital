import 'dart:ui';

import 'package:gtb_teatro/design_system/color_scheme/color_scheme.dart' show GtbColorScheme;

bool isLightColor(Color color) {
  final red = color.r;
  final green = color.g;
  final blue = color.b;
  final double luminance = 0.2126 * red + 0.7152 * green + 0.0722 * blue;
  return luminance > 0.5;
}

Color getEmphasisColorForBackground(GtbColorScheme colorScheme, Color backgroundColor) {
  final isBackgroundLight = isLightColor(backgroundColor);
  final isDefaultEmphasisLight = isLightColor(colorScheme.onColorEmphasisHigh);
  return isBackgroundLight == isDefaultEmphasisLight
      ? (colorScheme.onColorEmphasisHighInverse) //
      : colorScheme.onColorEmphasisHigh;
}
