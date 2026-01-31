import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:gtb_teatro/design_system/gtb_teatro.dart';

const _kReactionDuration = Duration(milliseconds: 300);
const _kToggleDuration = Duration(milliseconds: 200);

enum GtbSwitcherSide {
  left,
  right,
}

/// An iOS-style switch.
///
/// Used to toggle the on/off state of a single setting.
///
/// The switch itself does not maintain any state. Instead, when the state of
/// the switch changes, the widget calls the [onChanged] callback. Most widgets
/// that use a switch will listen for the [onChanged] callback and rebuild the
/// switch with a new [value] to update the visual appearance of the switch.
///
/// {@tool snippet}
///
/// This sample shows how to use a [GtbSwitcher] in a [ListTile]. The
/// [MergeSemantics] is used to turn the entire [ListTile] into a single item
/// for accessibility tools.
///
/// ```dart
/// MergeSemantics(
///   child: ListTile(
///     title: Text('Lights'),
///     trailing: CupertinoSwitch(
///       value: _lights,
///       onChanged: (bool value) { setState(() { _lights = value; }); },
///     ),
///     onTap: () { setState(() { _lights = !_lights; }); },
///   ),
/// )
/// ```
/// {@end-tool}
///
/// See also:
///
///  * [Switch], the material design equivalent.
///  * <https://developer.apple.com/ios/human-interface-guidelines/controls/switches/>
final class GtbSwitcher extends StatefulWidget {
  /// Creates an iOS-style switch.
  ///
  /// The [value] parameter must not be null.
  /// The [dragStartBehavior] parameter defaults to [DragStartBehavior.start] and must not be null.
  const GtbSwitcher({
    required this.value,
    required this.onChanged,
    super.key,
    this.dragStartBehavior = DragStartBehavior.start,
  }) : isLoading = false;

  const GtbSwitcher.loading({super.key}) : isLoading = true, value = false, onChanged = null, dragStartBehavior = DragStartBehavior.start;

  /// Whether this switch is on or off.
  ///
  /// Must not be null.
  final bool value;

  /// Whether this switch is loading.
  ///
  /// Shows a [Shimmer] when true.
  final bool isLoading;

  /// Called when the user toggles with switch on or off.
  ///
  /// The switch passes the new value to the callback but does not actually
  /// change state until the parent widget rebuilds the switch with the new
  /// value.
  ///
  /// If null, the switch will be displayed as disabled, which has a reduced opacity.
  ///
  /// The callback provided to onChanged should update the state of the parent
  /// [StatefulWidget] using the [State.setState] method, so that the parent
  /// gets rebuilt; for example:
  ///
  /// ```dart
  /// CupertinoSwitch(
  ///   value: _giveVerse,
  ///   onChanged: (bool newValue) {
  ///     setState(() {
  ///       _giveVerse = newValue;
  ///     });
  ///   },
  /// )
  /// ```
  final ValueChanged<bool>? onChanged;

  /// {@template flutter.cupertino.switch.dragStartBehavior}
  /// Determines the way that drag start behavior is handled.
  ///
  /// If set to [DragStartBehavior.start], the drag behavior used to move the
  /// switch from on to off will begin upon the detection of a drag gesture. If
  /// set to [DragStartBehavior.down] it will begin when a down event is first
  /// detected.
  ///
  /// In general, setting this to [DragStartBehavior.start] will make drag
  /// animation smoother and setting it to [DragStartBehavior.down] will make
  /// drag behavior feel slightly more reactive.
  ///
  /// By default, the drag start behavior is [DragStartBehavior.start].
  ///
  /// See also:
  ///
  ///  * [DragGestureRecognizer.dragStartBehavior], which gives an example for
  ///    the different behaviors.
  ///
  /// {@endtemplate}
  final DragStartBehavior dragStartBehavior;

  @override
  _GtbSwitcherState createState() => _GtbSwitcherState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(FlagProperty('value', value: value, ifTrue: 'on', ifFalse: 'off', showName: true));
    properties.add(FlagProperty('isLoading', value: isLoading, showName: true));
    properties.add(ObjectFlagProperty<ValueChanged<bool>>('onChanged', onChanged, ifNull: 'disabled'));
  }
}

final class _GtbSwitcherState extends State<GtbSwitcher> with TickerProviderStateMixin {
  late TapGestureRecognizer _tapRecognizer;
  late HorizontalDragGestureRecognizer _dragRecognizer;
  late AnimationController _positionController;
  late CurvedAnimation _positionAnimation;
  late AnimationController _reactionController;
  late Animation<double> _reactionAnimation;
  late GtbSwitcherStyle _switchStyle;

  // A non-null boolean value that changes to true at the end of a drag if the
  // switch must be animated to the position indicated by the widget's value.
  bool needsPositionAnimation = false;

  bool get isInteractive => widget.onChanged != null;

  @override
  void initState() {
    super.initState();

    _tapRecognizer = TapGestureRecognizer()
      ..onTapDown = _handleTapDown
      ..onTapUp = _handleTapUp
      ..onTap = _handleTap
      ..onTapCancel = _handleTapCancel;

    _dragRecognizer = HorizontalDragGestureRecognizer()
      ..onStart = _handleDragStart
      ..onUpdate = _handleDragUpdate
      ..onEnd = _handleDragEnd
      ..dragStartBehavior = widget.dragStartBehavior;

    _positionController = AnimationController(
      duration: _kToggleDuration,
      value: widget.value ? 1.0 : 0.0,
      vsync: this,
    );

    _positionAnimation = CurvedAnimation(
      parent: _positionController,
      curve: Curves.linear,
    );

    _reactionController = AnimationController(
      duration: _kReactionDuration,
      vsync: this,
    );

    _reactionAnimation = CurvedAnimation(
      parent: _reactionController,
      curve: Curves.ease,
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _switchStyle = GtbSwitcherTheme.of(context).switcherStyle;
  }

  @override
  void didUpdateWidget(GtbSwitcher oldWidget) {
    super.didUpdateWidget(oldWidget);
    _dragRecognizer.dragStartBehavior = widget.dragStartBehavior;

    if (needsPositionAnimation || oldWidget.value != widget.value) {
      _resumePositionAnimation(isLinear: needsPositionAnimation);
    }
  }

  @override
  void dispose() {
    _tapRecognizer.dispose();
    _dragRecognizer.dispose();

    _positionController.dispose();
    _reactionController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (needsPositionAnimation) {
      _resumePositionAnimation();
    }

    final states = widget.onChanged == null
        ? {WidgetState.disabled} //
        : <WidgetState>{};

    if (widget.isLoading) {
      // It doesn't really matter what color is used for the shimmer effect,
      // as long as it has full opacity for the shimmer effect.
      const trackShimmerColor = Color(0xFFFFFFFF);

      return GtbShimmer(
        isLoading: widget.isLoading,
        child: SizedBox(
          width: _switchStyle.width,
          height: _switchStyle.height,
          child: _SwitcherRenderObjectWidget(
            value: widget.value,
            activeColor: trackShimmerColor,
            trackColor: trackShimmerColor,
            thumbColor: trackShimmerColor,
            thumbRadius: _switchStyle.thumbRadius,
            onChanged: (_) {},
            textDirection: Directionality.of(context),
            state: this,
          ),
        ),
      );
    } else {
      return SizedBox(
        width: _switchStyle.width,
        height: _switchStyle.height,
        child: _SwitcherRenderObjectWidget(
          value: widget.value,
          activeColor: _switchStyle.activeColor.resolve(states),
          trackColor: _switchStyle.trackColor.resolve(states),
          thumbColor: _switchStyle.thumbColor.resolve(states),
          thumbRadius: _switchStyle.thumbRadius,
          onChanged: widget.onChanged,
          textDirection: Directionality.of(context),
          state: this,
        ),
      );
    }
  }

  // `isLinear` must be true if the position animation is trying to move the
  // thumb to the closest end after the most recent drag animation, so the curve
  // does not change when the controller's value is not 0 or 1.
  //
  // It can be set to false when it's an implicit animation triggered by
  // widget.value changes.
  void _resumePositionAnimation({bool isLinear = true}) {
    needsPositionAnimation = false;
    _positionAnimation
      ..curve = isLinear ? Curves.linear : Curves.ease
      ..reverseCurve = isLinear ? null : Curves.ease.flipped;
    if (widget.value) {
      _positionController.forward();
    } else {
      _positionController.reverse();
    }
  }

  void _handleTapDown(TapDownDetails details) {
    if (isInteractive) {
      needsPositionAnimation = false;
    }
    _reactionController.forward();
  }

  void _handleTap() {
    if (isInteractive) {
      widget.onChanged!(!widget.value);
      _emitVibration();
    }
  }

  void _handleTapUp(TapUpDetails details) {
    if (isInteractive) {
      needsPositionAnimation = false;
      _reactionController.reverse();
    }
  }

  void _handleTapCancel() {
    if (isInteractive) {
      _reactionController.reverse();
    }
  }

  void _handleDragStart(DragStartDetails details) {
    if (isInteractive) {
      needsPositionAnimation = false;
      _reactionController.forward();
      _emitVibration();
    }
  }

  void _handleDragUpdate(DragUpdateDetails details) {
    if (isInteractive) {
      _positionAnimation
        ..curve = Curves.linear
        ..reverseCurve = Curves.linear;

      final trackInnerLength = _switchStyle.trackInnerEnd - _switchStyle.trackInnerStart;
      final delta = details.primaryDelta! / trackInnerLength;

      _positionController.value = switch (Directionality.of(context)) {
        TextDirection.rtl => _positionController.value - delta,
        TextDirection.ltr => _positionController.value + delta,
      };
    }
  }

  void _handleDragEnd(DragEndDetails details) {
    // Deferring the animation to the next build phase.
    setState(() {
      needsPositionAnimation = true;
    });
    // Call onChanged when the user's intent to change value is clear.
    if (_positionAnimation.value >= 0.5 != widget.value) {
      widget.onChanged!(!widget.value);
    }
    _reactionController.reverse();
  }

  void _emitVibration() {
    switch (defaultTargetPlatform) {
      case TargetPlatform.iOS:
        unawaited(
          HapticFeedback.lightImpact(),
        );
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.macOS:
      case TargetPlatform.windows:
        break;
    }
  }
}

final class GtbSwitcherLabel extends StatelessWidget {
  const GtbSwitcherLabel({
    required this.title,
    required this.value,
    required this.onChanged,
    super.key,
    this.dragStartBehavior = DragStartBehavior.start,
    this.side = GtbSwitcherSide.left,
    this.informativeIcon,
    this.paragraph,
  }) : isLoading = false;

  const GtbSwitcherLabel.loading({
    super.key,
    this.paragraph,
    this.title = const Text('Label'),
    this.side = GtbSwitcherSide.left,
  }) : informativeIcon = null,
       isLoading = true,
       value = false,
       onChanged = null,
       dragStartBehavior = DragStartBehavior.start;

  final bool value;
  final bool isLoading;
  final ValueChanged<bool>? onChanged;
  final DragStartBehavior dragStartBehavior;
  final Widget title;
  final GtbInformativeIcon? informativeIcon;
  final Widget? paragraph;
  final GtbSwitcherSide side;

  bool get isInteractive => onChanged != null;

  @override
  Widget build(BuildContext context) {
    final theme = GtbThemeProvider.of(context);
    final style = theme.switcherTheme.switcherLabelStyle;

    final states = {if (!isInteractive) WidgetState.disabled};

    return GtbInkWell.outsideResponse(
      borderRadius: BorderRadius.all(style.borderRadius),
      onTap: isInteractive
          ? (() => onChanged?.call(!value)) //
          : null,
      child: _SwitcherLabelBase(
        side: side,
        style: style,
        value: value,
        isInteractive: isInteractive,
        isLoading: isLoading,
        dragStartBehavior: dragStartBehavior,
        label: title,
        informativeIcon: informativeIcon,
        states: states,
        paragraph: paragraph,
        crossAxisAlignment: CrossAxisAlignment.center,
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(FlagProperty('value', value: value, ifTrue: 'on', ifFalse: 'off', showName: true));
    properties.add(FlagProperty('isLoading', value: isLoading, showName: true));
    properties.add(ObjectFlagProperty<ValueChanged<bool>>('onChanged', onChanged, ifNull: 'disabled'));
    properties.add(ObjectFlagProperty<DragStartBehavior>('dragStartBehavior', dragStartBehavior));
    properties.add(ObjectFlagProperty<GtbSwitcherSide>('side', side));
  }
}

final class GtbSwitcherBox extends StatelessWidget {
  const GtbSwitcherBox({
    required this.title,
    required this.value,
    required this.onChanged,
    super.key,
    this.dragStartBehavior = DragStartBehavior.start,
    this.informativeIcon,
    this.paragraph,
  }) : isLoading = false;

  const GtbSwitcherBox.loading({
    super.key,
    this.paragraph,
    this.title = const Text('Label'),
  }) : informativeIcon = null,
       isLoading = true,
       value = false,
       onChanged = null,
       dragStartBehavior = DragStartBehavior.start;

  final bool value;
  final bool isLoading;
  final ValueChanged<bool>? onChanged;
  final DragStartBehavior dragStartBehavior;
  final Widget title;
  final GtbInformativeIcon? informativeIcon;
  final Widget? paragraph;

  bool get isInteractive => onChanged != null;

  @override
  Widget build(BuildContext context) {
    final theme = GtbThemeProvider.of(context);
    final style = theme.switcherTheme.switcherBoxStyle;
    final colorScheme = theme.appColorScheme;

    final states = {if (!isInteractive) WidgetState.disabled};

    return GtbShimmer(
      isLoading: isLoading,
      child: GtbShimmerCover(
        child: GtbInkWell(
          borderRadius: BorderRadius.all(style.borderRadius),
          onTap: isInteractive
              ? (() => onChanged?.call(!value)) //
              : null,
          child: Ink(
            decoration: BoxDecoration(
              color: style.backgroundColor.resolve(states),
              borderRadius: BorderRadius.all(style.borderRadius),
              border: Border.all(color: colorScheme.outlineBase),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: GtbPaddingValue.sm,
                vertical: GtbPaddingValue.xs,
              ),
              child: _SwitcherLabelBase(
                side: GtbSwitcherSide.right,
                style: style,
                value: value,
                isInteractive: isInteractive,
                isLoading: isLoading,
                dragStartBehavior: dragStartBehavior,
                label: title,
                states: states,
                informativeIcon: informativeIcon,
                paragraph: paragraph,
                crossAxisAlignment: CrossAxisAlignment.start,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(FlagProperty('value', value: value, ifTrue: 'on', ifFalse: 'off', showName: true));
    properties.add(FlagProperty('isLoading', value: isLoading, showName: true));
    properties.add(ObjectFlagProperty<ValueChanged<bool>>('onChanged', onChanged, ifNull: 'disabled'));
    properties.add(ObjectFlagProperty<DragStartBehavior>('dragStartBehavior', dragStartBehavior));
  }
}

final class _SwitcherLabelBase extends StatelessWidget {
  const _SwitcherLabelBase({
    required this.side,
    required this.style,
    required this.value,
    required this.isInteractive,
    required this.isLoading,
    required this.dragStartBehavior,
    required this.label,
    required this.states,
    required this.crossAxisAlignment,
    this.informativeIcon,
    this.paragraph,
  });

  final GtbSwitcherSide side;
  final GtbSwitcherStyle style;
  final bool value;
  final bool isInteractive;
  final bool isLoading;
  final DragStartBehavior dragStartBehavior;
  final Widget label;
  final GtbInformativeIcon? informativeIcon;
  final Widget? paragraph;
  final Set<WidgetState> states;
  final CrossAxisAlignment crossAxisAlignment;

  @override
  Widget build(BuildContext context) {
    final theme = GtbThemeProvider.of(context);
    final typography = theme.typography;

    final labelColor = style.labelColor.resolve(states);

    return GtbShimmer(
      isLoading: isLoading,
      child: Row(
        crossAxisAlignment: crossAxisAlignment,
        textDirection: switch (side) {
          GtbSwitcherSide.left => TextDirection.ltr,
          GtbSwitcherSide.right => TextDirection.rtl,
        },
        children: [
          IgnorePointer(
            child: GtbSwitcherTheme(
              data: theme.switcherTheme.copyAllStylesWith(
                width: style.trackWidth,
                height: style.trackHeight,
              ),
              child: isLoading
                  ? const GtbSwitcher.loading()
                  : GtbSwitcher(
                      value: value,
                      onChanged: isInteractive ? (value) {} : null,
                      dragStartBehavior: dragStartBehavior,
                    ),
            ),
          ),
          GtbGap.xxs,
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GtbShimmerCover(
                  child: Row(
                    spacing: GtbGapValue.xxxs,
                    children: [
                      Flexible(
                        child: DefaultTextStyle(
                          textWidthBasis: TextWidthBasis.longestLine,
                          textHeightBehavior: const TextHeightBehavior(
                            applyHeightToFirstAscent: false,
                            applyHeightToLastDescent: false,
                            leadingDistribution: TextLeadingDistribution.even,
                          ),
                          style: typography.bodyBase.copyWith(color: labelColor),
                          child: label,
                        ),
                      ),
                      if (informativeIcon case final informativeIcon?) //
                        GtbIconContainerTheme(
                          data: GtbIconContainerTheme.of(context).copyWith(
                            foregroundColor: labelColor,
                            size: GtbIconContainerSize.size16,
                          ),
                          child: informativeIcon,
                        ),
                    ],
                  ),
                ),
                if (paragraph case final paragraph?) //
                  Padding(
                    padding: const EdgeInsets.only(top: GtbPaddingValue.xxxs),
                    child: GtbShimmerCover(
                      child: DefaultTextStyle(
                        style: typography.bodySmall.copyWith(
                          color: style.paragraphColor.resolve(states),
                        ),
                        child: paragraph,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

final class _SwitcherRenderObjectWidget extends LeafRenderObjectWidget {
  const _SwitcherRenderObjectWidget({
    required this.value,
    required this.activeColor,
    required this.trackColor,
    required this.thumbColor,
    required this.thumbRadius,
    required this.onChanged,
    required this.textDirection,
    required this.state,
  });

  final bool value;
  final Color activeColor;
  final Color trackColor;
  final Color thumbColor;
  final double thumbRadius;
  final ValueChanged<bool>? onChanged;
  final _GtbSwitcherState state;
  final TextDirection textDirection;

  @override
  _RenderSwitcher createRenderObject(BuildContext context) {
    return _RenderSwitcher(
      value: value,
      activeColor: activeColor,
      trackColor: trackColor,
      thumbColor: thumbColor,
      thumbRadius: thumbRadius,
      onChanged: onChanged,
      textDirection: textDirection,
      state: state,
    );
  }

  @override
  void updateRenderObject(BuildContext context, _RenderSwitcher renderObject) {
    renderObject
      ..value = value
      ..activeColor = activeColor
      ..trackColor = trackColor
      ..thumbColor = thumbColor
      ..thumbRadius = thumbRadius
      ..onChanged = onChanged
      ..textDirection = textDirection;
  }
}

class _RenderSwitcher extends RenderConstrainedBox {
  _RenderSwitcher({
    required bool value,
    required Color activeColor,
    required Color trackColor,
    required Color thumbColor,
    required double thumbRadius,
    required TextDirection textDirection,
    required _GtbSwitcherState state,
    ValueChanged<bool>? onChanged,
  }) : _value = value,
       _activeColor = activeColor,
       _trackColor = trackColor,
       _thumbColor = thumbColor,
       _thumbRadius = thumbRadius,
       _onChanged = onChanged,
       _textDirection = textDirection,
       _state = state,
       super(additionalConstraints: const BoxConstraints.expand()) {
    state._positionAnimation.addListener(markNeedsPaint);
    state._reactionAnimation.addListener(markNeedsPaint);
  }

  final _GtbSwitcherState _state;

  bool get value => _value;
  bool _value;
  set value(bool value) {
    if (value == _value) {
      return;
    }
    _value = value;
    markNeedsSemanticsUpdate();
  }

  Color get activeColor => _activeColor;
  Color _activeColor;
  set activeColor(Color value) {
    if (value == _activeColor) {
      return;
    }
    _activeColor = value;
    markNeedsPaint();
  }

  Color get trackColor => _trackColor;
  Color _trackColor;
  set trackColor(Color value) {
    if (value == _trackColor) {
      return;
    }
    _trackColor = value;
    markNeedsPaint();
  }

  Color get thumbColor => _thumbColor;
  Color _thumbColor;
  set thumbColor(Color value) {
    if (_thumbColor != value) {
      _thumbColor = value;
      markNeedsPaint();
    }
  }

  double get thumbRadius => _thumbRadius;
  double _thumbRadius;
  set thumbRadius(double value) {
    if (_thumbRadius != value) {
      _thumbRadius = value;
      markNeedsPaint();
    }
  }

  ValueChanged<bool>? get onChanged => _onChanged;
  ValueChanged<bool>? _onChanged;
  set onChanged(ValueChanged<bool>? value) {
    if (value == _onChanged) {
      return;
    }
    final wasInteractive = isInteractive;
    _onChanged = value;
    if (wasInteractive != isInteractive) {
      markNeedsPaint();
      markNeedsSemanticsUpdate();
    }
  }

  TextDirection get textDirection => _textDirection;
  TextDirection _textDirection;
  set textDirection(TextDirection value) {
    if (_textDirection == value) {
      return;
    }
    _textDirection = value;
    markNeedsPaint();
  }

  bool get isInteractive => onChanged != null;

  @override
  bool hitTestSelf(Offset position) => true;

  @override
  void handleEvent(PointerEvent event, BoxHitTestEntry entry) {
    assert(debugHandleEvent(event, entry));
    if (event is PointerDownEvent && isInteractive) {
      _state._dragRecognizer.addPointer(event);
      _state._tapRecognizer.addPointer(event);
    }
  }

  @override
  void describeSemanticsConfiguration(SemanticsConfiguration config) {
    super.describeSemanticsConfiguration(config);

    if (isInteractive) {
      config.onTap = _state._handleTap;
    }

    config.isEnabled = isInteractive;
    config.isToggled = _value;
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    final canvas = context.canvas;

    final currentValue = _state._positionAnimation.value;

    double visualPosition;
    switch (textDirection) {
      case TextDirection.rtl:
        visualPosition = 1.0 - currentValue;
      case TextDirection.ltr:
        visualPosition = currentValue;
    }

    final paint = Paint()
      ..color = Color.lerp(
        trackColor,
        activeColor,
        currentValue,
      )!;

    final trackRect = Rect.fromLTWH(
      offset.dx + (size.width - _state._switchStyle.trackWidth) / 2.0,
      offset.dy + (size.height - _state._switchStyle.trackHeight) / 2.0,
      _state._switchStyle.trackWidth,
      _state._switchStyle.trackHeight,
    );
    final trackRRect = RRect.fromRectAndRadius(trackRect, Radius.circular(_state._switchStyle.trackRadius));
    canvas.drawRRect(trackRRect, paint);

    final thumbLeft = lerpDouble(
      trackRect.left + _state._switchStyle.trackInnerStart - thumbRadius,
      trackRect.left + _state._switchStyle.trackInnerEnd - thumbRadius,
      visualPosition,
    )!;
    final thumbRight = lerpDouble(
      trackRect.left + _state._switchStyle.trackInnerStart + thumbRadius,
      trackRect.left + _state._switchStyle.trackInnerEnd + thumbRadius,
      visualPosition,
    )!;
    final thumbCenterY = offset.dy + size.height / 2.0;
    final thumbBounds = Rect.fromLTRB(
      thumbLeft,
      thumbCenterY - thumbRadius,
      thumbRight,
      thumbCenterY + thumbRadius,
    );

    context.pushClipRRect(needsCompositing, Offset.zero, thumbBounds, trackRRect, (innerContext, offset) {
      _ThumbPainter(
        color: thumbColor,
        radius: thumbRadius,
      ).paint(innerContext.canvas, thumbBounds);
    });
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder description) {
    super.debugFillProperties(description);
    description.add(
      FlagProperty(
        'value',
        value: value,
        ifTrue: 'checked',
        ifFalse: 'unchecked',
        showName: true,
      ),
    );
    description.add(
      FlagProperty(
        'isInteractive',
        value: isInteractive,
        ifTrue: 'enabled',
        ifFalse: 'disabled',
        showName: true,
        defaultValue: true,
      ),
    );
  }
}

final class _ThumbPainter {
  /// Creates an object that paints an iOS-style slider thumb.
  const _ThumbPainter({
    required this.color,
    required this.radius,
  });

  /// The color of the thumb.
  final Color color;

  /// Half the default diameter of the thumb.
  final double radius;

  /// Paints the thumb onto the given canvas in the given rectangle.
  ///
  /// Consider using [radius] and [extension] when deciding how large a
  /// rectangle to use for the thumb.
  void paint(Canvas canvas, Rect rect) {
    final rRect = RRect.fromRectAndRadius(
      rect,
      Radius.circular(rect.shortestSide / 2.0),
    );

    canvas.drawRRect(
      rRect,
      Paint()..color = color,
    );
  }
}

final class GtbSwitcherTheme extends InheritedTheme {
  const GtbSwitcherTheme({
    required super.child,
    required this.data,
    super.key,
  });

  final GtbSwitcherThemeData data;

  static GtbSwitcherThemeData of(BuildContext context) {
    final theme = context.dependOnInheritedWidgetOfExactType<GtbSwitcherTheme>();
    return theme?.data ?? GtbThemeProvider.of(context).switcherTheme;
  }

  @override
  bool updateShouldNotify(GtbSwitcherTheme oldWidget) {
    return oldWidget.data != data;
  }

  @override
  Widget wrap(BuildContext context, Widget child) {
    return GtbSwitcherTheme(
      data: data,
      child: child,
    );
  }
}

final class GtbSwitcherThemeData {
  GtbSwitcherThemeData({
    required this.switcherStyle,
    required this.switcherBoxStyle,
    required this.switcherLabelStyle,
  });

  final GtbSwitcherStyle switcherStyle;
  final GtbSwitcherStyle switcherBoxStyle;
  final GtbSwitcherStyle switcherLabelStyle;

  static GtbSwitcherThemeData lerp(GtbSwitcherThemeData a, GtbSwitcherThemeData b, double t) {
    return GtbSwitcherThemeData(
      switcherStyle: GtbSwitcherStyle.lerp(a.switcherStyle, b.switcherStyle, t),
      switcherBoxStyle: GtbSwitcherStyle.lerp(a.switcherBoxStyle, b.switcherBoxStyle, t),
      switcherLabelStyle: GtbSwitcherStyle.lerp(a.switcherLabelStyle, b.switcherLabelStyle, t),
    );
  }

  GtbSwitcherThemeData copyWith({
    GtbSwitcherStyle? switcherStyle,
    GtbSwitcherStyle? switcherBoxStyle,
    GtbSwitcherStyle? switcherLabelStyle,
  }) {
    return GtbSwitcherThemeData(
      switcherStyle: switcherStyle ?? this.switcherStyle,
      switcherBoxStyle: switcherBoxStyle ?? this.switcherBoxStyle,
      switcherLabelStyle: switcherLabelStyle ?? this.switcherLabelStyle,
    );
  }

  GtbSwitcherThemeData copyAllStylesWith({
    double? width,
    double? height,
    double? trackWidth,
    double? trackHeight,
    double? trackRadius,
    double? trackInnerStart,
    double? trackInnerEnd,
    double? thumbRadius,
    WidgetStateProperty<Color>? activeColor,
    WidgetStateProperty<Color>? trackColor,
    WidgetStateProperty<Color>? thumbColor,
    WidgetStateProperty<Color>? backgroundColor,
    WidgetStateProperty<Color>? labelColor,
    WidgetStateProperty<Color>? paragraphColor,
    Radius? borderRadius,
  }) {
    return GtbSwitcherThemeData(
      switcherStyle: switcherStyle.copyWith(
        width: width ?? switcherStyle.width,
        height: height ?? switcherStyle.height,
        trackWidth: trackWidth ?? switcherStyle.trackWidth,
        trackHeight: trackHeight ?? switcherStyle.trackHeight,
        trackRadius: trackRadius ?? switcherStyle.trackRadius,
        trackInnerStart: trackInnerStart ?? switcherStyle.trackInnerStart,
        trackInnerEnd: trackInnerEnd ?? switcherStyle.trackInnerEnd,
        thumbRadius: thumbRadius ?? switcherStyle.thumbRadius,
        activeColor: activeColor ?? switcherStyle.activeColor,
        trackColor: trackColor ?? switcherStyle.trackColor,
        thumbColor: thumbColor ?? switcherStyle.thumbColor,
        backgroundColor: backgroundColor ?? switcherStyle.backgroundColor,
        labelColor: labelColor ?? switcherStyle.labelColor,
        paragraphColor: paragraphColor ?? switcherStyle.paragraphColor,
        borderRadius: borderRadius ?? switcherStyle.borderRadius,
      ),
      switcherBoxStyle: switcherBoxStyle.copyWith(
        width: width ?? switcherBoxStyle.width,
        height: height ?? switcherBoxStyle.height,
        trackWidth: trackWidth ?? switcherBoxStyle.trackWidth,
        trackHeight: trackHeight ?? switcherBoxStyle.trackHeight,
        trackRadius: trackRadius ?? switcherBoxStyle.trackRadius,
        trackInnerStart: trackInnerStart ?? switcherBoxStyle.trackInnerStart,
        trackInnerEnd: trackInnerEnd ?? switcherBoxStyle.trackInnerEnd,
        thumbRadius: thumbRadius ?? switcherBoxStyle.thumbRadius,
        activeColor: activeColor ?? switcherBoxStyle.activeColor,
        trackColor: trackColor ?? switcherBoxStyle.trackColor,
        thumbColor: thumbColor ?? switcherBoxStyle.thumbColor,
        backgroundColor: backgroundColor ?? switcherBoxStyle.backgroundColor,
        labelColor: labelColor ?? switcherBoxStyle.labelColor,
        paragraphColor: paragraphColor ?? switcherBoxStyle.paragraphColor,
        borderRadius: borderRadius ?? switcherBoxStyle.borderRadius,
      ),
      switcherLabelStyle: switcherLabelStyle.copyWith(
        width: width ?? switcherLabelStyle.width,
        height: height ?? switcherLabelStyle.height,
        trackWidth: trackWidth ?? switcherLabelStyle.trackWidth,
        trackHeight: trackHeight ?? switcherLabelStyle.trackHeight,
        trackRadius: trackRadius ?? switcherLabelStyle.trackRadius,
        trackInnerStart: trackInnerStart ?? switcherLabelStyle.trackInnerStart,
        trackInnerEnd: trackInnerEnd ?? switcherLabelStyle.trackInnerEnd,
        thumbRadius: thumbRadius ?? switcherLabelStyle.thumbRadius,
        activeColor: activeColor ?? switcherLabelStyle.activeColor,
        trackColor: trackColor ?? switcherLabelStyle.trackColor,
        thumbColor: thumbColor ?? switcherLabelStyle.thumbColor,
        backgroundColor: backgroundColor ?? switcherLabelStyle.backgroundColor,
        labelColor: labelColor ?? switcherLabelStyle.labelColor,
        paragraphColor: paragraphColor ?? switcherLabelStyle.paragraphColor,
        borderRadius: borderRadius ?? switcherLabelStyle.borderRadius,
      ),
    );
  }
}

final class GtbSwitcherStyle {
  const GtbSwitcherStyle({
    required this.width,
    required this.height,
    required this.trackWidth,
    required this.trackHeight,
    required this.trackRadius,
    required this.trackInnerStart,
    required this.trackInnerEnd,
    required this.thumbRadius,
    required this.activeColor,
    required this.trackColor,
    required this.thumbColor,
    required this.backgroundColor,
    required this.labelColor,
    required this.paragraphColor,
    required this.borderRadius,
  });

  final double width;
  final double height;
  final double trackWidth;
  final double trackHeight;
  final double trackRadius;
  final double trackInnerStart;
  final double trackInnerEnd;
  final double thumbRadius;
  final WidgetStateProperty<Color> activeColor;
  final WidgetStateProperty<Color> trackColor;
  final WidgetStateProperty<Color> thumbColor;
  final WidgetStateProperty<Color> backgroundColor;
  final WidgetStateProperty<Color> labelColor;
  final WidgetStateProperty<Color> paragraphColor;
  final Radius borderRadius;

  static GtbSwitcherStyle lerp(GtbSwitcherStyle a, GtbSwitcherStyle b, double t) {
    return GtbSwitcherStyle(
      width: lerpDouble(a.width, b.width, t),
      height: lerpDouble(a.height, b.height, t),
      trackWidth: lerpDouble(a.trackWidth, b.trackWidth, t),
      trackHeight: lerpDouble(a.trackHeight, b.trackHeight, t),
      trackRadius: lerpDouble(a.trackRadius, b.trackRadius, t),
      trackInnerStart: lerpDouble(a.trackInnerStart, b.trackInnerStart, t),
      trackInnerEnd: lerpDouble(a.trackInnerEnd, b.trackInnerEnd, t),
      thumbRadius: lerpDouble(a.thumbRadius, b.thumbRadius, t),
      activeColor:
          WidgetStateProperty.lerp(
                a.activeColor,
                b.activeColor,
                t,
                Color.lerp,
              )!
              as WidgetStateProperty<Color>,
      trackColor:
          WidgetStateProperty.lerp(
                a.trackColor,
                b.trackColor,
                t,
                Color.lerp,
              )!
              as WidgetStateProperty<Color>,
      thumbColor:
          WidgetStateProperty.lerp(
                a.thumbColor,
                b.thumbColor,
                t,
                Color.lerp,
              )!
              as WidgetStateProperty<Color>,
      backgroundColor:
          WidgetStateProperty.lerp(
                a.backgroundColor,
                b.backgroundColor,
                t,
                Color.lerp,
              )!
              as WidgetStateProperty<Color>,
      labelColor:
          WidgetStateProperty.lerp(
                a.labelColor,
                b.labelColor,
                t,
                Color.lerp,
              )!
              as WidgetStateProperty<Color>,
      paragraphColor:
          WidgetStateProperty.lerp(
                a.paragraphColor,
                b.paragraphColor,
                t,
                Color.lerp,
              )!
              as WidgetStateProperty<Color>,
      borderRadius: Radius.lerp(a.borderRadius, b.borderRadius, t)!,
    );
  }

  GtbSwitcherStyle copyWith({
    double? width,
    double? height,
    double? trackWidth,
    double? trackHeight,
    double? trackRadius,
    double? trackInnerStart,
    double? trackInnerEnd,
    double? thumbRadius,
    WidgetStateProperty<Color>? activeColor,
    WidgetStateProperty<Color>? trackColor,
    WidgetStateProperty<Color>? thumbColor,
    WidgetStateProperty<Color>? backgroundColor,
    WidgetStateProperty<Color>? labelColor,
    WidgetStateProperty<Color>? paragraphColor,
    Radius? borderRadius,
  }) {
    return GtbSwitcherStyle(
      width: width ?? this.width,
      height: height ?? this.height,
      trackWidth: trackWidth ?? this.trackWidth,
      trackHeight: trackHeight ?? this.trackHeight,
      trackRadius: trackRadius ?? this.trackRadius,
      trackInnerStart: trackInnerStart ?? this.trackInnerStart,
      trackInnerEnd: trackInnerEnd ?? this.trackInnerEnd,
      thumbRadius: thumbRadius ?? this.thumbRadius,
      activeColor: activeColor ?? this.activeColor,
      trackColor: trackColor ?? this.trackColor,
      thumbColor: thumbColor ?? this.thumbColor,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      labelColor: labelColor ?? this.labelColor,
      paragraphColor: paragraphColor ?? this.paragraphColor,
      borderRadius: borderRadius ?? this.borderRadius,
    );
  }
}

GtbSwitcherThemeData createDefaultSwitcherTheme({
  required GtbColorScheme colorScheme,
  required GtbBorderThemeData borderTheme,
  required GtbTypography typography,
}) {
  final switcherStyle = GtbSwitcherStyle(
    width: 48.0,
    height: 48.0,
    trackWidth: 40.0,
    trackHeight: 20.0,
    trackRadius: 10.0,
    trackInnerStart: 10.0,
    trackInnerEnd: 30.0,
    thumbRadius: 8.0,
    activeColor: generateState(
      colorScheme.actionSecondarySelected,
      disabled: colorScheme.actionDisabledBase,
    ),
    trackColor: generateState(colorScheme.actionDisabledBase),
    thumbColor: generateState(
      colorScheme.specialFixedWhite,
      disabled: colorScheme.specialFixedWhite.withValues(alpha: 0.5),
    ),
    backgroundColor: generateState(kTransparentColor),
    labelColor: generateState(kTransparentColor),
    paragraphColor: generateState(kTransparentColor),
    borderRadius: borderTheme.radiusSmall,
  );

  final switcherBoxStyle = switcherStyle.copyWith(
    backgroundColor: generateState(
      colorScheme.actionNeutralEnabled,
      pressed: colorScheme.actionNeutralPressed,
      disabled: colorScheme.actionDisabledBase,
    ),
    labelColor: generateState(
      colorScheme.onColorEmphasisHigh,
      disabled: colorScheme.onColorEmphasisDisabled,
    ),
    paragraphColor: generateState(
      colorScheme.onColorEmphasisMedium,
      disabled: colorScheme.onColorEmphasisDisabled,
    ),
  );

  final switcherLabelStyle = switcherBoxStyle;

  return GtbSwitcherThemeData(
    switcherStyle: switcherStyle,
    switcherBoxStyle: switcherBoxStyle,
    switcherLabelStyle: switcherLabelStyle,
  );
}
