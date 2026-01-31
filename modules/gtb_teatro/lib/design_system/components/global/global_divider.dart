import 'package:flutter/material.dart';
import 'package:gtb_teatro/design_system/color_scheme/color_scheme.dart';
import 'package:gtb_teatro/design_system/color_scheme/color_scheme_provider.dart';
import 'package:gtb_teatro/design_system/components/ui/gtb_border.dart';
import 'package:gtb_teatro/design_system/foundation/lerp.dart';
import 'package:gtb_teatro/design_system/foundation/spacing.dart';
import 'package:gtb_teatro/design_system/foundation/typography.dart';

enum GtbGlobalDividerKind {
  content,
  section,
}

enum GtbGlobalDividerSize {
  thin,
  heavy,
}

final class GtbGlobalDivider extends StatelessWidget {
  const GtbGlobalDivider({
    required this.kind,
    required this.size,
    super.key,
    this.axis = Axis.horizontal,
  });

  final GtbGlobalDividerKind kind;
  final GtbGlobalDividerSize size;
  final Axis axis;

  static const contentThin = GtbGlobalDivider(
    kind: GtbGlobalDividerKind.content,
    size: GtbGlobalDividerSize.thin,
  );
  static const contentHeavy = GtbGlobalDivider(
    kind: GtbGlobalDividerKind.content,
    size: GtbGlobalDividerSize.heavy,
  );
  static const sectionThin = GtbGlobalDivider(
    kind: GtbGlobalDividerKind.section,
    size: GtbGlobalDividerSize.thin,
  );
  static const sectionHeavy = GtbGlobalDivider(
    kind: GtbGlobalDividerKind.section,
    size: GtbGlobalDividerSize.heavy,
  );

  @override
  Widget build(BuildContext context) {
    final theme = GtbDividerTheme.of(context);

    final edgeInsets = switch ((kind, axis)) {
      (GtbGlobalDividerKind.content, Axis.horizontal) => EdgeInsets.only(
        left: theme.indent,
        right: theme.indent,
      ),
      (GtbGlobalDividerKind.content, Axis.vertical) => EdgeInsets.only(
        top: theme.indent,
        bottom: theme.indent,
      ),
      (GtbGlobalDividerKind.section, _) => EdgeInsets.zero,
    };

    final thickness = switch (size) {
      GtbGlobalDividerSize.thin => theme.thinThickness,
      GtbGlobalDividerSize.heavy => theme.heavyThickness,
    };

    return Center(
      child: Container(
        margin: edgeInsets,
        color: theme.color,
        height: axis == Axis.horizontal ? thickness : double.infinity,
        width: axis == Axis.horizontal ? double.infinity : thickness,
      ),
    );
  }
}

final class GtbDividerTheme extends InheritedTheme {
  const GtbDividerTheme({
    required super.child,
    required this.data,
    super.key,
  });

  final GtbDividerThemeData data;

  static GtbDividerThemeData of(BuildContext context) {
    final theme = context.dependOnInheritedWidgetOfExactType<GtbDividerTheme>();
    return theme?.data ?? GtbThemeProvider.of(context).dividerTheme;
  }

  @override
  bool updateShouldNotify(GtbDividerTheme oldWidget) {
    return oldWidget.data != data;
  }

  @override
  Widget wrap(BuildContext context, Widget child) {
    return GtbDividerTheme(
      data: data,
      child: child,
    );
  }
}

final class GtbDividerThemeData {
  GtbDividerThemeData({
    required this.thinThickness,
    required this.heavyThickness,
    required this.indent,
    required this.color,
  });

  final double thinThickness;
  final double heavyThickness;
  final double indent;
  final Color color;

  static GtbDividerThemeData lerp(
    GtbDividerThemeData a,
    GtbDividerThemeData b,
    double t,
  ) {
    return GtbDividerThemeData(
      thinThickness: lerpDouble(a.thinThickness, b.thinThickness, t),
      heavyThickness: lerpDouble(a.heavyThickness, b.heavyThickness, t),
      indent: lerpDouble(a.indent, b.indent, t),
      color: Color.lerp(a.color, b.color, t)!,
    );
  }

  GtbDividerThemeData copyWith({
    double? thinThickness,
    double? heavyThickness,
    double? indent,
    Color? color,
  }) {
    return GtbDividerThemeData(
      thinThickness: thinThickness ?? this.thinThickness,
      heavyThickness: heavyThickness ?? this.heavyThickness,
      indent: indent ?? this.indent,
      color: color ?? this.color,
    );
  }
}

GtbDividerThemeData createDefaultDividerTheme({
  required GtbColorScheme colorScheme,
  required GtbBorderThemeData borderTheme,
  required GtbTypography typography,
}) {
  return GtbDividerThemeData(
    thinThickness: 1.0,
    heavyThickness: 4.0,
    indent: GtbGapValue.sm,
    color: colorScheme.outlineBase.withValues(alpha: 0.16),
  );
}
