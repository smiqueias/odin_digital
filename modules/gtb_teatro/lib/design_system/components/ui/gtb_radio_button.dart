import 'package:flutter/widgets.dart';
import 'package:gtb_teatro/design_system/gtb_teatro.dart';

const _kToggleDuration = Duration(milliseconds: 150);

enum GtbRadioButtonPosition {
  left,
  right,
}

class GtbRadioButton<T> extends StatelessWidget {
  const GtbRadioButton({
    required this.value,
    super.key,
    this.selectedValue,
    this.autofocus = false,
    this.focusNode,
    this.mouseCursor,
    this.onChanged,
  });

  final T value;
  final T? selectedValue;
  final bool autofocus;
  final FocusNode? focusNode;
  final MouseCursor? mouseCursor;
  final ValueChanged<T?>? onChanged;

  @override
  Widget build(BuildContext context) {
    final style = GtbRadioButtonTheme.of(context).radioButtonStyle;

    return _GtbRadioButtonActionHandler(
      value: value,
      selectedValue: selectedValue,
      onChanged: onChanged,
      style: style,
      builder: (context, states) {
        return Padding(
          padding: style.padding,
          child: _GtbRadioButton(
            isEnabled: onChanged != null,
            state: _GtbRadioButtonInternalState.from(
              style: style,
              states: states,
              isSelected: value == selectedValue,
            ),
          ),
        );
      },
    );
  }
}

class GtbRadioButtonLabel<T> extends StatelessWidget {
  const GtbRadioButtonLabel({
    required this.label,
    required this.value,
    super.key,
    this.selectedValue,
    this.position = GtbRadioButtonPosition.right,
    this.onChanged,
  });

  final String label;
  final T value;
  final T? selectedValue;
  final GtbRadioButtonPosition position;
  final ValueChanged<T?>? onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = GtbThemeProvider.of(context);
    final style = theme.radioButtonTheme.radioButtonStyle;

    return _GtbRadioButtonActionHandler(
      value: value,
      selectedValue: selectedValue,
      style: style,
      onChanged: onChanged,
      shouldUseOutsideInkResponse: true,
      builder: (context, states) {
        return Padding(
          padding: EdgeInsets.only(
            top: style.padding.top,
            bottom: style.padding.bottom,
          ),
          child: Row(
            textDirection: position == GtbRadioButtonPosition.left
                ? (TextDirection.ltr) //
                : TextDirection.rtl,
            children: [
              _GtbRadioButton(
                isEnabled: onChanged != null,
                state: _GtbRadioButtonInternalState.from(
                  style: style,
                  states: states,
                  isSelected: value == selectedValue,
                ),
              ),
              GtbGap.xxs,
              Expanded(
                child: Text(
                  label,
                  style: theme.typography.bodyBase.copyWith(
                    color: style.labelColor.resolve(states),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class GtbRadioButtonCard<T> extends StatelessWidget {
  const GtbRadioButtonCard({
    required this.value,
    super.key,
    this.number,
    this.label,
    this.icon,
    this.selectedValue,
    this.onChanged,
  }) : assert(
         number != null || label != null,
         'At least one of `number` or `label` must be provided!',
       );

  final Widget? number;
  final Widget? label;
  final GtbIconContainer? icon;
  final T value;
  final T? selectedValue;
  final ValueChanged<T?>? onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = GtbThemeProvider.of(context);
    final style = theme.radioButtonTheme.radioButtonCardStyle;

    return _GtbRadioButtonActionHandler(
      value: value,
      selectedValue: selectedValue,
      onChanged: onChanged,
      style: style,
      builder: (context, states) {
        return DecoratedBox(
          decoration: BoxDecoration(
            color: style.backgroundColor.resolve(states),
            borderRadius: const BorderRadius.all(Radius.circular(GtbGapValue.xxxs)),
            border: style.border.resolve(states),
          ),
          child: AspectRatio(
            aspectRatio: 1.0,
            child: Padding(
              padding: style.padding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      if (icon case final icon?) //
                        GtbIconContainerTheme(
                          data: theme.iconContainerTheme.copyWith(
                            backgroundColor: theme.appColorScheme.onColorEmphasisHigh,
                            size: GtbIconContainerSize.size32,
                          ),
                          child: icon,
                        ),
                      Align(
                        alignment: Alignment.topRight,
                        child: _GtbRadioButton(
                          isEnabled: onChanged != null,
                          state: _GtbRadioButtonInternalState.from(
                            style: style,
                            states: states,
                            isSelected: value == selectedValue,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  if (number case final number?) //
                    DefaultTextStyle(
                      overflow: TextOverflow.ellipsis,
                      style: theme.typography.titleBase.copyWith(
                        color: style.labelColor.resolve(states),
                      ),
                      child: number,
                    ),
                  if (label case final label?) //
                    DefaultTextStyle(
                      overflow: TextOverflow.ellipsis,
                      style: theme.typography.bodySmall.copyWith(
                        color: style.labelColor.resolve(states),
                      ),
                      child: label,
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class GtbRadioButtonBox<T> extends StatelessWidget {
  const GtbRadioButtonBox({
    required this.label,
    required this.value,
    super.key,
    this.selectedValue,
    this.paragraph,
    this.onChanged,
  });

  final String label;
  final String? paragraph;
  final T value;
  final T? selectedValue;
  final ValueChanged<T?>? onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = GtbThemeProvider.of(context);
    final style = theme.radioButtonTheme.radioButtonBoxStyle;

    return _GtbRadioButtonActionHandler(
      value: value,
      selectedValue: selectedValue,
      onChanged: onChanged,
      style: style,
      builder: (context, states) {
        return DecoratedBox(
          decoration: BoxDecoration(
            color: style.backgroundColor.resolve(states),
            borderRadius: BorderRadius.all(style.borderRadius),
            border: style.border.resolve(states),
          ),
          child: Padding(
            padding: style.padding,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        label,
                        style: theme.typography.bodyBase.copyWith(
                          color: style.labelColor.resolve(states),
                        ),
                      ),
                      if (paragraph case final paragraph?) //
                        Padding(
                          padding: const EdgeInsets.only(top: GtbPaddingValue.xxxs),
                          child: Text(
                            paragraph,
                            style: theme.typography.bodySmall.copyWith(
                              color: style.labelColor.resolve(states),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                GtbGap.xxs,
                _GtbRadioButton(
                  isEnabled: onChanged != null,
                  state: _GtbRadioButtonInternalState.from(
                    style: style,
                    states: states,
                    isSelected: value == selectedValue,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

typedef _GtbRadioButtonBuilder = Widget Function(BuildContext context, Set<WidgetState> states);

class _GtbRadioButtonActionHandler<T> extends StatefulWidget {
  const _GtbRadioButtonActionHandler({
    required this.builder,
    required this.value,
    required this.style,
    this.shouldUseOutsideInkResponse = false,
    this.selectedValue,
    this.onChanged,
  });

  final _GtbRadioButtonBuilder builder;
  final T value;
  final T? selectedValue;
  final bool shouldUseOutsideInkResponse;
  final ValueChanged<T?>? onChanged;
  final GtbRadioButtonStyle style;

  @override
  State<_GtbRadioButtonActionHandler<T>> createState() => _GtbRadioButtonActionHandlerState();
}

class _GtbRadioButtonActionHandlerState<T> extends State<_GtbRadioButtonActionHandler<T>> {
  late bool _isSelected = widget.value == widget.selectedValue;
  late bool _isEnabled = widget.onChanged != null;
  bool _isPressed = false;

  @override
  void didUpdateWidget(_GtbRadioButtonActionHandler<T> oldWidget) {
    super.didUpdateWidget(oldWidget);

    final isSelected = widget.value == widget.selectedValue;
    final isEnabled = widget.onChanged != null;

    if (_isSelected != isSelected || _isEnabled != isEnabled) {
      setState(() {
        _isSelected = isSelected;
        _isEnabled = isEnabled;
        if (!isEnabled) {
          _isPressed = false;
        }
      });
    }
  }

  void _onUpdatePressed({required bool value}) {
    if (_isEnabled && (_isPressed != value)) {
      setState(() => _isPressed = value);
    }
  }

  @override
  Widget build(BuildContext context) {
    final states = <WidgetState>{
      if (_isSelected) WidgetState.selected,
      if (_isPressed) WidgetState.pressed,
      if (!_isEnabled) WidgetState.disabled,
    };

    if (widget.shouldUseOutsideInkResponse) {
      return GtbInkWell.outsideResponse(
        verticalSplashOverflow: 0.0,
        borderRadius: BorderRadius.all(widget.style.borderRadius),
        onTapDown: _isEnabled ? (details) => _onUpdatePressed(value: true) : null,
        onTapUp: _isEnabled ? (details) => _onUpdatePressed(value: false) : null,
        onTapCancel: _isEnabled ? () => _onUpdatePressed(value: false) : null,
        onTap: _isEnabled ? () => widget.onChanged?.call(widget.value) : null,
        child: widget.builder(context, states),
      );
    } else {
      return GtbInkWell(
        borderRadius: BorderRadius.all(widget.style.borderRadius),
        onTapDown: _isEnabled ? (details) => _onUpdatePressed(value: true) : null,
        onTapUp: _isEnabled ? (details) => _onUpdatePressed(value: false) : null,
        onTapCancel: _isEnabled ? () => _onUpdatePressed(value: false) : null,
        onTap: _isEnabled ? () => widget.onChanged?.call(widget.value) : null,
        child: widget.builder(context, states),
      );
    }
  }
}

// Holds a radio button style while the animation is playing
@immutable
final class _GtbRadioButtonInternalState {
  const _GtbRadioButtonInternalState({
    required this.isSelected,
    required this.size,
    required this.innerRadius,
    required this.outerRadius,
    required this.radioColor,
    required this.backgroundColor,
    required this.border,
  });

  final bool isSelected;
  final Size size;
  final double innerRadius;
  final double outerRadius;
  final Color radioColor;
  final Color backgroundColor;
  final Border border;

  static _GtbRadioButtonInternalState from({
    required GtbRadioButtonStyle style,
    required Set<WidgetState> states,
    required bool isSelected,
  }) {
    return _GtbRadioButtonInternalState(
      isSelected: isSelected,
      size: style.radioSize,
      innerRadius: style.innerRadius,
      outerRadius: style.outerRadius,
      radioColor: style.radioColor.resolve(states),
      backgroundColor: style.radioBackgroundColor.resolve(states),
      border: style.radioBorder.resolve(states),
    );
  }

  static _GtbRadioButtonInternalState lerp(
    _GtbRadioButtonInternalState a,
    _GtbRadioButtonInternalState b,
    double t,
  ) {
    return _GtbRadioButtonInternalState(
      isSelected: t < 0.5 ? a.isSelected : b.isSelected,
      size: t < 0.5 ? a.size : b.size,
      innerRadius: lerpDouble(a.innerRadius, b.innerRadius, t),
      outerRadius: lerpDouble(a.outerRadius, b.outerRadius, t),
      radioColor: Color.lerp(a.radioColor, b.radioColor, t)!,
      backgroundColor: Color.lerp(a.backgroundColor, b.backgroundColor, t)!,
      border: Border.lerp(a.border, b.border, t)!,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is _GtbRadioButtonInternalState && //
        isSelected == other.isSelected &&
        size == other.size &&
        innerRadius == other.innerRadius &&
        outerRadius == other.outerRadius &&
        radioColor == other.radioColor &&
        backgroundColor == other.backgroundColor &&
        border == other.border;
  }

  @override
  int get hashCode {
    return Object.hash(
      isSelected,
      size,
      innerRadius,
      outerRadius,
      radioColor,
      backgroundColor,
      border,
    );
  }
}

class _GtbRadioButton extends StatefulWidget {
  const _GtbRadioButton({
    required this.state,
    required this.isEnabled,
  });

  final _GtbRadioButtonInternalState state;
  final bool isEnabled;

  @override
  State<_GtbRadioButton> createState() => __GtbRadioButtonState();
}

class __GtbRadioButtonState extends State<_GtbRadioButton> with SingleTickerProviderStateMixin {
  late final AnimationController _toggleController;
  late final CurvedAnimation _toggleAnimation;
  late _GtbRadioButtonInternalState _previousState;

  @override
  void initState() {
    super.initState();

    _toggleController = AnimationController(
      vsync: this,
      duration: _kToggleDuration,
      value: widget.state.isSelected ? 1.0 : 0.0,
    );

    _toggleAnimation = CurvedAnimation(
      parent: _toggleController,
      curve: Curves.easeIn,
      reverseCurve: Curves.easeOut,
    );

    _previousState = widget.state;
  }

  @override
  void didUpdateWidget(_GtbRadioButton oldWidget) {
    super.didUpdateWidget(oldWidget);

    _previousState = oldWidget.state;

    if (oldWidget.state != widget.state) {
      _toggleController.value = 0.0;
      _toggleController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _toggleAnimation,
      builder: (context, child) {
        final state = _GtbRadioButtonInternalState.lerp(
          _previousState,
          widget.state,
          _toggleAnimation.value,
        );

        return CustomPaint(
          size: state.size,
          painter: _RadioButtonPainter(
            innerRadius: state.innerRadius,
            outerRadius: state.outerRadius,
            border: state.border,
            radioColor: state.radioColor,
            backgroundColor: state.backgroundColor,
          ),
        );
      },
    );
  }
}

class _RadioButtonPainter extends CustomPainter {
  _RadioButtonPainter({
    required this.innerRadius,
    required this.outerRadius,
    required this.radioColor,
    required this.backgroundColor,
    required this.border,
  });

  final double innerRadius;
  final double outerRadius;
  final Color radioColor;
  final Color backgroundColor;
  final Border border;

  @override
  void paint(Canvas canvas, Size size) {
    final center = (Offset.zero & size).center;

    // Background
    canvas.drawCircle(
      center,
      outerRadius,
      Paint()
        ..color = backgroundColor
        ..style = PaintingStyle.fill,
    );

    if (border.top.color case final borderColor when border.top.style == BorderStyle.solid) {
      // Outer circle
      canvas.drawCircle(
        center,
        outerRadius,
        Paint()
          ..color = borderColor
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.0,
      );
    }

    // Inner circle
    canvas.drawCircle(
      center,
      innerRadius,
      Paint()
        ..color = radioColor
        ..style = PaintingStyle.fill,
    );
  }

  @override
  bool shouldRepaint(covariant _RadioButtonPainter oldDelegate) {
    return oldDelegate.innerRadius != innerRadius || //
        oldDelegate.outerRadius != outerRadius ||
        oldDelegate.radioColor != radioColor ||
        oldDelegate.backgroundColor != backgroundColor ||
        oldDelegate.border != border;
  }
}

final class GtbRadioButtonTheme extends InheritedTheme {
  const GtbRadioButtonTheme({
    required super.child,
    required this.data,
    super.key,
  });

  final GtbRadioButtonThemeData data;

  static GtbRadioButtonThemeData of(BuildContext context) {
    final theme = context.dependOnInheritedWidgetOfExactType<GtbRadioButtonTheme>();
    return theme?.data ?? GtbThemeProvider.of(context).radioButtonTheme;
  }

  @override
  bool updateShouldNotify(GtbRadioButtonTheme oldWidget) {
    return oldWidget.data != data;
  }

  @override
  Widget wrap(BuildContext context, Widget child) {
    return GtbRadioButtonTheme(
      data: data,
      child: child,
    );
  }
}

final class GtbRadioButtonThemeData {
  GtbRadioButtonThemeData({
    required this.radioButtonStyle,
    required this.radioButtonCardStyle,
    required this.radioButtonBoxStyle,
  });

  final GtbRadioButtonStyle radioButtonStyle;
  final GtbRadioButtonStyle radioButtonCardStyle;
  final GtbRadioButtonStyle radioButtonBoxStyle;

  static GtbRadioButtonThemeData lerp(
    GtbRadioButtonThemeData a,
    GtbRadioButtonThemeData b,
    double t,
  ) {
    return GtbRadioButtonThemeData(
      radioButtonStyle: GtbRadioButtonStyle.lerp(a.radioButtonStyle, b.radioButtonStyle, t),
      radioButtonCardStyle: GtbRadioButtonStyle.lerp(
        a.radioButtonCardStyle,
        b.radioButtonCardStyle,
        t,
      ),
      radioButtonBoxStyle: GtbRadioButtonStyle.lerp(
        a.radioButtonBoxStyle,
        b.radioButtonBoxStyle,
        t,
      ),
    );
  }

  GtbRadioButtonThemeData copyWith({
    GtbRadioButtonStyle? radioButtonStyle,
    GtbRadioButtonStyle? radioButtonCardStyle,
    GtbRadioButtonStyle? radioButtonBoxStyle,
  }) {
    return GtbRadioButtonThemeData(
      radioButtonStyle: radioButtonStyle ?? this.radioButtonStyle,
      radioButtonCardStyle: radioButtonCardStyle ?? this.radioButtonCardStyle,
      radioButtonBoxStyle: radioButtonBoxStyle ?? this.radioButtonBoxStyle,
    );
  }

  GtbRadioButtonThemeData copyAllStylesWith({
    Size? radioSize,
    double? innerRadius,
    double? outerRadius,
    WidgetStateProperty<Color>? radioColor,
    WidgetStateProperty<Color>? backgroundColor,
    WidgetStateProperty<Color>? labelColor,
    Radius? borderRadius,
    EdgeInsets? padding,
    WidgetStateProperty<Color>? radioBackgroundColor,
    WidgetStateProperty<Border>? border,
    WidgetStateProperty<Border>? radioBorder,
  }) {
    return GtbRadioButtonThemeData(
      radioButtonStyle: radioButtonStyle.copyWith(
        radioSize: radioSize ?? radioButtonStyle.radioSize,
        innerRadius: innerRadius ?? radioButtonStyle.innerRadius,
        outerRadius: outerRadius ?? radioButtonStyle.outerRadius,
        radioColor: radioColor ?? radioButtonStyle.radioColor,
        backgroundColor: backgroundColor ?? radioButtonStyle.backgroundColor,
        labelColor: labelColor ?? radioButtonStyle.labelColor,
        borderRadius: borderRadius ?? radioButtonStyle.borderRadius,
        padding: padding ?? radioButtonStyle.padding,
        radioBackgroundColor: radioBackgroundColor ?? radioButtonStyle.radioBackgroundColor,
        border: border ?? radioButtonStyle.border,
        radioBorder: radioBorder ?? radioButtonStyle.radioBorder,
      ),
      radioButtonCardStyle: radioButtonCardStyle.copyWith(
        radioSize: radioSize ?? radioButtonCardStyle.radioSize,
        innerRadius: innerRadius ?? radioButtonCardStyle.innerRadius,
        outerRadius: outerRadius ?? radioButtonCardStyle.outerRadius,
        radioColor: radioColor ?? radioButtonCardStyle.radioColor,
        backgroundColor: backgroundColor ?? radioButtonCardStyle.backgroundColor,
        labelColor: labelColor ?? radioButtonCardStyle.labelColor,
        borderRadius: borderRadius ?? radioButtonCardStyle.borderRadius,
        padding: padding ?? radioButtonCardStyle.padding,
        radioBackgroundColor: radioBackgroundColor ?? radioButtonCardStyle.radioBackgroundColor,
        border: border ?? radioButtonCardStyle.border,
        radioBorder: radioBorder ?? radioButtonCardStyle.radioBorder,
      ),
      radioButtonBoxStyle: radioButtonBoxStyle.copyWith(
        radioSize: radioSize ?? radioButtonBoxStyle.radioSize,
        innerRadius: innerRadius ?? radioButtonBoxStyle.innerRadius,
        outerRadius: outerRadius ?? radioButtonBoxStyle.outerRadius,
        radioColor: radioColor ?? radioButtonBoxStyle.radioColor,
        backgroundColor: backgroundColor ?? radioButtonBoxStyle.backgroundColor,
        labelColor: labelColor ?? radioButtonBoxStyle.labelColor,
        borderRadius: borderRadius ?? radioButtonBoxStyle.borderRadius,
        padding: padding ?? radioButtonBoxStyle.padding,
        radioBackgroundColor: radioBackgroundColor ?? radioButtonBoxStyle.radioBackgroundColor,
        border: border ?? radioButtonBoxStyle.border,
        radioBorder: radioBorder ?? radioButtonBoxStyle.radioBorder,
      ),
    );
  }
}

final class GtbRadioButtonStyle {
  const GtbRadioButtonStyle({
    required this.radioSize,
    required this.innerRadius,
    required this.outerRadius,
    required this.radioColor,
    required this.backgroundColor,
    required this.labelColor,
    required this.borderRadius,
    required this.padding,
    required this.radioBackgroundColor,
    required this.border,
    required this.radioBorder,
  });

  final Size radioSize;
  final double innerRadius;
  final double outerRadius;
  final Radius borderRadius;
  final EdgeInsets padding;
  final WidgetStateProperty<Color> radioColor;
  final WidgetStateProperty<Color> backgroundColor;
  final WidgetStateProperty<Color> radioBackgroundColor;
  final WidgetStateProperty<Border> border;
  final WidgetStateProperty<Border> radioBorder;
  final WidgetStateProperty<Color> labelColor;

  static GtbRadioButtonStyle lerp(GtbRadioButtonStyle a, GtbRadioButtonStyle b, double t) {
    return GtbRadioButtonStyle(
      radioSize: Size.lerp(a.radioSize, b.radioSize, t)!,
      innerRadius: lerpDouble(a.innerRadius, b.innerRadius, t),
      outerRadius: lerpDouble(a.outerRadius, b.outerRadius, t),
      radioColor:
          WidgetStateProperty.lerp(a.radioColor, b.radioColor, t, Color.lerp)!
              as WidgetStateProperty<Color>,
      backgroundColor:
          WidgetStateProperty.lerp(a.backgroundColor, b.backgroundColor, t, Color.lerp)!
              as WidgetStateProperty<Color>,
      labelColor:
          WidgetStateProperty.lerp(a.labelColor, b.labelColor, t, Color.lerp)!
              as WidgetStateProperty<Color>,
      borderRadius: Radius.lerp(a.borderRadius, b.borderRadius, t)!,
      padding: EdgeInsets.lerp(a.padding, b.padding, t)!,
      radioBackgroundColor:
          WidgetStateProperty.lerp(a.radioBackgroundColor, b.radioBackgroundColor, t, Color.lerp)!
              as WidgetStateProperty<Color>,
      border:
          WidgetStateProperty.lerp(a.border, b.border, t, Border.lerp)!
              as WidgetStateProperty<Border>,
      radioBorder:
          WidgetStateProperty.lerp(a.radioBorder, b.radioBorder, t, Border.lerp)!
              as WidgetStateProperty<Border>,
    );
  }

  GtbRadioButtonStyle copyWith({
    Size? radioSize,
    double? innerRadius,
    double? outerRadius,
    WidgetStateProperty<Color>? radioColor,
    WidgetStateProperty<Color>? backgroundColor,
    WidgetStateProperty<Color>? labelColor,
    Radius? borderRadius,
    EdgeInsets? padding,
    WidgetStateProperty<Color>? radioBackgroundColor,
    WidgetStateProperty<Border>? border,
    WidgetStateProperty<Border>? radioBorder,
  }) {
    return GtbRadioButtonStyle(
      radioSize: radioSize ?? this.radioSize,
      innerRadius: innerRadius ?? this.innerRadius,
      outerRadius: outerRadius ?? this.outerRadius,
      radioColor: radioColor ?? this.radioColor,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      labelColor: labelColor ?? this.labelColor,
      borderRadius: borderRadius ?? this.borderRadius,
      padding: padding ?? this.padding,
      radioBackgroundColor: radioBackgroundColor ?? this.radioBackgroundColor,
      border: border ?? this.border,
      radioBorder: radioBorder ?? this.radioBorder,
    );
  }
}

GtbRadioButtonThemeData createDefaultRadioButtonTheme({
  required GtbColorScheme colorScheme,
  required GtbBorderThemeData borderTheme,
  required GtbTypography typography,
}) {
  final radioButtonStyle = GtbRadioButtonStyle(
    radioSize: const Size.square(24.0),
    borderRadius: const Radius.circular(GtbGapValue.xxxs),
    padding: const EdgeInsets.all(GtbPaddingValue.xxs),
    backgroundColor: generateState(kTransparentColor),
    radioBackgroundColor: generateState(
      kTransparentColor,
      pressed: kTransparentColor,
      selected: kTransparentColor,
      disabledAndSelected: colorScheme.actionDisabledBase,
      disabled: colorScheme.actionDisabledBase,
    ),
    border: generateState(const Border()),
    radioBorder: generateState(
      Border.all(color: colorScheme.actionSecondaryEnabled),
      pressed: Border.all(color: colorScheme.actionSecondaryEnabled),
      selected: Border.all(color: colorScheme.actionSecondarySelected),
      disabledAndSelected: const Border(),
      disabled: Border.all(color: colorScheme.outlineBase),
    ),
    radioColor: generateState(
      kTransparentColor,
      pressed: kTransparentColor,
      selected: colorScheme.actionSecondarySelected,
      pressedAndSelected: colorScheme.actionSecondarySelected,
      disabledAndSelected: colorScheme.onColorEmphasisDisabled,
      disabled: kTransparentColor,
    ),
    labelColor: generateState(
      colorScheme.onColorEmphasisHigh,
      pressed: colorScheme.onColorEmphasisHigh,
      selected: colorScheme.onColorEmphasisHigh,
      disabledAndSelected: colorScheme.onColorEmphasisDisabled,
      disabled: colorScheme.onColorEmphasisDisabled,
    ),
    innerRadius: 4.0,
    outerRadius: 12.0,
  );

  final radioButtonCardStyle = radioButtonStyle.copyWith(
    padding: const EdgeInsets.all(GtbPaddingValue.sm),
    backgroundColor: generateState(
      colorScheme.actionNeutralEnabled,
      // We apply a little transparency so that the splash can appear
      pressed: colorScheme.actionNeutralPressed.withValues(alpha: 0.5),
      selected: colorScheme.actionNeutralEnabled,
      disabledAndSelected: colorScheme.actionDisabledBase,
      disabled: colorScheme.actionDisabledBase,
    ),
    border: generateState(
      Border.all(color: colorScheme.outlineBase),
      pressed: Border.all(color: colorScheme.outlineBase),
      selected: Border.all(color: colorScheme.actionMainSelected, width: 2.0),
      pressedAndSelected: Border.all(color: colorScheme.actionMainSelected, width: 2.0),
      disabledAndSelected: Border.all(color: colorScheme.outlineBase),
      disabled: Border.all(color: colorScheme.outlineBase),
    ),
    labelColor: generateState(
      colorScheme.onColorEmphasisHigh,
      pressed: colorScheme.onColorEmphasisHigh,
      selected: colorScheme.onColorEmphasisHigh,
      disabledAndSelected: colorScheme.onColorEmphasisDisabled,
      disabled: colorScheme.onColorEmphasisDisabled,
    ),
  );

  final radioButtonBoxStyle = radioButtonStyle.copyWith(
    padding: const EdgeInsets.symmetric(
      horizontal: GtbPaddingValue.sm,
      vertical: GtbPaddingValue.xs,
    ),
    backgroundColor: generateState(
      colorScheme.actionNeutralEnabled,
      // We apply a little transparency so that the splash can appear
      pressed: colorScheme.actionNeutralPressed.withValues(alpha: 0.5),
      selected: colorScheme.actionNeutralEnabled,
      disabledAndSelected: colorScheme.actionDisabledBase,
      disabled: colorScheme.actionDisabledBase,
    ),
    border: generateState(
      Border.all(color: colorScheme.outlineBase),
      pressed: Border.all(color: colorScheme.outlineBase),
      selected: Border.all(color: colorScheme.actionMainSelected, width: 2.0),
      pressedAndSelected: Border.all(color: colorScheme.actionMainSelected, width: 2.0),
      disabledAndSelected: const Border(),
      disabled: const Border(),
    ),
  );

  return GtbRadioButtonThemeData(
    radioButtonStyle: radioButtonStyle,
    radioButtonCardStyle: radioButtonCardStyle,
    radioButtonBoxStyle: radioButtonBoxStyle,
  );
}
