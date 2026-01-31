import 'package:flutter/widgets.dart';
import 'package:gtb_teatro/design_system/components/ui/gtb_border.dart';
import 'package:gtb_teatro/design_system/foundation/lerp.dart';
import 'package:gtb_teatro/design_system/gtb_teatro.dart';

enum GtbGlobalStatusBadgeKind {
  on,
  off,
}

class GtbGlobalStatusBadge extends StatelessWidget {
  const GtbGlobalStatusBadge({
    required this.kind,
    super.key,
  });

  const GtbGlobalStatusBadge.on({
    super.key,
  }) : kind = GtbGlobalStatusBadgeKind.on;

  const GtbGlobalStatusBadge.off({
    super.key,
  }) : kind = GtbGlobalStatusBadgeKind.off;

  final GtbGlobalStatusBadgeKind kind;

  @override
  Widget build(BuildContext context) {
    final badgeTheme = GtbStatusBadgeTheme.of(context);

    final style = switch (kind) {
      GtbGlobalStatusBadgeKind.on => badgeTheme.statusOnStyle,
      GtbGlobalStatusBadgeKind.off => badgeTheme.statusOffStyle,
    };

    return DecoratedBox(
      decoration: BoxDecoration(
        color: style.backgroundColor,
        shape: BoxShape.circle,
        border: GtbBorder.all(
          color: style.borderColor,
          stroke: style.borderWidth,
        ),
      ),
      child: SizedBox.square(dimension: style.size),
    );
  }
}

final class GtbStatusBadgeTheme extends InheritedTheme {
  const GtbStatusBadgeTheme({
    required super.child,
    required this.data,
    super.key,
  });

  final GtbStatusBadgeThemeData data;

  static GtbStatusBadgeThemeData of(BuildContext context) {
    final theme = context.dependOnInheritedWidgetOfExactType<GtbStatusBadgeTheme>();
    return theme?.data ?? GtbThemeProvider.of(context).statusBadgeTheme;
  }

  @override
  bool updateShouldNotify(GtbStatusBadgeTheme oldWidget) {
    return oldWidget.data != data;
  }

  @override
  Widget wrap(BuildContext context, Widget child) {
    return GtbStatusBadgeTheme(
      data: data,
      child: child,
    );
  }
}

final class GtbStatusBadgeThemeData {
  GtbStatusBadgeThemeData({
    required this.statusOnStyle,
    required this.statusOffStyle,
  });

  final GtbStatusBadgeStyle statusOnStyle;
  final GtbStatusBadgeStyle statusOffStyle;

  static GtbStatusBadgeThemeData lerp(
    GtbStatusBadgeThemeData a,
    GtbStatusBadgeThemeData b,
    double t,
  ) {
    return GtbStatusBadgeThemeData(
      statusOnStyle: GtbStatusBadgeStyle.lerp(a.statusOnStyle, b.statusOnStyle, t),
      statusOffStyle: GtbStatusBadgeStyle.lerp(a.statusOffStyle, b.statusOffStyle, t),
    );
  }

  GtbStatusBadgeThemeData copyWith({
    GtbStatusBadgeStyle? statusOnStyle,
    GtbStatusBadgeStyle? statusOffStyle,
  }) {
    return GtbStatusBadgeThemeData(
      statusOnStyle: statusOnStyle ?? this.statusOnStyle,
      statusOffStyle: statusOffStyle ?? this.statusOffStyle,
    );
  }
}

final class GtbStatusBadgeStyle {
  GtbStatusBadgeStyle({
    required this.size,
    required this.backgroundColor,
    required this.borderColor,
    required this.borderWidth,
  });

  final double size;
  final Color backgroundColor;
  final Color borderColor;
  final double borderWidth;

  static GtbStatusBadgeStyle lerp(GtbStatusBadgeStyle a, GtbStatusBadgeStyle b, double t) {
    return GtbStatusBadgeStyle(
      size: lerpDouble(a.size, b.size, t),
      backgroundColor: Color.lerp(a.backgroundColor, b.backgroundColor, t)!,
      borderColor: Color.lerp(a.borderColor, b.borderColor, t)!,
      borderWidth: lerpDouble(a.borderWidth, b.borderWidth, t),
    );
  }
}

GtbStatusBadgeThemeData createDefaultStatusBadgeTheme({
  required GtbColorScheme colorScheme,
  required GtbBorderThemeData borderTheme,
  required GtbTypography typography,
}) {
  return GtbStatusBadgeThemeData(
    statusOnStyle: GtbStatusBadgeStyle(
      size: 8.0,
      backgroundColor: colorScheme.statusSuccessBase,
      borderColor: colorScheme.outlineBase,
      borderWidth: borderTheme.strokeHairline,
    ),
    statusOffStyle: GtbStatusBadgeStyle(
      size: 8.0,
      backgroundColor: colorScheme.actionDisabledBase,
      borderColor: colorScheme.outlineBase,
      borderWidth: borderTheme.strokeHairline,
    ),
  );
}
