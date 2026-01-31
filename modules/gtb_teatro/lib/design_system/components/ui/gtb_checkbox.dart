import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:gtb_teatro/design_system/gtb_teatro.dart';

const _kToggleDuration = Duration(milliseconds: 150);

enum GtbCheckboxPosition {
  left,
  right,
}

class GtbCheckbox extends StatelessWidget {
  const GtbCheckbox({
    required this.selection,
    super.key,
    this.isTristate = false,
    this.autofocus = false,
    this.focusNode,
    this.mouseCursor,
    this.onChanged,
  }) : assert(
         isTristate || selection != GtbToggleableSelection.indeterminate,
         "The selection can't be [GtbToggleableSelection.indeterminate] when [isTristate] is false",
       );

  final GtbToggleableSelection selection;
  final bool isTristate;
  final bool autofocus;
  final FocusNode? focusNode;
  final MouseCursor? mouseCursor;
  final ValueChanged<GtbToggleableSelection>? onChanged;

  @override
  Widget build(BuildContext context) {
    final style = GtbCheckboxTheme.of(context).checkboxStyle;

    return _GtbCheckboxActionHandler(
      selection: selection,
      isTristate: isTristate,
      onChanged: onChanged,
      style: style,
      builder: (context, states) {
        return Padding(
          padding: style.padding,
          child: _GtbCheckbox(
            isEnabled: onChanged != null,
            state: _GtbCheckboxInternalState.from(style, states, selection),
          ),
        );
      },
    );
  }
}

class GtbCheckboxLabel extends StatelessWidget {
  const GtbCheckboxLabel({
    required this.label,
    required this.selection,
    super.key,
    this.position = GtbCheckboxPosition.right,
    this.isTristate = false,
    this.onChanged,
  }) : assert(
         isTristate || selection != GtbToggleableSelection.indeterminate,
         "The selection can't be [GtbToggleableSelection.indeterminate] when [isTristate] is false",
       );

  final String label;
  final GtbToggleableSelection selection;
  final GtbCheckboxPosition position;
  final bool isTristate;
  final ValueChanged<GtbToggleableSelection>? onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = GtbThemeProvider.of(context);
    final style = theme.checkboxTheme.checkboxStyle;

    return _GtbCheckboxActionHandler(
      selection: selection,
      isTristate: isTristate,
      style: style,
      onChanged: onChanged,
      shouldUseOutsideInkResponse: true,
      builder: (context, states) {
        return Padding(
          padding: EdgeInsets.only(top: style.padding.top, bottom: style.padding.bottom),
          child: Row(
            textDirection: position == GtbCheckboxPosition.left
                ? (TextDirection.ltr) //
                : TextDirection.rtl,
            children: [
              _GtbCheckbox(
                isEnabled: onChanged != null,
                state: _GtbCheckboxInternalState.from(style, states, selection),
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

class GtbCheckboxCard extends StatelessWidget {
  const GtbCheckboxCard({
    required this.selection,
    super.key,
    this.number,
    this.label,
    this.icon,
    this.onChanged,
  }) : assert(
         number != null || label != null,
         'At least one of `number` or `label` must be provided!',
       );

  final Widget? number;
  final Widget? label;
  final GtbIconContainer? icon;
  final GtbToggleableSelection selection;
  final ValueChanged<GtbToggleableSelection>? onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = GtbThemeProvider.of(context);
    final style = theme.checkboxTheme.checkboxCardStyle;

    return _GtbCheckboxActionHandler(
      selection: selection,
      isTristate: false,
      onChanged: onChanged,
      style: style,
      builder: (context, states) {
        return DecoratedBox(
          decoration: BoxDecoration(
            color: style.backgroundColor.resolve(states),
            borderRadius: BorderRadius.all(style.borderRadius),
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
                            foregroundColor: style.labelColor.resolve(states),
                            backgroundColor: theme.appColorScheme.onColorEmphasisHigh,
                            size: GtbIconContainerSize.size32,
                          ),
                          child: icon,
                        ),
                      Align(
                        alignment: Alignment.topRight,
                        child: _GtbCheckbox(
                          isEnabled: onChanged != null,
                          state: _GtbCheckboxInternalState.from(style, states, selection),
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

class GtbCheckboxBox extends StatelessWidget {
  const GtbCheckboxBox({
    required this.label,
    required this.selection,
    super.key,
    this.paragraph,
    this.onChanged,
  });

  final String label;
  final String? paragraph;
  final GtbToggleableSelection selection;
  final ValueChanged<GtbToggleableSelection>? onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = GtbThemeProvider.of(context);
    final style = theme.checkboxTheme.checkboxBoxStyle;

    return _GtbCheckboxActionHandler(
      selection: selection,
      isTristate: false,
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
                    mainAxisSize: MainAxisSize.min,
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
                _GtbCheckbox(
                  isEnabled: onChanged != null,
                  state: _GtbCheckboxInternalState.from(style, states, selection),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

typedef _GtbCheckboxBuilder = Widget Function(BuildContext context, Set<WidgetState> states);

class _GtbCheckboxActionHandler extends StatefulWidget {
  const _GtbCheckboxActionHandler({
    required this.builder,
    required this.selection,
    required this.isTristate,
    required this.style,
    this.shouldUseOutsideInkResponse = false,
    this.onChanged,
  });

  final _GtbCheckboxBuilder builder;
  final GtbToggleableSelection selection;
  final bool isTristate;
  final bool shouldUseOutsideInkResponse;
  final ValueChanged<GtbToggleableSelection>? onChanged;
  final GtbCheckboxStyle style;

  @override
  State<_GtbCheckboxActionHandler> createState() => _GtbCheckboxActionHandlerState();
}

class _GtbCheckboxActionHandlerState extends State<_GtbCheckboxActionHandler> {
  late bool _isEnabled = widget.onChanged != null;
  bool _isPressed = false;
  late GtbToggleableSelection _selection;

  @override
  void initState() {
    super.initState();

    _selection = widget.selection;
  }

  @override
  void didUpdateWidget(_GtbCheckboxActionHandler oldWidget) {
    super.didUpdateWidget(oldWidget);

    final isEnabled = widget.onChanged != null;
    if (_isEnabled != isEnabled) {
      setState(() {
        _isEnabled = isEnabled;
        if (!isEnabled) {
          _isPressed = false;
        }
      });
    }

    if (oldWidget.selection != widget.selection) {
      setState(() {
        _selection = widget.selection;
      });
    }
  }

  void _onUpdatePressed({required bool value}) {
    if (_isEnabled && (_isPressed != value)) {
      setState(() => _isPressed = value);
    }
  }

  GtbToggleableSelection _getNextSelection() {
    return switch (_selection) {
      GtbToggleableSelection.unselected => GtbToggleableSelection.selected,
      GtbToggleableSelection.selected =>
        widget.isTristate
            ? (GtbToggleableSelection.indeterminate) //
            : GtbToggleableSelection.unselected,
      GtbToggleableSelection.indeterminate => GtbToggleableSelection.unselected,
    };
  }

  @override
  Widget build(BuildContext context) {
    final states = <WidgetState>{
      if (_selection != GtbToggleableSelection.unselected) WidgetState.selected,
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
        onTap: _isEnabled ? () => widget.onChanged?.call(_getNextSelection()) : null,
        child: widget.builder(context, states),
      );
    } else {
      return GtbInkWell(
        borderRadius: BorderRadius.all(widget.style.borderRadius),
        onTapDown: _isEnabled ? (details) => _onUpdatePressed(value: true) : null,
        onTapUp: _isEnabled ? (details) => _onUpdatePressed(value: false) : null,
        onTapCancel: _isEnabled ? () => _onUpdatePressed(value: false) : null,
        onTap: _isEnabled ? () => widget.onChanged?.call(_getNextSelection()) : null,
        child: widget.builder(context, states),
      );
    }
  }
}

// Holds a checkbox style while the animation is playing
@immutable
final class _GtbCheckboxInternalState {
  const _GtbCheckboxInternalState({
    required this.selection,
    required this.size,
    required this.color,
    required this.backgroundColor,
    required this.border,
    required this.borderRadius,
  });

  final GtbToggleableSelection selection;
  final Size size;
  final Color color;
  final Color backgroundColor;
  final Border border;
  final Radius borderRadius;

  static _GtbCheckboxInternalState from(
    GtbCheckboxStyle style,
    Set<WidgetState> states,
    GtbToggleableSelection selection,
  ) {
    return _GtbCheckboxInternalState(
      selection: selection,
      size: style.checkboxSize,
      color: style.checkColor.resolve(states),
      backgroundColor: style.checkboxBackgroundColor.resolve(states),
      border: style.checkboxBorder.resolve(states),
      borderRadius: style.borderRadius,
    );
  }
}

class _GtbCheckbox extends StatefulWidget {
  const _GtbCheckbox({
    required this.state,
    required this.isEnabled,
  });

  final _GtbCheckboxInternalState state;
  final bool isEnabled;

  @override
  State<_GtbCheckbox> createState() => __GtbCheckboxState();
}

class __GtbCheckboxState extends State<_GtbCheckbox> with SingleTickerProviderStateMixin {
  late final AnimationController _toggleController;
  late final CurvedAnimation _toggleAnimation;

  late _GtbCheckboxInternalState _currentState;

  @override
  void initState() {
    super.initState();

    _currentState = widget.state;

    _toggleController = AnimationController(
      vsync: this,
      duration: _kToggleDuration,
      value: widget.state.selection == GtbToggleableSelection.selected ? 1.0 : 0.0,
    );

    _toggleAnimation = CurvedAnimation(
      parent: _toggleController,
      curve: Curves.easeIn,
      reverseCurve: Curves.easeOut,
    );
  }

  @override
  void didUpdateWidget(_GtbCheckbox oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.state != widget.state) {
      setState(() => _currentState = widget.state);

      if (oldWidget.state.selection != widget.state.selection) {
        switch (widget.state.selection) {
          case GtbToggleableSelection.unselected:
            unawaited(_toggleController.reverse());
          case GtbToggleableSelection.selected:
            unawaited(_toggleController.forward());
          case GtbToggleableSelection.indeterminate:
            _toggleController.value = 0.0;
            unawaited(_toggleController.forward());
        }
      }
    }
  }

  @override
  void dispose() {
    _toggleController.dispose();
    _toggleAnimation.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: _currentState.size,
      painter: _CheckboxPainter(
        animation: _toggleAnimation,
        selection: _currentState.selection,
        color: _currentState.color,
        backgroundColor: _currentState.backgroundColor,
        border: _currentState.border,
        borderRadius: _currentState.borderRadius,
        strokeWidth: 1.5,
        padding: GtbGapValue.xxxs,
      ),
    );
  }
}

class _CheckboxPainter extends CustomPainter {
  _CheckboxPainter({
    required this.animation,
    required this.selection,
    required this.color,
    required this.backgroundColor,
    required this.border,
    required this.borderRadius,
    required this.strokeWidth,
    required this.padding,
  }) : super(repaint: animation);

  final Animation<double> animation;
  final GtbToggleableSelection selection;
  final Color color;
  final Color backgroundColor;
  final Border border;
  final Radius borderRadius;
  final double strokeWidth;
  final double padding;

  void _drawAnimatedIcon(Canvas canvas, Size size, Offset offset) {
    final interpolation = animation.value;
    assert(0 <= interpolation && interpolation <= 1.0);

    // Avoid drawing the check icon when the interpolation is 0.0
    if (interpolation == 0) {
      return;
    }

    final centeredOffset = offset + Offset(padding, padding);
    final checkSizeWithoutPadding = Size(size.width - padding * 2, size.height - padding * 2);

    if (selection == GtbToggleableSelection.selected) {
      // Draw check
      final checkSizeWithoutPadding = Size(size.width - padding * 2, size.height - padding * 2);
      final startPoint = Offset(
        checkSizeWithoutPadding.width * 0.08,
        checkSizeWithoutPadding.height * 0.50,
      );
      final middlePoint = Offset(
        checkSizeWithoutPadding.width * 0.40,
        checkSizeWithoutPadding.height * 0.8,
      );
      final endPoint = Offset(
        checkSizeWithoutPadding.width * 0.92,
        checkSizeWithoutPadding.height * 0.2,
      );

      final path = Path();

      if (interpolation < 0.5) {
        final interpolatedStroke = interpolation * 2.0;
        final interpolatedMiddlePoint = Offset.lerp(startPoint, middlePoint, interpolatedStroke)!;

        path.moveTo(centeredOffset.dx + startPoint.dx, centeredOffset.dy + startPoint.dy);
        path.lineTo(
          centeredOffset.dx + interpolatedMiddlePoint.dx,
          centeredOffset.dy + interpolatedMiddlePoint.dy,
        );
      } else {
        final interpolatedStroke = (interpolation - 0.5) * 2.0;
        final interpolatedEndPoint = Offset.lerp(middlePoint, endPoint, interpolatedStroke)!;

        path.moveTo(centeredOffset.dx + startPoint.dx, centeredOffset.dy + startPoint.dy);
        path.lineTo(centeredOffset.dx + middlePoint.dx, centeredOffset.dy + middlePoint.dy);
        path.lineTo(
          centeredOffset.dx + interpolatedEndPoint.dx,
          centeredOffset.dy + interpolatedEndPoint.dy,
        );
      }

      canvas.drawPath(
        path,
        Paint()
          ..color = color
          ..strokeCap = StrokeCap.round
          ..strokeJoin = StrokeJoin.round
          ..style = PaintingStyle.stroke
          ..strokeWidth = strokeWidth,
      );
    } else if (selection == GtbToggleableSelection.indeterminate) {
      // Draw dash
      final startPoint = Offset(
        checkSizeWithoutPadding.width * 0.2,
        checkSizeWithoutPadding.height * 0.5,
      );
      final middlePoint = Offset(
        checkSizeWithoutPadding.width * 0.5,
        checkSizeWithoutPadding.height * 0.5,
      );
      final endPoint = Offset(
        checkSizeWithoutPadding.width * 0.8,
        checkSizeWithoutPadding.height * 0.5,
      );
      final interpolatedStartPoint = Offset.lerp(startPoint, middlePoint, 1.0 - interpolation)!;
      final interpolatedEndPoint = Offset.lerp(middlePoint, endPoint, interpolation)!;

      canvas.drawLine(
        centeredOffset + interpolatedStartPoint,
        centeredOffset + interpolatedEndPoint,
        Paint()
          ..color = color
          ..style = PaintingStyle.stroke
          ..strokeWidth = strokeWidth,
      );
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    final checkRect = RRect.fromRectAndRadius(Offset.zero & size, borderRadius);
    canvas.drawRRect(checkRect, Paint()..color = backgroundColor);

    if (border.top.color case final borderColor when border.top.style == BorderStyle.solid) {
      canvas.drawRRect(
        checkRect,
        Paint()
          ..color = borderColor
          ..style = PaintingStyle.stroke
          ..strokeWidth = border.top.width,
      );
    }

    _drawAnimatedIcon(canvas, size, Offset.zero);
  }

  @override
  bool shouldRepaint(covariant _CheckboxPainter oldDelegate) {
    return oldDelegate.animation != animation || //
        oldDelegate.selection != selection ||
        oldDelegate.color != color ||
        oldDelegate.backgroundColor != backgroundColor ||
        oldDelegate.border != border ||
        oldDelegate.borderRadius != borderRadius ||
        oldDelegate.strokeWidth != strokeWidth ||
        oldDelegate.padding != padding;
  }
}

final class GtbCheckboxTheme extends InheritedTheme {
  const GtbCheckboxTheme({
    required super.child,
    required this.data,
    super.key,
  });

  final GtbCheckboxThemeData data;

  static GtbCheckboxThemeData of(BuildContext context) {
    final theme = context.dependOnInheritedWidgetOfExactType<GtbCheckboxTheme>();
    return theme?.data ?? GtbThemeProvider.of(context).checkboxTheme;
  }

  @override
  bool updateShouldNotify(GtbCheckboxTheme oldWidget) {
    return oldWidget.data != data;
  }

  @override
  Widget wrap(BuildContext context, Widget child) {
    return GtbCheckboxTheme(
      data: data,
      child: child,
    );
  }
}

final class GtbCheckboxThemeData {
  GtbCheckboxThemeData({
    required this.checkboxStyle,
    required this.checkboxCardStyle,
    required this.checkboxBoxStyle,
  });

  final GtbCheckboxStyle checkboxStyle;
  final GtbCheckboxStyle checkboxCardStyle;
  final GtbCheckboxStyle checkboxBoxStyle;

  static GtbCheckboxThemeData lerp(GtbCheckboxThemeData a, GtbCheckboxThemeData b, double t) {
    return GtbCheckboxThemeData(
      checkboxStyle: GtbCheckboxStyle.lerp(a.checkboxStyle, b.checkboxStyle, t),
      checkboxCardStyle: GtbCheckboxStyle.lerp(a.checkboxCardStyle, b.checkboxCardStyle, t),
      checkboxBoxStyle: GtbCheckboxStyle.lerp(a.checkboxBoxStyle, b.checkboxBoxStyle, t),
    );
  }

  GtbCheckboxThemeData copyWith({
    GtbCheckboxStyle? checkboxStyle,
    GtbCheckboxStyle? checkboxCardStyle,
    GtbCheckboxStyle? checkboxBoxStyle,
  }) {
    return GtbCheckboxThemeData(
      checkboxStyle: checkboxStyle ?? this.checkboxStyle,
      checkboxCardStyle: checkboxCardStyle ?? this.checkboxCardStyle,
      checkboxBoxStyle: checkboxBoxStyle ?? this.checkboxBoxStyle,
    );
  }

  GtbCheckboxThemeData copyAllStylesWith({
    Size? checkboxSize,
    Radius? borderRadius,
    EdgeInsets? padding,
    WidgetStateProperty<Color>? backgroundColor,
    WidgetStateProperty<Color>? checkboxBackgroundColor,
    WidgetStateProperty<Border>? border,
    WidgetStateProperty<Border>? checkboxBorder,
    WidgetStateProperty<Color>? checkColor,
    WidgetStateProperty<Color>? labelColor,
  }) {
    return GtbCheckboxThemeData(
      checkboxStyle: checkboxStyle.copyWith(
        checkboxSize: checkboxSize ?? checkboxStyle.checkboxSize,
        borderRadius: borderRadius ?? checkboxStyle.borderRadius,
        padding: padding ?? checkboxStyle.padding,
        backgroundColor: backgroundColor ?? checkboxStyle.backgroundColor,
        checkboxBackgroundColor: checkboxBackgroundColor ?? checkboxStyle.checkboxBackgroundColor,
        border: border ?? checkboxStyle.border,
        checkboxBorder: checkboxBorder ?? checkboxStyle.checkboxBorder,
        checkColor: checkColor ?? checkboxStyle.checkColor,
        labelColor: labelColor ?? checkboxStyle.labelColor,
      ),
      checkboxCardStyle: checkboxCardStyle.copyWith(
        checkboxSize: checkboxSize ?? checkboxCardStyle.checkboxSize,
        borderRadius: borderRadius ?? checkboxCardStyle.borderRadius,
        padding: padding ?? checkboxCardStyle.padding,
        backgroundColor: backgroundColor ?? checkboxCardStyle.backgroundColor,
        checkboxBackgroundColor:
            checkboxBackgroundColor ?? checkboxCardStyle.checkboxBackgroundColor,
        border: border ?? checkboxCardStyle.border,
        checkboxBorder: checkboxBorder ?? checkboxCardStyle.checkboxBorder,
        checkColor: checkColor ?? checkboxCardStyle.checkColor,
        labelColor: labelColor ?? checkboxCardStyle.labelColor,
      ),
      checkboxBoxStyle: checkboxBoxStyle.copyWith(
        checkboxSize: checkboxSize ?? checkboxBoxStyle.checkboxSize,
        borderRadius: borderRadius ?? checkboxBoxStyle.borderRadius,
        padding: padding ?? checkboxBoxStyle.padding,
        backgroundColor: backgroundColor ?? checkboxBoxStyle.backgroundColor,
        checkboxBackgroundColor:
            checkboxBackgroundColor ?? checkboxBoxStyle.checkboxBackgroundColor,
        border: border ?? checkboxBoxStyle.border,
        checkboxBorder: checkboxBorder ?? checkboxBoxStyle.checkboxBorder,
        checkColor: checkColor ?? checkboxBoxStyle.checkColor,
        labelColor: labelColor ?? checkboxBoxStyle.labelColor,
      ),
    );
  }
}

final class GtbCheckboxStyle {
  const GtbCheckboxStyle({
    required this.checkboxSize,
    required this.borderRadius,
    required this.padding,
    required this.backgroundColor,
    required this.checkboxBackgroundColor,
    required this.border,
    required this.checkboxBorder,
    required this.checkColor,
    required this.labelColor,
  });

  final Size checkboxSize;
  final Radius borderRadius;
  final EdgeInsets padding;
  final WidgetStateProperty<Color> backgroundColor;
  final WidgetStateProperty<Color> checkboxBackgroundColor;
  final WidgetStateProperty<Border> border;
  final WidgetStateProperty<Border> checkboxBorder;
  final WidgetStateProperty<Color> checkColor;
  final WidgetStateProperty<Color> labelColor;

  static GtbCheckboxStyle lerp(GtbCheckboxStyle a, GtbCheckboxStyle b, double t) {
    return GtbCheckboxStyle(
      checkboxSize: Size.lerp(a.checkboxSize, b.checkboxSize, t)!,
      borderRadius: Radius.lerp(a.borderRadius, b.borderRadius, t)!,
      padding: EdgeInsets.lerp(a.padding, b.padding, t)!,
      backgroundColor:
          WidgetStateProperty.lerp(a.backgroundColor, b.backgroundColor, t, Color.lerp)!
              as WidgetStateProperty<Color>,
      checkboxBackgroundColor:
          WidgetStateProperty.lerp(
                a.checkboxBackgroundColor,
                b.checkboxBackgroundColor,
                t,
                Color.lerp,
              )!
              as WidgetStateProperty<Color>,
      border:
          WidgetStateProperty.lerp(a.border, b.border, t, Border.lerp)!
              as WidgetStateProperty<Border>,
      checkboxBorder:
          WidgetStateProperty.lerp(a.checkboxBorder, b.checkboxBorder, t, Border.lerp)!
              as WidgetStateProperty<Border>,
      checkColor:
          WidgetStateProperty.lerp(a.checkColor, b.checkColor, t, Color.lerp)!
              as WidgetStateProperty<Color>,
      labelColor:
          WidgetStateProperty.lerp(a.labelColor, b.labelColor, t, Color.lerp)!
              as WidgetStateProperty<Color>,
    );
  }

  GtbCheckboxStyle copyWith({
    Size? checkboxSize,
    Radius? borderRadius,
    EdgeInsets? padding,
    WidgetStateProperty<Color>? backgroundColor,
    WidgetStateProperty<Color>? checkboxBackgroundColor,
    WidgetStateProperty<Border>? border,
    WidgetStateProperty<Border>? checkboxBorder,
    WidgetStateProperty<Color>? checkColor,
    WidgetStateProperty<Color>? labelColor,
  }) {
    return GtbCheckboxStyle(
      checkboxSize: checkboxSize ?? this.checkboxSize,
      borderRadius: borderRadius ?? this.borderRadius,
      padding: padding ?? this.padding,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      checkboxBackgroundColor: checkboxBackgroundColor ?? this.checkboxBackgroundColor,
      border: border ?? this.border,
      checkboxBorder: checkboxBorder ?? this.checkboxBorder,
      checkColor: checkColor ?? this.checkColor,
      labelColor: labelColor ?? this.labelColor,
    );
  }
}

GtbCheckboxThemeData createDefaultCheckboxTheme({
  required GtbColorScheme colorScheme,
  required GtbBorderThemeData borderTheme,
  required GtbTypography typography,
}) {
  final checkboxStyle = GtbCheckboxStyle(
    checkboxSize: const Size.square(24.0),
    borderRadius: const Radius.circular(GtbGapValue.xxxs),
    padding: const EdgeInsets.all(GtbPaddingValue.xxs),
    backgroundColor: generateState(kTransparentColor),
    checkboxBackgroundColor: generateState(
      kTransparentColor,
      pressed: kTransparentColor,
      selected: colorScheme.actionSecondarySelected,
      pressedAndSelected: colorScheme.actionSecondarySelected,
      disabled: colorScheme.actionDisabledBase,
      disabledAndSelected: colorScheme.actionDisabledBase,
    ),
    border: generateState(const Border()),
    checkboxBorder: generateState(
      Border.all(color: colorScheme.actionSecondaryEnabled),
      pressed: Border.all(color: colorScheme.actionSecondaryEnabled),
      selected: const Border(),
      pressedAndSelected: const Border(),
      disabled: Border.all(color: colorScheme.outlineBase),
      disabledAndSelected: const Border(),
    ),
    checkColor: generateState(
      kTransparentColor,
      pressed: kTransparentColor,
      selected: colorScheme.onColorEmphasisHighInverse,
      pressedAndSelected: colorScheme.onColorEmphasisHighInverse,
      disabled: kTransparentColor,
      disabledAndSelected: colorScheme.onColorEmphasisDisabled,
    ),
    labelColor: generateState(
      colorScheme.onColorEmphasisHigh,
      pressed: colorScheme.onColorEmphasisHigh,
      selected: colorScheme.onColorEmphasisHigh,
      disabled: colorScheme.onColorEmphasisDisabled,
      disabledAndSelected: colorScheme.onColorEmphasisDisabled,
    ),
  );

  final checkboxCardStyle = checkboxStyle.copyWith(
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

  final checkboxBoxStyle = checkboxStyle.copyWith(
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

  return GtbCheckboxThemeData(
    checkboxStyle: checkboxStyle,
    checkboxCardStyle: checkboxCardStyle,
    checkboxBoxStyle: checkboxBoxStyle,
  );
}
