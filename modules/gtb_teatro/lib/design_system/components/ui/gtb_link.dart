import 'package:flutter/material.dart';
import 'package:gtb_teatro/design_system/gtb_teatro.dart';
import 'package:gtb_teatro/design_system/models/action_settings.dart';
import 'package:gtb_teatro/design_system/models/semantics_data.dart';

enum GtbLinkKind {
  neutral,
  primary,
}

enum GtbLinkSize {
  large,
  small,
}

class GtbLink extends StatelessWidget {
  const GtbLink({
    required this.label,
    super.key,
    this.leftIcon,
    this.rightIcon,
    this.kind = GtbLinkKind.neutral,
    this.size,
    this.isUnderline = false,
    this.onPress,
    this.semantics = const GtbSemanticsData(),
  });

  GtbLink.fromActionSettings({
    required GtbActionSettings<VoidCallback> actionSettings,
    super.key,
    this.kind = GtbLinkKind.neutral,
    this.size,
    this.isUnderline = false,
    this.semantics = const GtbSemanticsData(),
  }) : label = Text(actionSettings.text),
       leftIcon = actionSettings.leftIcon == null
           ? null //
           : Icon(actionSettings.leftIcon),
       rightIcon = actionSettings.rightIcon == null
           ? null //
           : Icon(actionSettings.rightIcon),
       onPress = actionSettings.onPress;

  final GtbLinkKind kind;
  final GtbLinkSize? size;
  final Widget label;
  final Widget? leftIcon;
  final Widget? rightIcon;
  final bool isUnderline;
  final VoidCallback? onPress;
  final GtbSemanticsData semantics;

  @override
  Widget build(BuildContext context) {
    final colorScheme = GtbThemeProvider.of(context).appColorScheme;
    final linkTheme = GtbThemeProvider.of(context).linkTheme;

    final linkStyle = switch (kind) {
      GtbLinkKind.neutral => linkTheme.neutralLinkStyle,
      GtbLinkKind.primary => linkTheme.primaryLinkStyle,
    };

    final size = this.size ?? linkTheme.size;

    final textStyle = switch ((size, isUnderline)) {
      (GtbLinkSize.large, false) => linkStyle.largeTextStyle,
      (GtbLinkSize.large, true) => linkStyle.largeUnderlineTextStyle,
      (GtbLinkSize.small, false) => linkStyle.smallTextStyle,
      (GtbLinkSize.small, true) => linkStyle.smallUnderlineTextStyle,
    };

    final foregroundColor = WidgetStateProperty.resolveWith(
      (states) {
        final resolvedTextStyleData = linkStyle.largeTextStyle.resolve(states);
        return resolvedTextStyleData.color ?? colorScheme.onColorEmphasisHigh;
      },
    );

    return Semantics.fromProperties(
      excludeSemantics: semantics.exclude,
      container: semantics.container,
      properties: semantics.properties,
      blockUserActions: semantics.blockUserActions,
      key: semantics.key,
      explicitChildNodes: semantics.explicitChildNodes,
      child: TextButton(
        style: ButtonStyle(
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          textStyle: textStyle,
          padding: generateState(EdgeInsets.zero),
          iconSize: generateState(linkStyle.iconSize.value),
          iconColor: WidgetStateProperty.resolveWith(
            (states) {
              final resolvedTextStyleData = textStyle.resolve(states);
              return resolvedTextStyleData.color ?? colorScheme.onColorEmphasisHigh;
            },
          ),
          foregroundColor: foregroundColor,
          minimumSize: const WidgetStatePropertyAll(Size.zero),
          overlayColor: generateState(kTransparentColor),
        ),
        onPressed: onPress,
        child: Builder(
          builder: (context) {
            return GtbIconContainerTheme(
              data: GtbIconContainerTheme.of(context).copyWith(
                size: linkStyle.iconSize,
                foregroundColor: IconTheme.of(context).color,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (leftIcon case final leftIcon?) ...[
                    leftIcon,
                    SizedBox(width: linkTheme.iconSpacing),
                  ],
                  Flexible(
                    child: label,
                  ),
                  if (rightIcon case final rightIcon?) ...[
                    SizedBox(width: linkTheme.iconSpacing),
                    rightIcon,
                  ],
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

final class GtbLinkTheme extends InheritedTheme {
  const GtbLinkTheme({
    required super.child,
    required this.data,
    super.key,
  });

  final GtbLinkThemeData data;

  static GtbLinkThemeData of(BuildContext context) {
    final theme = context.dependOnInheritedWidgetOfExactType<GtbLinkTheme>();
    return theme?.data ?? GtbThemeProvider.of(context).linkTheme;
  }

  @override
  bool updateShouldNotify(GtbLinkTheme oldWidget) {
    return oldWidget.data != data;
  }

  @override
  Widget wrap(BuildContext context, Widget child) {
    return GtbLinkTheme(
      data: data,
      child: child,
    );
  }
}

final class GtbLinkThemeData {
  const GtbLinkThemeData({
    required this.neutralLinkStyle,
    required this.primaryLinkStyle,
    required this.size,
    required this.iconSpacing,
  });

  final GtbLinkStyle neutralLinkStyle;
  final GtbLinkStyle primaryLinkStyle;
  final GtbLinkSize size;
  final double iconSpacing;

  static GtbLinkThemeData lerp(GtbLinkThemeData a, GtbLinkThemeData b, double t) {
    return GtbLinkThemeData(
      neutralLinkStyle: GtbLinkStyle.lerp(a.neutralLinkStyle, b.neutralLinkStyle, t),
      primaryLinkStyle: GtbLinkStyle.lerp(a.primaryLinkStyle, b.primaryLinkStyle, t),
      size: t < 0.5 ? a.size : b.size,
      iconSpacing: lerpDouble(a.iconSpacing, b.iconSpacing, t),
    );
  }

  GtbLinkThemeData copyWith({
    GtbLinkStyle? neutralLinkStyle,
    GtbLinkStyle? primaryLinkStyle,
    GtbLinkSize? size,
    double? iconSpacing,
  }) {
    return GtbLinkThemeData(
      neutralLinkStyle: neutralLinkStyle ?? this.neutralLinkStyle,
      primaryLinkStyle: primaryLinkStyle ?? this.primaryLinkStyle,
      size: size ?? this.size,
      iconSpacing: iconSpacing ?? this.iconSpacing,
    );
  }
}

final class GtbLinkStyle {
  const GtbLinkStyle({
    required this.largeTextStyle,
    required this.smallTextStyle,
    required this.largeUnderlineTextStyle,
    required this.smallUnderlineTextStyle,
    required this.iconSize,
  });

  final WidgetStateProperty<TextStyle> largeTextStyle;
  final WidgetStateProperty<TextStyle> smallTextStyle;
  final WidgetStateProperty<TextStyle> largeUnderlineTextStyle;
  final WidgetStateProperty<TextStyle> smallUnderlineTextStyle;
  final GtbIconContainerSize iconSize;

  static GtbLinkStyle lerp(GtbLinkStyle a, GtbLinkStyle b, double t) {
    return GtbLinkStyle(
      largeTextStyle:
          WidgetStateProperty.lerp(
                a.largeTextStyle,
                b.largeTextStyle,
                t,
                TextStyle.lerp,
              )!
              as WidgetStateProperty<TextStyle>,
      smallTextStyle:
          WidgetStateProperty.lerp(
                a.smallTextStyle,
                b.smallTextStyle,
                t,
                TextStyle.lerp,
              )!
              as WidgetStateProperty<TextStyle>,
      largeUnderlineTextStyle:
          WidgetStateProperty.lerp(
                a.largeUnderlineTextStyle,
                b.largeUnderlineTextStyle,
                t,
                TextStyle.lerp,
              )!
              as WidgetStateProperty<TextStyle>,
      smallUnderlineTextStyle:
          WidgetStateProperty.lerp(
                a.smallUnderlineTextStyle,
                b.smallUnderlineTextStyle,
                t,
                TextStyle.lerp,
              )!
              as WidgetStateProperty<TextStyle>,
      iconSize: GtbIconContainerSize.lerp(a.iconSize, b.iconSize, t)!,
    );
  }

  GtbLinkStyle copyWith({
    WidgetStateProperty<TextStyle>? largeTextStyle,
    WidgetStateProperty<TextStyle>? smallTextStyle,
    WidgetStateProperty<TextStyle>? largeUnderlineTextStyle,
    WidgetStateProperty<TextStyle>? smallUnderlineTextStyle,
    GtbIconContainerSize? iconSize,
  }) {
    return GtbLinkStyle(
      largeTextStyle: largeTextStyle ?? this.largeTextStyle,
      smallTextStyle: smallTextStyle ?? this.smallTextStyle,
      largeUnderlineTextStyle: largeUnderlineTextStyle ?? this.largeUnderlineTextStyle,
      smallUnderlineTextStyle: smallUnderlineTextStyle ?? this.smallUnderlineTextStyle,
      iconSize: iconSize ?? this.iconSize,
    );
  }
}

GtbLinkThemeData createDefaultLinkTheme({
  required GtbColorScheme colorScheme,
  required GtbBorderThemeData borderTheme,
  required GtbTypography typography,
}) {
  WidgetStateProperty<TextStyle> createTextStyleState(GtbLinkKind kind, TextStyle baseTextStyle) {
    return generateState(
      baseTextStyle.copyWith(
        color: switch (kind) {
          GtbLinkKind.neutral => colorScheme.onColorEmphasisHigh,
          GtbLinkKind.primary => colorScheme.actionSecondaryEnabled,
        },
      ),
      pressed: baseTextStyle.copyWith(
        color: switch (kind) {
          GtbLinkKind.neutral => colorScheme.onColorEmphasisLow,
          GtbLinkKind.primary => colorScheme.actionSecondaryPressed,
        },
      ),
      disabled: baseTextStyle.copyWith(
        color: switch (kind) {
          GtbLinkKind.neutral => colorScheme.onColorEmphasisDisabled,
          GtbLinkKind.primary => colorScheme.onColorEmphasisDisabled,
        },
      ),
    );
  }

  return GtbLinkThemeData(
    neutralLinkStyle: GtbLinkStyle(
      largeTextStyle: createTextStyleState(GtbLinkKind.neutral, typography.labelBase),
      smallTextStyle: createTextStyleState(GtbLinkKind.neutral, typography.labelSmall),
      largeUnderlineTextStyle: createTextStyleState(
        GtbLinkKind.neutral,
        typography.labelBaseUnderline,
      ),
      smallUnderlineTextStyle: createTextStyleState(
        GtbLinkKind.neutral,
        typography.labelSmallUnderline,
      ),
      iconSize: GtbIconContainerSize.size16,
    ),
    primaryLinkStyle: GtbLinkStyle(
      largeTextStyle: createTextStyleState(GtbLinkKind.primary, typography.titleSmall),
      smallTextStyle: createTextStyleState(GtbLinkKind.primary, typography.labelSmall),
      largeUnderlineTextStyle: createTextStyleState(
        GtbLinkKind.primary,
        typography.labelBaseUnderline,
      ),
      smallUnderlineTextStyle: createTextStyleState(
        GtbLinkKind.primary,
        typography.labelSmallUnderline,
      ),
      iconSize: GtbIconContainerSize.size16,
    ),
    size: GtbLinkSize.large,
    iconSpacing: GtbGapValue.xxxs,
  );
}
