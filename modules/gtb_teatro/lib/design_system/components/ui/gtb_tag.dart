import 'package:flutter/material.dart';
import 'package:gtb_teatro/design_system/gtb_teatro.dart';

final class GtbTagFilter extends StatelessWidget {
  const GtbTagFilter({
    required this.label,
    super.key,
    this.isSelected = false,
    this.onChanged,
  });

  final Widget label;
  final bool isSelected;
  final ValueChanged<bool>? onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = GtbThemeProvider.of(context);
    final tagTheme = GtbTagTheme.of(context);
    final tagStyle = tagTheme.tagStyle;

    return _GtbTag(
      isSelected: isSelected,
      onChanged: onChanged,
      builder: (context, states, child) {
        return DefaultTextStyle(
          style: theme.typography.labelSmall.copyWith(
            color: tagStyle.labelColor.resolve(states),
          ),
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: tagStyle.backgroundColor.resolve(states),
              border: Border.all(color: tagStyle.borderColor.resolve(states)),
              borderRadius: BorderRadius.all(tagStyle.borderRadius),
            ),
            child: child,
          ),
        );
      },
      child: Padding(
        padding: tagStyle.innerPadding,
        child: label,
      ),
    );
  }
}

final class GtbTagSearch extends StatelessWidget {
  const GtbTagSearch({
    required this.label,
    super.key,
    this.onTap,
  });

  final Widget label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = GtbThemeProvider.of(context);
    final tagTheme = GtbTagTheme.of(context);
    final tagStyle = tagTheme.tagStyle;
    final onTap = this.onTap;

    return _GtbTag(
      isSelected: true,
      onChanged: onTap != null
          ? ((value) => onTap()) //
          : null,
      child: Padding(
        padding: tagStyle.innerPadding,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            label,
            GtbGap.xxxs,
            const Icon(
              GtbIcons.close,
              size: 16.0,
            ),
          ],
        ),
      ),
      builder: (context, states, child) {
        final labelColor = tagStyle.labelColor.resolve(states);

        return DefaultTextStyle(
          style: theme.typography.labelSmall.copyWith(color: labelColor),
          child: GtbIconContainerTheme(
            data: GtbIconContainerTheme.of(context).copyWith(foregroundColor: labelColor),
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: tagStyle.backgroundColor.resolve(states),
                border: Border.all(color: tagStyle.borderColor.resolve(states)),
                borderRadius: BorderRadius.all(tagStyle.borderRadius),
              ),
              child: child,
            ),
          ),
        );
      },
    );
  }
}

class _GtbTag extends StatefulWidget {
  const _GtbTag({
    required this.builder,
    required this.isSelected,
    this.child,
    this.onChanged,
  });

  final ValueWidgetBuilder<Set<WidgetState>> builder;
  final Widget? child;
  final bool isSelected;
  final ValueChanged<bool>? onChanged;

  @override
  State<_GtbTag> createState() => _GtbTagState();
}

class _GtbTagState extends State<_GtbTag> {
  late bool _isSelected = widget.isSelected;
  late bool _isEnabled = widget.onChanged != null;
  bool _isPressed = false;

  @override
  void didUpdateWidget(_GtbTag oldWidget) {
    super.didUpdateWidget(oldWidget);

    final isSelected = widget.isSelected;
    final isEnabled = widget.onChanged != null;

    if (_isSelected != isSelected || _isEnabled != isEnabled) {
      _isSelected = isSelected;
      _isEnabled = isEnabled;
      if (!isEnabled) {
        _isPressed = false;
      }
    }
  }

  void _onUpdatePressed({required bool value}) {
    if (_isEnabled && _isPressed != value) {
      setState(() => _isPressed = value);
    }
  }

  @override
  Widget build(BuildContext context) {
    final onChanged = widget.onChanged;
    final states = <WidgetState>{
      if (_isSelected) WidgetState.selected,
      if (_isPressed) WidgetState.pressed,
      if (!_isEnabled) WidgetState.disabled,
    };

    return GtbInkWell(
      onTapDown: (details) => _onUpdatePressed(value: true),
      onTapUp: (details) => _onUpdatePressed(value: false),
      onTapCancel: () => _onUpdatePressed(value: false),
      onTap: onChanged == null
          ? null //
          : () => onChanged(!_isSelected),
      child: widget.builder(context, states, widget.child),
    );
  }
}

final class GtbTagTheme extends InheritedTheme {
  const GtbTagTheme({
    required super.child,
    required this.data,
    super.key,
  });

  final GtbTagThemeData data;

  static GtbTagThemeData of(BuildContext context) {
    final theme = context.dependOnInheritedWidgetOfExactType<GtbTagTheme>();
    return theme?.data ?? GtbThemeProvider.of(context).tagTheme;
  }

  @override
  bool updateShouldNotify(GtbTagTheme oldWidget) {
    return oldWidget.data != data;
  }

  @override
  Widget wrap(BuildContext context, Widget child) {
    return GtbTagTheme(
      data: data,
      child: child,
    );
  }
}

final class GtbTagThemeData {
  GtbTagThemeData({required this.tagStyle});

  final GtbTagStyle tagStyle;

  static GtbTagThemeData lerp(GtbTagThemeData a, GtbTagThemeData b, double t) {
    return GtbTagThemeData(
      tagStyle: GtbTagStyle.lerp(a.tagStyle, b.tagStyle, t),
    );
  }

  GtbTagThemeData copyWith({GtbTagStyle? tagStyle}) {
    return GtbTagThemeData(
      tagStyle: tagStyle ?? this.tagStyle,
    );
  }

  GtbTagThemeData copyAllStylesWith({
    EdgeInsets? innerPadding,
    Radius? borderRadius,
    WidgetStateProperty<Color>? backgroundColor,
    WidgetStateProperty<Color>? borderColor,
    WidgetStateProperty<Color>? labelColor,
  }) {
    return GtbTagThemeData(
      tagStyle: tagStyle.copyWith(
        innerPadding: innerPadding ?? tagStyle.innerPadding,
        borderRadius: borderRadius ?? tagStyle.borderRadius,
        backgroundColor: backgroundColor ?? tagStyle.backgroundColor,
        borderColor: borderColor ?? tagStyle.borderColor,
        labelColor: labelColor ?? tagStyle.labelColor,
      ),
    );
  }
}

final class GtbTagStyle {
  const GtbTagStyle({
    required this.innerPadding,
    required this.borderRadius,
    required this.backgroundColor,
    required this.borderColor,
    required this.labelColor,
  });

  final EdgeInsets innerPadding;
  final Radius borderRadius;
  final WidgetStateProperty<Color> backgroundColor;
  final WidgetStateProperty<Color> borderColor;
  final WidgetStateProperty<Color> labelColor;

  static GtbTagStyle lerp(GtbTagStyle a, GtbTagStyle b, double t) {
    return GtbTagStyle(
      innerPadding: EdgeInsets.lerp(a.innerPadding, b.innerPadding, t)!,
      borderRadius: Radius.lerp(a.borderRadius, b.borderRadius, t)!,
      backgroundColor: WidgetStateProperty.lerp(a.backgroundColor, b.backgroundColor, t, Color.lerp)! as WidgetStateProperty<Color>,
      borderColor: WidgetStateProperty.lerp(a.borderColor, b.borderColor, t, Color.lerp)! as WidgetStateProperty<Color>,
      labelColor: WidgetStateProperty.lerp(a.labelColor, b.labelColor, t, Color.lerp)! as WidgetStateProperty<Color>,
    );
  }

  GtbTagStyle copyWith({
    EdgeInsets? innerPadding,
    Radius? borderRadius,
    WidgetStateProperty<Color>? backgroundColor,
    WidgetStateProperty<Color>? borderColor,
    WidgetStateProperty<Color>? labelColor,
  }) {
    return GtbTagStyle(
      innerPadding: innerPadding ?? this.innerPadding,
      borderRadius: borderRadius ?? this.borderRadius,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      borderColor: borderColor ?? this.borderColor,
      labelColor: labelColor ?? this.labelColor,
    );
  }
}

GtbTagThemeData createDefaultTagTheme({
  required GtbColorScheme colorScheme,
  required bool isInverse,
  required GtbBorderThemeData borderTheme,
  required GtbTypography typography,
}) {
  return GtbTagThemeData(
    tagStyle: GtbTagStyle(
      innerPadding: const EdgeInsets.all(GtbPaddingValue.xxs),
      borderRadius: borderTheme.radiusSmall,
      backgroundColor: generateState(
        colorScheme.actionNeutralEnabled,
        selected: colorScheme.actionSecondarySelected,
        pressed: colorScheme.actionNeutralPressed,
        pressedAndSelected: colorScheme.actionNeutralPressed,
        disabled: colorScheme.actionDisabledBase,
      ),
      borderColor: generateState(
        colorScheme.outlineBase,
        disabled: kTransparentColor,
      ),
      labelColor: generateState(
        colorScheme.onColorEmphasisHigh,
        selected: colorScheme.onColorEmphasisHighInverse,
        pressed: colorScheme.onColorEmphasisHigh,
        pressedAndSelected: colorScheme.onColorEmphasisHigh,
        disabled: colorScheme.onColorEmphasisDisabled,
      ),
    ),
  );
}
