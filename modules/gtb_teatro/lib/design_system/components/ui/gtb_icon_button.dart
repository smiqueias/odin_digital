import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gtb_teatro/design_system/color_scheme/color_scheme.dart';
import 'package:gtb_teatro/design_system/color_scheme/color_scheme_provider.dart';
import 'package:gtb_teatro/design_system/components/ui/gtb_border.dart';
import 'package:gtb_teatro/design_system/foundation/lerp.dart';
import 'package:gtb_teatro/design_system/foundation/platform_extension.dart';
import 'package:gtb_teatro/design_system/foundation/typography.dart';
import 'package:gtb_teatro/design_system/models/action_settings.dart';

final class GtbIconButton extends StatelessWidget {
  const GtbIconButton({
    required this.icon,
    super.key,
    this.color,
    this.disabledColor,
    this.minSize,
    this.iconSize,
    this.tooltip,
    this.onPress,
    this.alignment = Alignment.center,
  });

  GtbIconButton.fromActionSettings({
    required GtbIconActionSettings actionSettings,
    super.key,
    this.color,
    this.disabledColor,
    this.minSize,
    this.iconSize,
    this.tooltip,
    this.alignment = Alignment.center,
  }) : icon = Icon(actionSettings.icon),
       onPress = actionSettings.onPress;

  final Widget icon;
  final Color? color;
  final Color? disabledColor;
  final double? minSize;
  final double? iconSize;
  final String? tooltip;
  final VoidCallback? onPress;
  final AlignmentGeometry alignment;

  @override
  Widget build(BuildContext context) {
    final theme = GtbIconButtonTheme.of(context);
    final isIOS = Theme.of(context).platform.isIOS;

    final effectiveColor = onPress == null
        ? (disabledColor ?? theme.disabledColor) //
        : color ?? theme.color;
    final effectiveMinSize = minSize ?? theme.minSize;
    final effectiveIconSize = iconSize ?? theme.iconSize;
    final splashRadius = theme.splashRadius;

    final iconButton = isIOS
        ? CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: onPress,
            alignment: alignment,
            minimumSize: Size.square(effectiveMinSize),
            child: IconTheme(
              data: IconThemeData(
                size: effectiveIconSize,
                color: effectiveColor,
              ),
              child: icon,
            ),
          )
        : IconButton(
            icon: icon,
            onPressed: onPress,
            color: effectiveColor,
            // This is needed to force the disabled color for Android devices.
            disabledColor: effectiveColor,
            iconSize: effectiveIconSize,
            padding: EdgeInsets.zero,
            splashRadius: splashRadius,
            alignment: alignment,
            constraints: BoxConstraints(
              minWidth: effectiveMinSize,
              minHeight: effectiveMinSize,
            ),
            // This needs to be forced so the spacings on desktop look like the
            // ones in mobile devices.
            visualDensity: VisualDensity.standard,
          );

    return tooltip != null
        ? Tooltip(
            message: tooltip,
            child: iconButton,
          )
        : iconButton;
  }
}

final class GtbIconButtonTheme extends InheritedTheme {
  const GtbIconButtonTheme({
    required super.child,
    required this.data,
    super.key,
  });

  final GtbIconButtonThemeData data;

  static GtbIconButtonThemeData of(BuildContext context) {
    final theme = context.dependOnInheritedWidgetOfExactType<GtbIconButtonTheme>();
    return theme?.data ?? GtbThemeProvider.of(context).iconButtonTheme;
  }

  @override
  bool updateShouldNotify(GtbIconButtonTheme oldWidget) {
    return oldWidget.data != data;
  }

  @override
  Widget wrap(BuildContext context, Widget child) {
    return GtbIconButtonTheme(
      data: data,
      child: child,
    );
  }
}

final class GtbIconButtonThemeData {
  GtbIconButtonThemeData({
    required this.color,
    required this.disabledColor,
    required this.minSize,
    required this.iconSize,
    required this.splashRadius,
  });

  final Color color;
  final Color disabledColor;
  final double minSize;
  final double iconSize;
  final double splashRadius;

  static GtbIconButtonThemeData lerp(
    GtbIconButtonThemeData a,
    GtbIconButtonThemeData b,
    double t,
  ) {
    return GtbIconButtonThemeData(
      color: Color.lerp(a.color, b.color, t)!,
      disabledColor: Color.lerp(a.disabledColor, b.disabledColor, t)!,
      minSize: lerpDouble(a.minSize, b.minSize, t),
      iconSize: lerpDouble(a.iconSize, b.iconSize, t),
      splashRadius: lerpDouble(a.splashRadius, b.splashRadius, t),
    );
  }

  GtbIconButtonThemeData copyWith({
    Color? color,
    Color? disabledColor,
    double? minSize,
    double? iconSize,
    double? splashRadius,
  }) {
    return GtbIconButtonThemeData(
      color: color ?? this.color,
      disabledColor: disabledColor ?? this.disabledColor,
      minSize: minSize ?? this.minSize,
      iconSize: iconSize ?? this.iconSize,
      splashRadius: splashRadius ?? this.splashRadius,
    );
  }
}

GtbIconButtonThemeData createDefaultIconButtonTheme({
  required GtbColorScheme colorScheme,
  required GtbBorderThemeData borderTheme,
  required GtbTypography typography,
}) {
  return GtbIconButtonThemeData(
    color: colorScheme.onColorEmphasisHigh,
    disabledColor: colorScheme.onColorEmphasisDisabled,
    minSize: kMinInteractiveDimension,
    iconSize: 24.0,
    splashRadius: 24.0,
  );
}
