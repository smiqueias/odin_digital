import 'package:flutter/material.dart';
import 'package:gtb_teatro/design_system/color_scheme/color_scheme.dart';
import 'package:gtb_teatro/design_system/color_scheme/color_scheme_provider.dart';
import 'package:gtb_teatro/design_system/components/ui/gtb_border.dart';
import 'package:gtb_teatro/design_system/foundation/typography.dart';

enum GtbGlobalProgressBarKind { rounded, squared }

enum GtbGlobalProgressBarStatus { normal, error }

enum GtbGlobalProgressBarSize { small, large }

class GtbGlobalProgressBar extends StatefulWidget {
  const GtbGlobalProgressBar({
    required this.value,
    super.key,
    this.size = .small,
    this.kind = .rounded,
    this.status = .normal,
  }) : assert(
         value >= 0 && value <= 1,
         'The GlobalProgressBar value must be between the range [0,1]',
       );

  final double value;
  final GtbGlobalProgressBarSize size;
  final GtbGlobalProgressBarKind kind;
  final GtbGlobalProgressBarStatus status;

  @override
  State<GtbGlobalProgressBar> createState() => _GtbGlobalProgressBarState();
}

class _GtbGlobalProgressBarState extends State<GtbGlobalProgressBar>
    with SingleTickerProviderStateMixin {
  late double initialValue;
  late GtbGlobalProgressBarStatus? initialStatus;

  @override
  void initState() {
    super.initState();

    initialValue = widget.value;
    initialStatus = widget.status;
  }

  @override
  Widget build(BuildContext context) {
    final theme = GtbThemeProvider.of(context).appColorScheme;

    final radius = switch (widget.kind) {
      GtbGlobalProgressBarKind.rounded => 100.0,
      GtbGlobalProgressBarKind.squared => 0.0,
    };

    final height = switch (widget.size) {
      GtbGlobalProgressBarSize.small => 4.0,
      GtbGlobalProgressBarSize.large => 8.0,
    };

    final resolvedInitialStatus = initialStatus;
    final resolvedStatus = widget.status;

    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: TweenAnimationBuilder(
        tween: Tween<double>(
          begin: initialValue,
          end: widget.value,
        ),
        duration: const Duration(milliseconds: 200),
        builder: (context, value, child) {
          return TweenAnimationBuilder(
            tween: ColorTween(
              begin: _getColorFromStatus(context, widget.status),
              end: _getColorFromStatus(context, resolvedStatus),
            ),
            duration: const Duration(milliseconds: 200),
            builder: (context, color, child) {
              return LinearProgressIndicator(
                value: value,
                color: color,
                minHeight: height,
                backgroundColor: theme.neutralExtended40,
              );
            },
          );
        },
      ),
    );
  }

  Color _getColorFromStatus(BuildContext context, GtbGlobalProgressBarStatus status) {
    final colorScheme = GtbThemeProvider.of(context).appColorScheme;

    return switch (status) {
      GtbGlobalProgressBarStatus.normal => colorScheme.statusInformativeBase,
      GtbGlobalProgressBarStatus.error => colorScheme.statusErrorBase,
    };
  }
}

final class GtbGlobalProgressBarTheme extends InheritedTheme {
  const GtbGlobalProgressBarTheme({
    required super.child,
    required this.data,
    super.key,
  });

  final GtbGlobalProgressBarThemeData data;

  static GtbGlobalProgressBarThemeData of(BuildContext context) {
    final theme = context.dependOnInheritedWidgetOfExactType<GtbGlobalProgressBarTheme>();
    return theme?.data ?? GtbThemeProvider.of(context).globalProgressBarTheme;
  }

  @override
  bool updateShouldNotify(GtbGlobalProgressBarTheme oldWidget) {
    return oldWidget.data != data;
  }

  @override
  Widget wrap(BuildContext context, Widget child) {
    return GtbGlobalProgressBarTheme(
      data: data,
      child: child,
    );
  }
}

final class GtbGlobalProgressBarThemeData {
  GtbGlobalProgressBarThemeData({
    required this.size,
    required this.kind,
    required this.status,
  });

  final GtbGlobalProgressBarSize size;
  final GtbGlobalProgressBarKind kind;
  final GtbGlobalProgressBarStatus status;

  static GtbGlobalProgressBarThemeData lerp(
    GtbGlobalProgressBarThemeData a,
    GtbGlobalProgressBarThemeData b,
    double t,
  ) {
    return GtbGlobalProgressBarThemeData(
      size: t < 0.5 ? a.size : b.size,
      kind: t < 0.5 ? a.kind : b.kind,
      status: t < 0.5 ? a.status : b.status,
    );
  }

  GtbGlobalProgressBarThemeData copyWith({
    GtbGlobalProgressBarSize? size,
    GtbGlobalProgressBarKind? kind,
    GtbGlobalProgressBarStatus? status,
  }) {
    return GtbGlobalProgressBarThemeData(
      size: size ?? this.size,
      kind: kind ?? this.kind,
      status: status ?? this.status,
    );
  }
}

GtbGlobalProgressBarThemeData createDefaultGlobalProgressBarTheme({
  required GtbColorScheme colorScheme,
  required GtbBorderThemeData borderTheme,
  required GtbTypography typography,
}) {
  return GtbGlobalProgressBarThemeData(
    size: GtbGlobalProgressBarSize.small,
    kind: GtbGlobalProgressBarKind.rounded,
    status: GtbGlobalProgressBarStatus.normal,
  );
}
