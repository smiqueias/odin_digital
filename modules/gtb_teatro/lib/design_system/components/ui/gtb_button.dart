import 'package:flutter/material.dart';
import 'package:gtb_teatro/design_system/gtb_teatro.dart';
import 'package:gtb_teatro/design_system/models/action_settings.dart';
import 'package:gtb_teatro/design_system/models/semantics_data.dart';

enum GtbButtonKind {
  primary,
  neutral,
  line,
}

enum GtbButtonSize {
  compact,
  normal,
  fullWidth,
}

enum _ButtonProperty { kind, size }

final class GtbDefaultButtonProperties extends InheritedModel<_ButtonProperty> {
  const GtbDefaultButtonProperties({
    required super.child,
    super.key,
    this.kind,
    this.size,
  });

  static Widget merge({
    required Widget child,
    Key? key,
    GtbButtonKind? kind,
    GtbButtonSize? size,
  }) {
    return Builder(
      builder: (context) {
        final parent = GtbDefaultButtonProperties.maybeOf(context);

        return GtbDefaultButtonProperties(
          key: key,
          kind: kind ?? parent?.kind,
          size: size ?? parent?.size,
          child: child,
        );
      },
    );
  }

  final GtbButtonKind? kind;
  final GtbButtonSize? size;

  static GtbDefaultButtonProperties? maybeOf(BuildContext context, [String? aspect]) {
    return InheritedModel.inheritFrom<GtbDefaultButtonProperties>(context, aspect: aspect);
  }

  static GtbButtonKind? kindOf(BuildContext context) {
    return InheritedModel.inheritFrom<GtbDefaultButtonProperties>(
      context,
      aspect: _ButtonProperty.kind,
    )?.kind;
  }

  static GtbButtonSize? sizeOf(BuildContext context) {
    return InheritedModel.inheritFrom<GtbDefaultButtonProperties>(
      context,
      aspect: _ButtonProperty.size,
    )?.size;
  }

  @override
  bool updateShouldNotify(GtbDefaultButtonProperties oldWidget) {
    if (identical(this, oldWidget)) {
      return false;
    }
    return oldWidget.kind != kind || oldWidget.size != size;
  }

  @override
  bool updateShouldNotifyDependent(
    GtbDefaultButtonProperties oldWidget,
    Set<_ButtonProperty> dependencies,
  ) {
    if (identical(this, oldWidget)) {
      return false;
    }
    return (dependencies.contains(_ButtonProperty.kind) && oldWidget.kind != kind) || //
        (dependencies.contains(_ButtonProperty.size) && oldWidget.size != size);
  }
}

final class GtbButton extends StatelessWidget {
  const GtbButton({
    required this.label,
    super.key,
    this.kind,
    this.size,
    this.leftIcon,
    this.rightIcon,
    this.onPress,
    this.semantics = const GtbSemanticsData(),
  });

  GtbButton.fromActionSettings({
    required GtbActionSettings<VoidCallback> actionSettings,
    super.key,
    this.kind,
    this.size,
  }) : label = Text(actionSettings.text),
       leftIcon = actionSettings.leftIcon == null
           ? null //
           : Icon(actionSettings.leftIcon),
       rightIcon = actionSettings.rightIcon == null
           ? null //
           : Icon(actionSettings.rightIcon),
       semantics = actionSettings.semantics,
       onPress = actionSettings.onPress;

  final Widget label;
  final GtbButtonKind? kind;
  final GtbButtonSize? size;
  final Widget? leftIcon;
  final Widget? rightIcon;
  final VoidCallback? onPress;
  final GtbSemanticsData semantics;

  @override
  Widget build(BuildContext context) {
    final buttonTheme = GtbButtonTheme.of(context);

    final kind = this.kind ?? GtbDefaultButtonProperties.kindOf(context) ?? GtbButtonKind.primary;
    final size = this.size ?? GtbDefaultButtonProperties.sizeOf(context) ?? GtbButtonSize.normal;

    final buttonStyle = switch ((kind, size)) {
      (GtbButtonKind.primary, GtbButtonSize.compact) => buttonTheme.primaryCompactButtonStyle,
      (GtbButtonKind.primary, GtbButtonSize.normal) => buttonTheme.primaryNormalButtonStyle,
      (GtbButtonKind.primary, GtbButtonSize.fullWidth) => buttonTheme.primaryFullWidthButtonStyle,
      (GtbButtonKind.neutral, GtbButtonSize.compact) => buttonTheme.neutralCompactButtonStyle,
      (GtbButtonKind.neutral, GtbButtonSize.normal) => buttonTheme.neutralNormalButtonStyle,
      (GtbButtonKind.neutral, GtbButtonSize.fullWidth) => buttonTheme.neutralFullWidthButtonStyle,
      (GtbButtonKind.line, GtbButtonSize.compact) => buttonTheme.lineCompactButtonStyle,
      (GtbButtonKind.line, GtbButtonSize.normal) => buttonTheme.lineNormalButtonStyle,
      (GtbButtonKind.line, GtbButtonSize.fullWidth) => buttonTheme.lineFullWidthButtonStyle,
    };

    final padding = switch (size) {
      GtbButtonSize.compact => const EdgeInsets.symmetric(
        horizontal: GtbPaddingValue.xs,
        vertical: GtbPaddingValue.xxs,
      ),
      GtbButtonSize.normal => const EdgeInsets.all(GtbPaddingValue.xs),
      GtbButtonSize.fullWidth => const EdgeInsets.all(GtbPaddingValue.xs),
    };

    return GtbIconContainerTheme(
      data: GtbIconContainerTheme.of(context).copyWith(size: GtbIconContainerSize.size16),
      child: Semantics.fromProperties(
        excludeSemantics: semantics.exclude,
        container: semantics.container,
        blockUserActions: semantics.blockUserActions,
        explicitChildNodes: semantics.explicitChildNodes,
        key: semantics.key,
        properties: semantics.properties,
        child: _ButtonBase(
          buttonStyle: buttonStyle,
          onPress: onPress,
          child: ConstrainedBox(
            constraints: const BoxConstraints(minHeight: 16),
            child: Padding(
              padding: padding,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (leftIcon case final leading?) ...[
                    leading,
                    GtbGap.xxs,
                  ],
                  Flexible(
                    child: label,
                  ),
                  if (rightIcon case final trailing?) ...[
                    GtbGap.xxs,
                    trailing,
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

final class GtbButtonInline extends StatelessWidget {
  const GtbButtonInline({
    required this.isSelected,
    required this.label,
    super.key,
    this.leftIcon,
    this.rightIcon,
    this.onPress,
  });

  GtbButtonInline.fromActionSettings({
    required this.isSelected,
    required GtbActionSettings<VoidCallback> actionSettings,
    super.key,
  }) : label = Text(actionSettings.text),
       leftIcon = actionSettings.leftIcon == null
           ? null //
           : Icon(actionSettings.leftIcon),
       rightIcon = actionSettings.rightIcon == null
           ? null //
           : Icon(actionSettings.rightIcon),
       onPress = actionSettings.onPress;

  final bool isSelected;
  final Widget label;
  final Widget? leftIcon;
  final Widget? rightIcon;
  final VoidCallback? onPress;

  @override
  Widget build(BuildContext context) {
    final buttonStyle = GtbButtonTheme.of(context).inlineButtonStyle;

    final resolvedButtonStyle = isSelected
        ? buttonStyle.copyWith(
            backgroundColor: generateState(
              buttonStyle.backgroundColor.resolve({WidgetState.selected}),
              pressed: buttonStyle.backgroundColor.resolve({WidgetState.pressed}),
              disabled: buttonStyle.backgroundColor.resolve({WidgetState.disabled}),
            ),
            foregroundColor: generateState(
              buttonStyle.foregroundColor.resolve({WidgetState.selected}),
              pressed: buttonStyle.foregroundColor.resolve({WidgetState.pressed}),
              disabled: buttonStyle.foregroundColor.resolve({WidgetState.disabled}),
            ),
          )
        : buttonStyle;

    return GtbIconContainerTheme(
      data: GtbIconContainerTheme.of(context).copyWith(size: GtbIconContainerSize.size16),
      child: _ButtonBase(
        buttonStyle: resolvedButtonStyle,
        onPress: onPress,
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 16),
          child: Padding(
            padding: const EdgeInsets.all(GtbPaddingValue.xxs),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (leftIcon case final leading?) ...[
                  leading,
                  GtbGap.xxxs,
                ],
                label,
                if (rightIcon case final trailing?) ...[
                  GtbGap.xxxs,
                  trailing,
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

final class GtbButtonForward extends StatelessWidget {
  const GtbButtonForward({
    super.key,
    this.onPress,
  });

  final VoidCallback? onPress;

  @override
  Widget build(BuildContext context) {
    final buttonStyle = GtbButtonTheme.of(context).forwardButtonStyle;

    return _ButtonBase(
      buttonStyle: buttonStyle,
      onPress: onPress,
      shape: generateState(const CircleBorder()),
      child: const Padding(
        padding: EdgeInsets.all(GtbPaddingValue.xxs),
        child: Icon(GtbIcons.right, size: 24),
      ),
    );
  }
}

enum GtbButtonShortcutKind {
  normal,
  neww,
}

final class GtbButtonShortcut extends StatelessWidget {
  const GtbButtonShortcut({
    required this.kind,
    required this.hasOutline,
    required this.label,
    super.key,
    this.badge,
    this.icon,
    this.onPress,
  });

  final GtbButtonShortcutKind kind;
  final bool hasOutline;
  final Widget label;
  final Widget? badge;
  final Widget? icon;
  final VoidCallback? onPress;

  @override
  Widget build(BuildContext context) {
    final buttonTheme = GtbButtonTheme.of(context);

    GtbButtonStyle buttonStyle = switch (kind) {
      GtbButtonShortcutKind.normal => buttonTheme.normalShortcutButtonStyle,
      GtbButtonShortcutKind.neww => buttonTheme.newShortcutButtonStyle,
    };
    if (!hasOutline) {
      buttonStyle = buttonStyle.copyWith(
        borderSide: generateStateBorderSide(0.0, kTransparentColor),
      );
    }

    return AspectRatio(
      aspectRatio: 1.0,
      child: _ButtonBase(
        buttonStyle: buttonStyle,
        onPress: onPress,
        child: Padding(
          padding: const EdgeInsets.all(GtbPaddingValue.xxs),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (badge case final badge?) badge,
                  GtbGap.xxs,
                  if (icon case final icon?)
                    GtbIconContainerTheme(
                      data: GtbIconContainerTheme.of(
                        context,
                      ).copyWith(size: GtbIconContainerSize.size24),
                      child: icon,
                    ),
                ],
              ),
              GtbGap.xxs,
              DefaultTextStyle.merge(
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                softWrap: false,
                child: label,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

final class _ButtonBase extends StatefulWidget {
  const _ButtonBase({
    required this.buttonStyle,
    required this.child,
    this.shape,
    this.onPress,
  });

  final GtbButtonStyle buttonStyle;
  final WidgetStateProperty<OutlinedBorder>? shape;
  final VoidCallback? onPress;
  final Widget child;

  @override
  State<_ButtonBase> createState() => _ButtonBaseState();
}

final class _ButtonBaseState extends State<_ButtonBase> {
  final statesController = WidgetStatesController();

  @override
  void dispose() {
    statesController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final buttonStyle = widget.buttonStyle;

    final shape =
        widget.shape ??
        WidgetStateProperty.resolveWith((states) {
          return RoundedRectangleBorder(
            borderRadius: buttonStyle.radius,
            side: buttonStyle.borderSide?.resolve(states) ?? BorderSide.none,
          );
        });

    return DecoratedBox(
      decoration: BoxDecoration(boxShadow: buttonStyle.elevation),
      child: ElevatedButton(
        onPressed: widget.onPress,
        statesController: statesController,
        style:
            ElevatedButton.styleFrom(
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              padding: EdgeInsets.zero,
              minimumSize: buttonStyle.minimumSize,
            ).copyWith(
              elevation: WidgetStateProperty.all(0.0),
              backgroundColor: buttonStyle.backgroundColor,
              foregroundColor: buttonStyle.foregroundColor,
              overlayColor: buttonStyle.overlayColor,
              shape: shape,
              iconColor: buttonStyle.iconColor,
              textStyle: buttonStyle.textStyle,
            ),
        child: Builder(
          builder: (context) {
            return DefaultTextStyle(
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: DefaultTextStyle.of(context).style,
              child: widget.child,
            );
          },
        ),
      ),
    );
  }
}

final class GtbButtonFixed extends StatelessWidget {
  const GtbButtonFixed({
    required this.button,
    super.key,
    this.externalLink,
    this.overline,
    this.title,
    this.checkbox,
    this.legalCheckbox,
    this.notification,
    this.defaultLink,
    this.link,
  });

  final GtbLink? externalLink;
  final Widget? overline;
  final Widget? title;
  final GtbCheckboxLabel? checkbox;
  final GtbSubButtonFixedCheckboxAccordion? legalCheckbox;
  final GtbNotificationInline? notification;
  final GtbLink? defaultLink;
  final GtbButton button;
  final GtbLink? link;

  @override
  Widget build(BuildContext context) {
    return GtbBaseButtonFixed(
      externalLink: externalLink,
      overline: overline,
      title: title,
      checkbox: checkbox,
      legalCheckbox: legalCheckbox,
      notification: notification,
      defaultLink: defaultLink,
      button: button,
      link: link,
      hasDivider: true,
    );
  }
}

final class GtbBaseButtonFixed extends StatelessWidget {
  const GtbBaseButtonFixed({
    required this.hasDivider,
    super.key,
    this.externalLink,
    this.overline,
    this.title,
    this.checkbox,
    this.legalCheckbox,
    this.notification,
    this.defaultLink,
    this.button,
    this.link,
    this.semantics = const GtbSemanticsData(),
  });

  final GtbLink? externalLink;
  final Widget? overline;
  final Widget? title;
  final GtbCheckboxLabel? checkbox;
  final GtbSubButtonFixedCheckboxAccordion? legalCheckbox;
  final GtbNotificationInline? notification;
  final GtbLink? defaultLink;
  final GtbButton? button;
  final GtbLink? link;
  final bool hasDivider;
  final GtbSemanticsData semantics;

  bool get _hasContent {
    return externalLink != null || //
        overline != null ||
        title != null ||
        checkbox != null ||
        legalCheckbox != null ||
        notification != null ||
        defaultLink != null ||
        button != null ||
        link != null;
  }

  @override
  Widget build(BuildContext context) {
    if (_hasContent) {
      final theme = GtbThemeProvider.of(context);

      const invisibleBorder = GtbBorderSide(
        color: Color(0x00000000),
        stroke: 1.0,
        borderStyle: GtbSolidBorderStyle(),
      );

      return DecoratedBox(
        decoration: BoxDecoration(
          color: theme.appColorScheme.neutralBase,
          border: hasDivider
              ? GtbBorder(
                  left: invisibleBorder,
                  right: invisibleBorder,
                  top: GtbBorderSide(
                    borderStyle: const GtbBorderStyle.solid(),
                    color: theme.appColorScheme.outlineBase,
                    stroke: theme.borderTheme.strokeThin,
                  ),
                  bottom: invisibleBorder,
                )
              : null,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: GtbPaddingValue.sm),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              GtbGap.sm,
              if (externalLink case final externalLink?) ...[
                externalLink,
                GtbGap.sm,
              ],
              if (overline case final overline?) ...[
                DefaultTextStyle(
                  style: theme.typography.labelTiny.copyWith(
                    color: theme.appColorScheme.onColorEmphasisLow,
                  ),
                  child: overline,
                ),
                if (title != null) GtbGap.xxs else GtbGap.sm,
              ],
              if (title case final title?) ...[
                DefaultTextStyle(
                  style: theme.typography.titleSmall.copyWith(
                    color: theme.appColorScheme.onColorEmphasisHigh,
                  ),
                  child: title,
                ),
                GtbGap.sm,
              ],
              if (checkbox case final checkbox?) ...[
                Transform.translate(
                  offset: const Offset(0.0, -kCheckboxExtraSpacing),
                  child: checkbox,
                ),
                const SizedBox(
                  height: GtbGapValue.sm - 2 * kCheckboxExtraSpacing,
                ),
              ],
              if (legalCheckbox case final legalCheckbox?) ...[
                legalCheckbox,
                GtbGap.sm,
              ],
              if (notification case final notification?) ...[
                notification,
                GtbGap.sm,
              ],
              if (defaultLink case final defaultLink?) ...[
                defaultLink,
                GtbGap.sm,
              ],
              if (button case final button?) ...[
                GtbDefaultButtonProperties(
                  kind: GtbButtonKind.primary,
                  size: GtbButtonSize.fullWidth,
                  child: button,
                ),
                GtbGap.sm,
              ],
              if (link case final link?) ...[
                GtbGap.xxs,
                Center(
                  child: Semantics.fromProperties(
                    excludeSemantics: semantics.exclude,
                    container: semantics.container,
                    blockUserActions: semantics.blockUserActions,
                    explicitChildNodes: semantics.explicitChildNodes,
                    key: semantics.key,
                    properties: semantics.properties,
                    child: link,
                  ),
                ),
                GtbGap.sm,
                if (Theme.of(context).platform.isAndroid) //
                  GtbGap.xxs,
              ],
              const GtbBottomSafeAreaSpacer(),
            ],
          ),
        ),
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}

final class GtbSubButtonFixedCheckboxAccordion extends StatelessWidget {
  const GtbSubButtonFixedCheckboxAccordion({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 50,
      child: Placeholder(),
    );
  }
}

final class GtbButtonTheme extends InheritedTheme {
  const GtbButtonTheme({
    required super.child,
    required this.data,
    super.key,
  });

  final GtbButtonThemeData data;

  static GtbButtonThemeData of(BuildContext context) {
    final theme = context.dependOnInheritedWidgetOfExactType<GtbButtonTheme>();
    return theme?.data ?? GtbThemeProvider.of(context).buttonTheme;
  }

  @override
  bool updateShouldNotify(GtbButtonTheme oldWidget) {
    return oldWidget.data != data;
  }

  @override
  Widget wrap(BuildContext context, Widget child) {
    return GtbButtonTheme(
      data: data,
      child: child,
    );
  }
}

final class GtbButtonThemeData {
  GtbButtonThemeData({
    required this.primaryCompactButtonStyle,
    required this.primaryNormalButtonStyle,
    required this.primaryFullWidthButtonStyle,
    required this.neutralCompactButtonStyle,
    required this.neutralNormalButtonStyle,
    required this.neutralFullWidthButtonStyle,
    required this.lineCompactButtonStyle,
    required this.lineNormalButtonStyle,
    required this.lineFullWidthButtonStyle,
    required this.inlineButtonStyle,
    required this.forwardButtonStyle,
    required this.normalShortcutButtonStyle,
    required this.newShortcutButtonStyle,
  });

  final GtbButtonStyle primaryCompactButtonStyle;
  final GtbButtonStyle primaryNormalButtonStyle;
  final GtbButtonStyle primaryFullWidthButtonStyle;
  final GtbButtonStyle neutralCompactButtonStyle;
  final GtbButtonStyle neutralNormalButtonStyle;
  final GtbButtonStyle neutralFullWidthButtonStyle;
  final GtbButtonStyle lineCompactButtonStyle;
  final GtbButtonStyle lineNormalButtonStyle;
  final GtbButtonStyle lineFullWidthButtonStyle;
  final GtbButtonStyle inlineButtonStyle;
  final GtbButtonStyle forwardButtonStyle;
  final GtbButtonStyle normalShortcutButtonStyle;
  final GtbButtonStyle newShortcutButtonStyle;

  static GtbButtonThemeData lerp(GtbButtonThemeData a, GtbButtonThemeData b, double t) {
    return GtbButtonThemeData(
      primaryCompactButtonStyle: GtbButtonStyle.lerp(
        a.primaryCompactButtonStyle,
        b.primaryCompactButtonStyle,
        t,
      ),
      primaryNormalButtonStyle: GtbButtonStyle.lerp(
        a.primaryNormalButtonStyle,
        b.primaryNormalButtonStyle,
        t,
      ),
      primaryFullWidthButtonStyle: GtbButtonStyle.lerp(
        a.primaryFullWidthButtonStyle,
        b.primaryFullWidthButtonStyle,
        t,
      ),
      neutralCompactButtonStyle: GtbButtonStyle.lerp(
        a.neutralCompactButtonStyle,
        b.neutralCompactButtonStyle,
        t,
      ),
      neutralNormalButtonStyle: GtbButtonStyle.lerp(
        a.neutralNormalButtonStyle,
        b.neutralNormalButtonStyle,
        t,
      ),
      neutralFullWidthButtonStyle: GtbButtonStyle.lerp(
        a.neutralFullWidthButtonStyle,
        b.neutralFullWidthButtonStyle,
        t,
      ),
      lineCompactButtonStyle: GtbButtonStyle.lerp(
        a.lineCompactButtonStyle,
        b.lineCompactButtonStyle,
        t,
      ),
      lineNormalButtonStyle: GtbButtonStyle.lerp(
        a.lineNormalButtonStyle,
        b.lineNormalButtonStyle,
        t,
      ),
      lineFullWidthButtonStyle: GtbButtonStyle.lerp(
        a.lineFullWidthButtonStyle,
        b.lineFullWidthButtonStyle,
        t,
      ),
      inlineButtonStyle: GtbButtonStyle.lerp(a.inlineButtonStyle, b.inlineButtonStyle, t),
      forwardButtonStyle: GtbButtonStyle.lerp(a.forwardButtonStyle, b.forwardButtonStyle, t),
      normalShortcutButtonStyle: GtbButtonStyle.lerp(
        a.normalShortcutButtonStyle,
        b.normalShortcutButtonStyle,
        t,
      ),
      newShortcutButtonStyle: GtbButtonStyle.lerp(
        a.newShortcutButtonStyle,
        b.newShortcutButtonStyle,
        t,
      ),
    );
  }

  GtbButtonThemeData copyWith({
    GtbButtonStyle? primaryCompactButtonStyle,
    GtbButtonStyle? primaryNormalButtonStyle,
    GtbButtonStyle? primaryFullWidthButtonStyle,
    GtbButtonStyle? neutralCompactButtonStyle,
    GtbButtonStyle? neutralNormalButtonStyle,
    GtbButtonStyle? neutralFullWidthButtonStyle,
    GtbButtonStyle? lineCompactButtonStyle,
    GtbButtonStyle? lineNormalButtonStyle,
    GtbButtonStyle? lineFullWidthButtonStyle,
    GtbButtonStyle? inlineButtonStyle,
    GtbButtonStyle? forwardButtonStyle,
    GtbButtonStyle? normalShortcutButtonStyle,
    GtbButtonStyle? newShortcutButtonStyle,
  }) {
    return GtbButtonThemeData(
      primaryCompactButtonStyle: primaryCompactButtonStyle ?? this.primaryCompactButtonStyle,
      primaryNormalButtonStyle: primaryNormalButtonStyle ?? this.primaryNormalButtonStyle,
      primaryFullWidthButtonStyle: primaryFullWidthButtonStyle ?? this.primaryFullWidthButtonStyle,
      neutralCompactButtonStyle: neutralCompactButtonStyle ?? this.neutralCompactButtonStyle,
      neutralNormalButtonStyle: neutralNormalButtonStyle ?? this.neutralNormalButtonStyle,
      neutralFullWidthButtonStyle: neutralFullWidthButtonStyle ?? this.neutralFullWidthButtonStyle,
      lineCompactButtonStyle: lineCompactButtonStyle ?? this.lineCompactButtonStyle,
      lineNormalButtonStyle: lineNormalButtonStyle ?? this.lineNormalButtonStyle,
      lineFullWidthButtonStyle: lineFullWidthButtonStyle ?? this.lineFullWidthButtonStyle,
      inlineButtonStyle: inlineButtonStyle ?? this.inlineButtonStyle,
      forwardButtonStyle: forwardButtonStyle ?? this.forwardButtonStyle,
      normalShortcutButtonStyle: normalShortcutButtonStyle ?? this.normalShortcutButtonStyle,
      newShortcutButtonStyle: newShortcutButtonStyle ?? this.newShortcutButtonStyle,
    );
  }

  GtbButtonThemeData copyAllStylesWith({
    BorderRadius? radius,
    WidgetStateProperty<TextStyle>? textStyle,
    WidgetStateProperty<GtbBorderSide>? borderSide,
    WidgetStateProperty<Color>? backgroundColor,
    WidgetStateProperty<Color>? foregroundColor,
    WidgetStateProperty<Color>? overlayColor,
    List<BoxShadow>? elevation,
    Size? minimumSize,
  }) {
    GtbButtonStyle applyInStyle(GtbButtonStyle style) {
      return style.copyWith(
        radius: radius ?? style.radius,
        textStyle: textStyle ?? style.textStyle,
        borderSide: borderSide ?? style.borderSide,
        backgroundColor: backgroundColor ?? style.backgroundColor,
        foregroundColor: foregroundColor ?? style.foregroundColor,
        overlayColor: overlayColor ?? style.overlayColor,
        elevation: elevation ?? style.elevation,
        minimumSize: minimumSize ?? style.minimumSize,
      );
    }

    return GtbButtonThemeData(
      primaryCompactButtonStyle: applyInStyle(primaryCompactButtonStyle),
      primaryNormalButtonStyle: applyInStyle(primaryNormalButtonStyle),
      primaryFullWidthButtonStyle: applyInStyle(primaryFullWidthButtonStyle),
      neutralCompactButtonStyle: applyInStyle(neutralCompactButtonStyle),
      neutralNormalButtonStyle: applyInStyle(neutralNormalButtonStyle),
      neutralFullWidthButtonStyle: applyInStyle(neutralFullWidthButtonStyle),
      lineCompactButtonStyle: applyInStyle(lineCompactButtonStyle),
      lineNormalButtonStyle: applyInStyle(lineNormalButtonStyle),
      lineFullWidthButtonStyle: applyInStyle(lineFullWidthButtonStyle),
      inlineButtonStyle: applyInStyle(inlineButtonStyle),
      forwardButtonStyle: applyInStyle(forwardButtonStyle),
      normalShortcutButtonStyle: applyInStyle(normalShortcutButtonStyle),
      newShortcutButtonStyle: applyInStyle(newShortcutButtonStyle),
    );
  }
}

final class GtbButtonStyle {
  const GtbButtonStyle({
    required this.radius,
    required this.textStyle,
    required this.borderSide,
    required this.backgroundColor,
    required this.foregroundColor,
    required this.overlayColor,
    required this.iconColor,
    required this.elevation,
    required this.minimumSize,
  });

  final BorderRadius radius;
  final WidgetStateProperty<TextStyle> textStyle;
  final WidgetStateProperty<GtbBorderSide>? borderSide;
  final WidgetStateProperty<Color> backgroundColor;
  final WidgetStateProperty<Color> foregroundColor;
  final WidgetStateProperty<Color> overlayColor;
  final WidgetStateProperty<Color>? iconColor;
  final List<BoxShadow>? elevation;
  final Size minimumSize;

  static GtbButtonStyle lerp(GtbButtonStyle a, GtbButtonStyle b, double t) {
    return GtbButtonStyle(
      radius: BorderRadius.lerp(a.radius, b.radius, t)!,
      textStyle:
          WidgetStateProperty.lerp(a.textStyle, b.textStyle, t, TextStyle.lerp)!
              as WidgetStateProperty<TextStyle>,
      borderSide:
          WidgetStateProperty.lerp(a.borderSide, b.borderSide, t, GtbBorderSide.lerpNullable)!
              as WidgetStateProperty<GtbBorderSide>,
      backgroundColor:
          WidgetStateProperty.lerp(a.backgroundColor, b.backgroundColor, t, Color.lerp)!
              as WidgetStateProperty<Color>,
      foregroundColor:
          WidgetStateProperty.lerp(a.foregroundColor, b.foregroundColor, t, Color.lerp)!
              as WidgetStateProperty<Color>,
      overlayColor:
          WidgetStateProperty.lerp(a.overlayColor, b.overlayColor, t, Color.lerp)!
              as WidgetStateProperty<Color>,
      iconColor:
          WidgetStateProperty.lerp(a.iconColor, b.iconColor, t, Color.lerp)
              as WidgetStateProperty<Color>?,
      elevation: t < 0.5 ? a.elevation : b.elevation,
      minimumSize: Size.lerp(a.minimumSize, b.minimumSize, t)!,
    );
  }

  GtbButtonStyle copyWith({
    BorderRadius? radius,
    WidgetStateProperty<TextStyle>? textStyle,
    WidgetStateProperty<GtbBorderSide>? borderSide,
    WidgetStateProperty<Color>? backgroundColor,
    WidgetStateProperty<Color>? foregroundColor,
    WidgetStateProperty<Color>? overlayColor,
    WidgetStateProperty<Color>? iconColor,
    List<BoxShadow>? elevation,
    Size? minimumSize,
  }) {
    return GtbButtonStyle(
      radius: radius ?? this.radius,
      textStyle: textStyle ?? this.textStyle,
      borderSide: borderSide ?? this.borderSide,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      foregroundColor: foregroundColor ?? this.foregroundColor,
      overlayColor: overlayColor ?? this.overlayColor,
      iconColor: iconColor ?? this.iconColor,
      elevation: elevation ?? this.elevation,
      minimumSize: minimumSize ?? this.minimumSize,
    );
  }
}

GtbButtonThemeData createDefaultButtonTheme({
  required GtbColorScheme colorScheme,
  required GtbTypography typography,
  required GtbBorderThemeData borderTheme,
  bool isInverse = false,
}) {
  final compactTextStyle = WidgetStateProperty.all(typography.labelSmall.copyWith(height: 1.0));
  final normalTextStyle = WidgetStateProperty.all(typography.labelSmall.copyWith(height: 1.0));
  final fullWidthTextStyle = WidgetStateProperty.all(typography.labelBase.copyWith(height: 1.0));

  const compactMinimumSize = Size(0.0, 32.0);
  const normalMinimumSize = Size(0.0, 48.0);
  const fullWidthMinimumSize = Size(double.infinity, 56.0);

  final baseButtonStyle = GtbButtonStyle(
    radius: BorderRadius.all(borderTheme.radiusSmall),
    textStyle: normalTextStyle,
    borderSide: null,
    backgroundColor: generateState(kTransparentColor),
    foregroundColor: generateState(kTransparentColor),
    overlayColor: WidgetStateProperty.all(kTransparentColor),
    iconColor: null,
    elevation: null,
    minimumSize: Size.zero,
  );

  final primaryButtonStyle = baseButtonStyle.copyWith(
    backgroundColor: generateState(
      colorScheme.actionMainEnabled,
      pressed: colorScheme.actionMainPressed,
      disabled: colorScheme.actionDisabledBase,
    ),
    foregroundColor: isInverse
        ? generateState(
            colorScheme.onColorEmphasisHigh,
            pressed: colorScheme.onColorEmphasisHigh,
            disabled: colorScheme.onColorEmphasisDisabled,
          )
        : generateState(
            colorScheme.onColorEmphasisHighInverse,
            pressed: colorScheme.onColorEmphasisHighInverse,
            disabled: colorScheme.onColorEmphasisDisabled,
          ),
  );

  final neutralButtonStyle = baseButtonStyle.copyWith(
    backgroundColor: generateState(
      colorScheme.actionNeutralEnabledInverse,
      pressed: colorScheme.actionNeutralPressedInverse,
      disabled: colorScheme.actionDisabledBase,
    ),
    foregroundColor: generateState(
      colorScheme.onColorEmphasisHighInverse,
      pressed: colorScheme.onColorEmphasisHighInverse,
      disabled: colorScheme.onColorEmphasisDisabled,
    ),
  );

  final lineButtonStyle = baseButtonStyle.copyWith(
    borderSide: generateStateBorderSide(
      borderTheme.strokeThin,
      colorScheme.actionSecondaryEnabled,
      pressedColor: colorScheme.actionSecondaryPressed,
      disabledColor: colorScheme.actionDisabledBase,
      borderStyle: const GtbSolidBorderStyle(),
    ),
    backgroundColor: WidgetStateProperty.all(kTransparentColor),
    foregroundColor: generateState(
      colorScheme.onColorEmphasisHigh,
      pressed: colorScheme.onColorEmphasisHigh,
      disabled: colorScheme.onColorEmphasisDisabled,
    ),
  );

  final inlineButtonStyle = baseButtonStyle.copyWith(
    borderSide: generateStateBorderSide(
      borderTheme.strokeThin,
      colorScheme.outlineBase,
      pressedColor: colorScheme.outlineBase,
      disabledColor: kTransparentColor,
      selectedColor: kTransparentColor,
      borderStyle: const GtbSolidBorderStyle(),
    ),
    backgroundColor: generateState(
      colorScheme.actionNeutralEnabled,
      pressed: colorScheme.actionNeutralPressed,
      disabled: colorScheme.actionDisabledBase,
      selected: colorScheme.actionMainSelected,
    ),
    foregroundColor: isInverse
        ? generateState(
            colorScheme.onColorEmphasisHigh,
            pressed: colorScheme.onColorEmphasisHigh,
            disabled: colorScheme.onColorEmphasisDisabled,
            selected: colorScheme.onColorEmphasisHigh,
          )
        : generateState(
            colorScheme.onColorEmphasisHigh,
            pressed: colorScheme.onColorEmphasisHigh,
            disabled: colorScheme.onColorEmphasisDisabled,
            selected: colorScheme.onColorEmphasisHighInverse,
          ),
  );

  final forwardButtonStyle = baseButtonStyle.copyWith(
    backgroundColor: generateState(
      colorScheme.actionMainEnabled,
      pressed: colorScheme.actionMainPressed,
      disabled: colorScheme.actionDisabledBase,
    ),
    foregroundColor: isInverse
        ? generateState(
            colorScheme.onColorEmphasisHigh,
            pressed: colorScheme.onColorEmphasisHigh,
            disabled: colorScheme.onColorEmphasisDisabled,
          )
        : generateState(
            colorScheme.onColorEmphasisHighInverse,
            pressed: colorScheme.onColorEmphasisHighInverse,
            disabled: colorScheme.onColorEmphasisDisabled,
          ),
    elevation: colorScheme.elevationMedium,
    minimumSize: const Size.square(48.0),
  );

  final normalShortcutButtonStyle = baseButtonStyle.copyWith(
    borderSide: generateStateBorderSide(
      borderTheme.strokeThin,
      colorScheme.outlineBase,
      borderStyle: const GtbSolidBorderStyle(),
    ),
    backgroundColor: generateState(
      colorScheme.actionNeutralEnabled,
      pressed: colorScheme.actionNeutralPressed,
    ),
    foregroundColor: generateState(colorScheme.onColorEmphasisHigh),
    iconColor: generateState(colorScheme.secondaryBase),
  );

  final newShortcutButtonStyle = baseButtonStyle.copyWith(
    borderSide: generateStateBorderSide(
      borderTheme.strokeThin,
      colorScheme.outlineBase,
      borderStyle: borderTheme.dashStyleSmall,
    ),
    backgroundColor: generateState(
      kTransparentColor,
      pressed: colorScheme.actionNeutralPressed,
    ),
    foregroundColor: generateState(colorScheme.onColorEmphasisHigh),
    iconColor: generateState(colorScheme.secondaryBase),
  );

  return GtbButtonThemeData(
    primaryCompactButtonStyle: primaryButtonStyle.copyWith(
      minimumSize: compactMinimumSize,
      textStyle: compactTextStyle,
    ),
    primaryNormalButtonStyle: primaryButtonStyle.copyWith(
      minimumSize: normalMinimumSize,
      textStyle: normalTextStyle,
    ),
    primaryFullWidthButtonStyle: primaryButtonStyle.copyWith(
      minimumSize: fullWidthMinimumSize,
      textStyle: fullWidthTextStyle,
    ),
    neutralCompactButtonStyle: neutralButtonStyle.copyWith(
      minimumSize: compactMinimumSize,
      textStyle: compactTextStyle,
    ),
    neutralNormalButtonStyle: neutralButtonStyle.copyWith(
      minimumSize: normalMinimumSize,
      textStyle: normalTextStyle,
    ),
    neutralFullWidthButtonStyle: neutralButtonStyle.copyWith(
      minimumSize: fullWidthMinimumSize,
      textStyle: fullWidthTextStyle,
    ),
    lineCompactButtonStyle: lineButtonStyle.copyWith(
      minimumSize: compactMinimumSize,
      textStyle: compactTextStyle,
    ),
    lineNormalButtonStyle: lineButtonStyle.copyWith(
      minimumSize: normalMinimumSize,
      textStyle: normalTextStyle,
    ),
    lineFullWidthButtonStyle: lineButtonStyle.copyWith(
      minimumSize: fullWidthMinimumSize,
      textStyle: fullWidthTextStyle,
    ),
    inlineButtonStyle: inlineButtonStyle,
    forwardButtonStyle: forwardButtonStyle,
    normalShortcutButtonStyle: normalShortcutButtonStyle,
    newShortcutButtonStyle: newShortcutButtonStyle,
  );
}
