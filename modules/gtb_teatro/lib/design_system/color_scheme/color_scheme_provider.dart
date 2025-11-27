import 'package:flutter/widgets.dart';
import 'package:gtb_teatro/design_system/color_scheme/color_scheme.dart';
import 'package:gtb_teatro/design_system/fundations/typography.dart';

final class GtbThemeProvider extends InheritedWidget {
  final GtbColorScheme appColorScheme;
  final GtbTypography typography;

  GtbThemeProvider({
    super.key,
    required this.appColorScheme,
    required this.typography,
    required WidgetBuilder builder,
  }) : super(child: Builder(builder: builder));

  static GtbThemeProvider of(BuildContext context) {
    final scheme = context
        .dependOnInheritedWidgetOfExactType<GtbThemeProvider>();

    if (scheme != null) {
      return scheme;
    } else {
      throw Exception("No color scheme");
    }
  }

  @override
  bool updateShouldNotify(GtbThemeProvider oldWidget) {
    return oldWidget.appColorScheme != appColorScheme;
  }
}
