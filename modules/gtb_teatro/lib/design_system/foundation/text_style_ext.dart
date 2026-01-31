import 'package:flutter/rendering.dart';

extension TextStyleExtension on TextStyle {
  double get verticalSpacing => (height ?? 0.0) * (fontSize ?? 0.0);
}
