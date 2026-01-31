import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gtb_teatro/design_system/color_scheme/color_scheme.dart';
import 'package:gtb_teatro/design_system/color_scheme/color_scheme_provider.dart';
import 'package:gtb_teatro/design_system/components/global/global_loader.dart';
import 'package:gtb_teatro/design_system/components/ui/gtb_border.dart';
import 'package:gtb_teatro/design_system/components/ui/gtb_icon_container.dart';
import 'package:gtb_teatro/design_system/foundation/icons.dart';
import 'package:gtb_teatro/design_system/foundation/lerp.dart';
import 'package:gtb_teatro/design_system/foundation/spacing.dart';
import 'package:gtb_teatro/design_system/foundation/typography.dart';
import 'package:gtb_teatro/design_system/foundation/widget_state_property.dart';
import 'package:prototype_constrained_box/prototype_constrained_box.dart';

enum GtbTextFieldState {
  enabled,
  disabled,
  error,
  loading,
}

enum GtbTextFieldControlButtonState {
  enabled,
  disabled,
  error,
}

enum GtbTextFieldSize {
  small,
  large,
}

enum _GtbTextFieldType {
  standard,
  area,
}

final class GtbTextField extends StatelessWidget {
  const GtbTextField({
    required this.state,
    required this.size,
    super.key,
    this.characterLimit,
    this.leading,
    this.trailing,
    this.label,
    this.description,
    this.hintText,
    this.controller,
    this.focusNode,
    this.keyboardType,
    this.onTapOutside,
    this.autofocus = false,
    this.onSubmit,
    this.inputFormatters,
    this.shouldObscureText = false,
    this.obscuringCharacter = '•',
    this.textCapitalization = TextCapitalization.none,
    this.shouldBlockOnCharacterLimit = true,
  });

  final GtbTextFieldState state;
  final GtbTextFieldSize size;
  final int? characterLimit;
  final bool shouldBlockOnCharacterLimit;
  final Widget? leading;
  final Widget? trailing;
  final Widget? label;
  final Widget? description;
  final String? hintText;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final TapRegionCallback? onTapOutside;
  final bool autofocus;
  final ValueChanged<String>? onSubmit;
  final List<TextInputFormatter>? inputFormatters;
  final bool shouldObscureText;
  final String obscuringCharacter;
  final TextCapitalization textCapitalization;

  @override
  Widget build(BuildContext context) {
    return _GtbTextFieldBase(
      type: _GtbTextFieldType.standard,
      characterLimit: characterLimit,
      state: state,
      size: size,
      leading: leading,
      trailing: trailing,
      label: label,
      description: description,
      hintText: hintText,
      controller: controller,
      focusNode: focusNode,
      keyboardType: keyboardType,
      onTapOutside: onTapOutside,
      autofocus: autofocus,
      onSubmit: onSubmit,
      inputFormatters: inputFormatters,
      shouldObscureText: shouldObscureText,
      obscuringCharacter: obscuringCharacter,
      textCapitalization: textCapitalization,
      shouldBlockOnCharacterLimit: shouldBlockOnCharacterLimit,
    );
  }
}

final class GtbTextFieldArea extends StatelessWidget {
  const GtbTextFieldArea({
    required this.state,
    required this.size,
    super.key,
    this.characterLimit,
    this.label,
    this.description,
    this.hintText,
    this.controller,
    this.focusNode,
    this.keyboardType,
    this.onTapOutside,
    this.autofocus = false,
    this.onSubmit,
    this.inputFormatters,
    this.shouldObscureText = false,
    this.obscuringCharacter = '•',
    this.shouldBlockOnCharacterLimit = true,
    this.hasCounter = true,
  }) : assert(state != GtbTextFieldState.loading, 'GtbTextFieldArea cannot have a loading state.');

  final GtbTextFieldState state;
  final GtbTextFieldSize size;
  final int? characterLimit;
  final Widget? label;
  final Widget? description;
  final String? hintText;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final TapRegionCallback? onTapOutside;
  final bool autofocus;
  final ValueChanged<String>? onSubmit;
  final List<TextInputFormatter>? inputFormatters;
  final bool shouldObscureText;
  final bool hasCounter;
  final String obscuringCharacter;
  final bool shouldBlockOnCharacterLimit;

  @override
  Widget build(BuildContext context) {
    return _GtbTextFieldBase(
      type: _GtbTextFieldType.area,
      state: state,
      size: size,
      label: label,
      description: description,
      hintText: hintText,
      characterLimit: characterLimit,
      controller: controller,
      focusNode: focusNode,
      keyboardType: keyboardType,
      onTapOutside: onTapOutside,
      autofocus: autofocus,
      onSubmit: onSubmit,
      inputFormatters: inputFormatters,
      shouldObscureText: shouldObscureText,
      obscuringCharacter: obscuringCharacter,
      shouldBlockOnCharacterLimit: shouldBlockOnCharacterLimit,
      hasCounter: hasCounter,
    );
  }
}

class _GtbTextFieldBase extends StatefulWidget {
  const _GtbTextFieldBase({
    required this.type,
    required this.state,
    required this.size,
    this.characterLimit,
    this.leading,
    this.trailing,
    this.label,
    this.description,
    this.hintText,
    this.controller,
    this.focusNode,
    this.keyboardType,
    this.onTapOutside,
    this.autofocus = false,
    this.onSubmit,
    this.inputFormatters,
    this.shouldObscureText = false,
    this.obscuringCharacter = '•',
    this.textCapitalization = TextCapitalization.none,
    this.shouldBlockOnCharacterLimit = false,
    this.hasCounter = false,
  });

  final _GtbTextFieldType type;
  final GtbTextFieldState state;
  final GtbTextFieldSize size;
  final int? characterLimit;
  final Widget? leading;
  final Widget? trailing;
  final Widget? label;
  final Widget? description;
  final String? hintText;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final TapRegionCallback? onTapOutside;
  final bool autofocus;
  final ValueChanged<String>? onSubmit;
  final List<TextInputFormatter>? inputFormatters;
  final bool shouldObscureText;
  final String obscuringCharacter;
  final TextCapitalization textCapitalization;
  final bool hasCounter;
  final bool shouldBlockOnCharacterLimit;

  @override
  State<_GtbTextFieldBase> createState() => _GtbTextFieldBaseState();
}

class _GtbTextFieldBaseState extends State<_GtbTextFieldBase> {
  late TextEditingController controller = widget.controller ?? TextEditingController();
  late FocusNode focusNode = widget.focusNode ?? FocusNode();

  @override
  void didUpdateWidget(covariant _GtbTextFieldBase oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.controller != widget.controller) {
      if (oldWidget.controller == null) {
        controller.dispose();
      }

      controller = widget.controller ?? TextEditingController();
    }

    if (oldWidget.focusNode != widget.focusNode) {
      if (oldWidget.focusNode == null) {
        focusNode.dispose();
      }

      focusNode = widget.focusNode ?? FocusNode();
    }
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      controller.dispose();
    }

    if (widget.focusNode == null) {
      focusNode.dispose();
    }

    super.dispose();
  }

  GtbTextFieldState get state {
    return switch (widget) {
      _GtbTextFieldBase(:final characterLimit?) when controller.text.length > characterLimit =>
        GtbTextFieldState.error,
      _GtbTextFieldBase(:final state) => state,
    };
  }

  GtbInputStyle get style {
    final theme = GtbInputTheme.of(context);
    final typography = GtbThemeProvider.of(context).typography;

    final inputStyle = switch (state) {
      GtbTextFieldState.enabled when focusNode.hasFocus => theme.focusWritingInputStyle,
      GtbTextFieldState.enabled when controller.text.isNotEmpty => theme.populatedInputStyle,
      GtbTextFieldState.enabled => theme.enabledInputStyle,
      GtbTextFieldState.disabled => theme.disabledInputStyle,
      GtbTextFieldState.error => theme.errorInputStyle,
      GtbTextFieldState.loading => theme.loadingInputStyle,
    };

    final textStyle = switch (widget.size) {
      GtbTextFieldSize.small => typography.bodyBase,
      GtbTextFieldSize.large => typography.titleBase,
    };

    return inputStyle.copyWith(
      textFieldStyle: textStyle.copyWith(
        color: inputStyle.textFieldStyle.color,
      ),
      hintStyle: textStyle.copyWith(
        color: inputStyle.hintStyle.color,
      ),
    );
  }

  bool get hasCharacterLimit {
    if (widget.characterLimit case final characterLimit?) {
      return characterLimit > 0;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final hasError = widget.state == GtbTextFieldState.error;
    final hasDescriptionOrCharacterCounter =
        widget.description != null || //
        (hasCharacterLimit && widget.hasCounter);
    final hasTrailing =
        state == GtbTextFieldState.loading ||
        (widget.type == _GtbTextFieldType.area && hasCharacterLimit) ||
        widget.trailing != null;

    return IgnorePointer(
      ignoring: state == GtbTextFieldState.disabled,
      child: MouseRegion(
        cursor: SystemMouseCursors.text,
        child: TextFieldTapRegion(
          onTapOutside: widget.onTapOutside,
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: focusNode.requestFocus,
            child: ListenableBuilder(
              listenable: Listenable.merge([controller, focusNode]),
              builder: (context, child) {
                final iconSize = switch (widget.size) {
                  GtbTextFieldSize.small => GtbIconContainerSize.size16.value,
                  GtbTextFieldSize.large => GtbIconContainerSize.size24.value,
                };

                final iconContainerSize = switch (widget.size) {
                  GtbTextFieldSize.small => GtbIconContainerSize.size16,
                  GtbTextFieldSize.large => GtbIconContainerSize.size24,
                };

                return Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (widget.label case final label?)
                      DefaultTextStyle(
                        style: style.labelStyle,
                        child: label,
                      ),
                    GtbGap.xxxs,
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (widget.leading case final leading?) ...[
                          GtbIconContainerTheme(
                            data: GtbIconContainerTheme.of(context).copyWith(
                              foregroundColor: style.leadingColor,
                              size: iconContainerSize,
                            ),
                            child: leading,
                          ),
                          GtbGap.xxxs,
                        ],
                        Expanded(
                          child: TextField(
                            autofocus: widget.autofocus,
                            controller: controller,
                            focusNode: focusNode,
                            style: style.textFieldStyle,
                            buildCounter:
                                (
                                  context, {
                                  required currentLength,
                                  required isFocused,
                                  required maxLength,
                                }) {
                                  return null;
                                },
                            maxLength: widget.shouldBlockOnCharacterLimit && hasCharacterLimit
                                ? (widget.characterLimit) //
                                : null,
                            decoration: InputDecoration(
                              hintText: widget.hintText,
                              hintStyle: style.hintStyle,
                              border: InputBorder.none,
                              isCollapsed: true,
                            ),
                            keyboardType: widget.keyboardType,
                            onSubmitted: widget.onSubmit,
                            obscureText: widget.shouldObscureText,
                            obscuringCharacter: widget.obscuringCharacter,
                            inputFormatters: widget.inputFormatters,
                            textCapitalization: widget.textCapitalization,
                          ),
                        ),
                        if (hasTrailing) ...[
                          GtbGap.xxxs,
                          switch (widget) {
                            _GtbTextFieldBase() when state == GtbTextFieldState.loading =>
                              GtbGlobalLoaderSmall(
                                color: style.trailingColor,
                                size: switch (widget.size) {
                                  GtbTextFieldSize.small => GtbGlobalLoaderSmallSize.size16,
                                  GtbTextFieldSize.large => GtbGlobalLoaderSmallSize.size24,
                                },
                              ),
                            _GtbTextFieldBase(:final characterLimit?)
                                when widget.type == _GtbTextFieldType.area =>
                              SizedBox(
                                width: iconSize,
                                height: iconSize,
                                child: CircularProgressIndicator(
                                  value:
                                      min(controller.text.length, characterLimit) / characterLimit,
                                  color: style.filledProgressColor,
                                  backgroundColor: style.emptyProgressColor,
                                  strokeWidth: 2.0,
                                ),
                              ),
                            _GtbTextFieldBase(:final trailing?) => GtbIconContainerTheme(
                              data: GtbIconContainerTheme.of(context).copyWith(
                                foregroundColor: style.trailingColor,
                                size: iconContainerSize,
                              ),
                              child: GtbIconContainerTheme(
                                data: GtbIconContainerTheme.of(context).copyWith(
                                  foregroundColor: style.trailingColor,
                                  size: iconContainerSize,
                                ),
                                child: trailing,
                              ),
                            ),
                            _GtbTextFieldBase() => const SizedBox.shrink(),
                          },
                        ],
                      ],
                    ),
                    GtbGap.xxxs,
                    Divider(
                      height: 1.0,
                      thickness: 1.0,
                      color: style.baselineColor,
                    ),
                    if (hasDescriptionOrCharacterCounter) ...[
                      GtbGap.xxxs,
                      Row(
                        children: [
                          if (widget.description case final description?) ...[
                            if (hasError) ...[
                              GtbIconContainer(
                                icon: GtbIcons.statusError,
                                size: GtbIconContainerSize.size16,
                                color: style.errorIconColor,
                              ),
                              GtbGap.xxs,
                            ],
                            Expanded(
                              child: DefaultTextStyle(
                                style: hasError
                                    ? (style.errorDescriptionStyle) //
                                    : style.descriptionStyle,
                                child: description,
                              ),
                            ),
                          ] else
                            const Spacer(),
                          if (widget.hasCounter) ...[
                            GtbGap.xs,
                            Align(
                              alignment: Alignment.topCenter,
                              child: Text(
                                hasCharacterLimit
                                    ? '${controller.text.length} / ${widget.characterLimit}' //
                                    : '${controller.text.length}',
                                style: style.descriptionStyle,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

final class GtbTextFieldControlButton extends StatelessWidget {
  const GtbTextFieldControlButton({
    required this.state,
    super.key,
    this.onTapMinus,
    this.onTapPlus,
    this.onLongPressUpdateMinus,
    this.onLongPressUpdatePlus,
    this.controller,
    this.focusNode,
    this.keyboardType,
    this.onTapOutside,
    this.autofocus = false,
    this.onSubmit,
    this.inputFormatters,
    this.longPressUpdateInterval = const Duration(milliseconds: 150),
  });

  final GtbTextFieldControlButtonState state;
  final VoidCallback? onTapMinus;
  final VoidCallback? onTapPlus;
  final VoidCallback? onLongPressUpdateMinus;
  final VoidCallback? onLongPressUpdatePlus;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final TapRegionCallback? onTapOutside;
  final bool autofocus;
  final ValueChanged<String>? onSubmit;
  final List<TextInputFormatter>? inputFormatters;
  final Duration longPressUpdateInterval;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: GtbGapValue.xs,
      children: [
        TextFieldTapRegion(
          onTapOutside: onTapOutside,
          child: GtbSubTextFieldControlButton(
            kind: GtbSubTextFieldControlButtonKind.minus,
            longPressUpdateInterval: longPressUpdateInterval,
            onTap: state == GtbTextFieldControlButtonState.disabled
                ? null //
                : onTapMinus,
            onLongPressUpdate: state == GtbTextFieldControlButtonState.disabled
                ? null //
                : onLongPressUpdateMinus,
          ),
        ),
        Expanded(
          child: Center(
            child: _GtbSubTextFieldControlInput(
              state: state,
              controller: controller,
              focusNode: focusNode,
              keyboardType: keyboardType,
              autofocus: autofocus,
              onSubmit: onSubmit,
              inputFormatters: inputFormatters,
            ),
          ),
        ),
        TextFieldTapRegion(
          onTapOutside: onTapOutside,
          child: GtbSubTextFieldControlButton(
            kind: GtbSubTextFieldControlButtonKind.plus,
            longPressUpdateInterval: longPressUpdateInterval,
            onTap: state == GtbTextFieldControlButtonState.disabled
                ? null //
                : onTapPlus,
            onLongPressUpdate: state == GtbTextFieldControlButtonState.disabled
                ? null //
                : onLongPressUpdatePlus,
          ),
        ),
      ],
    );
  }
}

class _GtbSubTextFieldControlInput extends StatefulWidget {
  const _GtbSubTextFieldControlInput({
    required this.state,
    this.controller,
    this.focusNode,
    this.keyboardType,
    this.autofocus = false,
    this.onSubmit,
    this.inputFormatters,
  });

  final GtbTextFieldControlButtonState state;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final bool autofocus;
  final ValueChanged<String>? onSubmit;
  final List<TextInputFormatter>? inputFormatters;

  @override
  State<_GtbSubTextFieldControlInput> createState() => _GtbSubTextFieldControlInputState();
}

class _GtbSubTextFieldControlInputState extends State<_GtbSubTextFieldControlInput> {
  late TextEditingController controller = widget.controller ?? TextEditingController();
  late FocusNode focusNode = widget.focusNode ?? FocusNode();

  @override
  void didUpdateWidget(_GtbSubTextFieldControlInput oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.controller != widget.controller) {
      if (oldWidget.controller == null) {
        controller.dispose();
      }

      controller = widget.controller ?? TextEditingController();
    }

    if (oldWidget.focusNode != widget.focusNode) {
      if (oldWidget.focusNode == null) {
        focusNode.dispose();
      }

      focusNode = widget.focusNode ?? FocusNode();
    }
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      controller.dispose();
    }

    if (widget.focusNode == null) {
      focusNode.dispose();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final inputTheme = GtbInputControlButtonTheme.of(context);

    return ListenableBuilder(
      listenable: focusNode,
      builder: (context, child) {
        final states = {
          if (focusNode.hasFocus) //
            WidgetState.focused,
          if (widget.state == GtbTextFieldControlButtonState.disabled) //
            WidgetState.disabled,
          if (widget.state == GtbTextFieldControlButtonState.error) //
            WidgetState.error,
        };

        return PrototypeConstrainedBox.tightFor(
          height: true,
          prototype: const Material(
            child: GtbSubTextFieldControlButton(
              kind: GtbSubTextFieldControlButtonKind.minus,
              longPressUpdateInterval: Duration.zero,
            ),
          ),
          child: Container(
            constraints: BoxConstraints(
              minWidth: MediaQuery.textScalerOf(context).scale(100.0),
            ),
            decoration: BoxDecoration(
              color: inputTheme.textFieldBackgroundColor.resolve(states),
              borderRadius: BorderRadius.all(inputTheme.borderRadius),
              border: inputTheme.buttonBorder,
            ),
            child: IntrinsicWidth(
              child: Center(
                child: TextField(
                  readOnly: widget.state == GtbTextFieldControlButtonState.disabled,
                  autofocus: widget.autofocus,
                  controller: controller,
                  focusNode: focusNode,
                  style: inputTheme.textFieldStyle.resolve(states),
                  textAlign: TextAlign.center,
                  textAlignVertical: TextAlignVertical.center,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: GtbPaddingValue.xs,
                      vertical: GtbPaddingValue.xxs,
                    ),
                    border: InputBorder.none,
                    isCollapsed: true,
                  ),
                  keyboardType: widget.keyboardType,
                  onSubmitted: widget.onSubmit,
                  inputFormatters: widget.inputFormatters,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

enum GtbSubTextFieldControlButtonKind {
  minus,
  plus,
}

final class GtbSubTextFieldControlButton extends StatefulWidget {
  const GtbSubTextFieldControlButton({
    required this.kind,
    required this.longPressUpdateInterval,
    super.key,
    this.onTap,
    this.onLongPressUpdate,
  });

  final GtbSubTextFieldControlButtonKind kind;
  final Duration longPressUpdateInterval;
  final VoidCallback? onTap;
  final VoidCallback? onLongPressUpdate;

  @override
  State<GtbSubTextFieldControlButton> createState() => _GtbSubTextFieldControlButtonState();
}

class _GtbSubTextFieldControlButtonState extends State<GtbSubTextFieldControlButton> {
  late bool _isEnabled = widget.onTap != null || widget.onLongPressUpdate != null;
  bool _isPressed = false;
  Timer? _timer;

  @override
  void didUpdateWidget(GtbSubTextFieldControlButton oldWidget) {
    super.didUpdateWidget(oldWidget);

    final isEnabled = widget.onTap != null || widget.onLongPressUpdate != null;

    if (_isEnabled != isEnabled) {
      _isEnabled = isEnabled;

      if (!isEnabled) {
        _isPressed = false;
        _timer?.cancel();
      }
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final inputTheme = GtbInputControlButtonTheme.of(context);

    final states = <WidgetState>{
      if (_isPressed) WidgetState.pressed,
      if (!_isEnabled) WidgetState.disabled,
    };

    final icon = switch (widget.kind) {
      GtbSubTextFieldControlButtonKind.minus => GtbIcons.addMinus,
      GtbSubTextFieldControlButtonKind.plus => GtbIcons.addPlus,
    };

    return GestureDetector(
      onTapDown: (details) => _onUpdatePressed(value: true),
      onTapUp: (details) => _onUpdatePressed(value: false),
      onTapCancel: () => _onUpdatePressed(value: false),
      onLongPressStart: (details) => _startLongPress(),
      onLongPressEnd: (details) => _stopLongPress(),
      onTap: widget.onTap,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: inputTheme.buttonBackgroundColor.resolve(states),
          borderRadius: BorderRadius.all(inputTheme.borderRadius),
          border: inputTheme.buttonBorder,
        ),
        child: Padding(
          padding: const EdgeInsets.all(GtbGapValue.xxs),
          child: GtbIconContainer(
            icon: icon,
            color: inputTheme.buttonIconColor.resolve(states),
            size: inputTheme.buttonIconSize,
          ),
        ),
      ),
    );
  }

  void _onUpdatePressed({required bool value}) {
    if (_isEnabled && _isPressed != value) {
      setState(() => _isPressed = value);
    }
  }

  void _startLongPress() {
    if (widget.onLongPressUpdate case final onLongPressUpdate?) {
      setState(() {
        _isPressed = true;
      });

      onLongPressUpdate();
      _timer = Timer.periodic(
        widget.longPressUpdateInterval,
        (timer) => onLongPressUpdate(),
      );
    }
  }

  void _stopLongPress() {
    setState(() {
      _isPressed = false;
    });

    _timer?.cancel();
    _timer = null;
  }
}

final class GtbInputControlButtonTheme extends InheritedTheme {
  const GtbInputControlButtonTheme({
    required super.child,
    required this.data,
    super.key,
  });

  final GtbInputControlButtonThemeData data;

  static GtbInputControlButtonThemeData of(BuildContext context) {
    final theme = context.dependOnInheritedWidgetOfExactType<GtbInputControlButtonTheme>();
    return theme?.data ?? GtbThemeProvider.of(context).inputControlButtonTheme;
  }

  @override
  bool updateShouldNotify(GtbInputControlButtonTheme oldWidget) {
    return oldWidget.data != data;
  }

  @override
  Widget wrap(BuildContext context, Widget child) {
    return GtbInputControlButtonTheme(
      data: data,
      child: child,
    );
  }
}

final class GtbInputControlButtonThemeData {
  GtbInputControlButtonThemeData({
    required this.buttonBorder,
    required this.borderRadius,
    required this.textFieldStyle,
    required this.textFieldBackgroundColor,
    required this.buttonBackgroundColor,
    required this.buttonIconColor,
    required this.buttonIconSize,
  });

  final BoxBorder buttonBorder;
  final Radius borderRadius;
  final WidgetStateProperty<TextStyle> textFieldStyle;
  final WidgetStateProperty<Color> textFieldBackgroundColor;
  final WidgetStateProperty<Color> buttonBackgroundColor;
  final WidgetStateProperty<Color> buttonIconColor;
  final GtbIconContainerSize buttonIconSize;

  static GtbInputControlButtonThemeData lerp(
    GtbInputControlButtonThemeData a,
    GtbInputControlButtonThemeData b,
    double t,
  ) {
    return GtbInputControlButtonThemeData(
      buttonBorder: BoxBorder.lerp(a.buttonBorder, b.buttonBorder, t)!,
      borderRadius: Radius.lerp(a.borderRadius, b.borderRadius, t)!,
      textFieldStyle:
          WidgetStateProperty.lerp(a.textFieldStyle, b.textFieldStyle, t, TextStyle.lerp)!
              as WidgetStateProperty<TextStyle>,
      textFieldBackgroundColor:
          WidgetStateProperty.lerp(
                a.textFieldBackgroundColor,
                b.textFieldBackgroundColor,
                t,
                Color.lerp,
              )!
              as WidgetStateProperty<Color>,
      buttonBackgroundColor:
          WidgetStateProperty.lerp(a.buttonBackgroundColor, b.buttonBackgroundColor, t, Color.lerp)!
              as WidgetStateProperty<Color>,
      buttonIconColor:
          WidgetStateProperty.lerp(a.buttonIconColor, b.buttonIconColor, t, Color.lerp)!
              as WidgetStateProperty<Color>,
      buttonIconSize: GtbIconContainerSize.lerp(a.buttonIconSize, b.buttonIconSize, t)!,
    );
  }

  GtbInputControlButtonThemeData copyWith({
    BoxBorder? buttonBorder,
    Radius? borderRadius,
    WidgetStateProperty<TextStyle>? textFieldStyle,
    WidgetStateProperty<Color>? textFieldBackgroundColor,
    WidgetStateProperty<Color>? buttonBackgroundColor,
    WidgetStateProperty<Color>? buttonIconColor,
    GtbIconContainerSize? buttonIconSize,
  }) {
    return GtbInputControlButtonThemeData(
      buttonBorder: buttonBorder ?? this.buttonBorder,
      borderRadius: borderRadius ?? this.borderRadius,
      textFieldStyle: textFieldStyle ?? this.textFieldStyle,
      textFieldBackgroundColor: textFieldBackgroundColor ?? this.textFieldBackgroundColor,
      buttonBackgroundColor: buttonBackgroundColor ?? this.buttonBackgroundColor,
      buttonIconColor: buttonIconColor ?? this.buttonIconColor,
      buttonIconSize: buttonIconSize ?? this.buttonIconSize,
    );
  }
}

GtbInputControlButtonThemeData createDefaultInputControlButtonTheme({
  required GtbColorScheme colorScheme,
  required GtbBorderThemeData borderTheme,
  required GtbTypography typography,
}) {
  return GtbInputControlButtonThemeData(
    buttonBorder: GtbBorder.all(
      stroke: borderTheme.strokeThin,
      color: colorScheme.outlineBase,
    ),
    borderRadius: const Radius.circular(GtbGapValue.xxxs),
    textFieldStyle: WidgetStateProperty.resolveWith((states) {
      final baseStyle = typography.bodyBase;

      if (states.contains(WidgetState.disabled)) {
        return baseStyle.copyWith(
          color: colorScheme.actionDisabledBase,
        );
      } else if (states.contains(WidgetState.error)) {
        return baseStyle.copyWith(
          color: colorScheme.statusErrorBase,
        );
      } else if (states.contains(WidgetState.focused)) {
        return baseStyle.copyWith(
          color: colorScheme.onColorEmphasisHigh,
        );
      } else {
        return baseStyle.copyWith(
          color: colorScheme.onColorEmphasisLow,
        );
      }
    }),
    textFieldBackgroundColor: WidgetStateProperty.resolveWith(
      (states) {
        if (states.contains(WidgetState.error)) {
          return colorScheme.statusErrorBaseSurface;
        } else {
          return colorScheme.neutralBase;
        }
      },
    ),
    buttonBackgroundColor: generateState(
      colorScheme.actionNeutralEnabled,
      pressed: colorScheme.actionNeutralPressed,
      disabled: colorScheme.actionDisabledBase,
    ),
    buttonIconColor: generateState(
      colorScheme.onColorEmphasisHigh,
      pressed: colorScheme.onColorEmphasisHigh,
      disabled: colorScheme.onColorEmphasisDisabled,
    ),
    buttonIconSize: GtbIconContainerSize.size24,
  );
}

final class GtbInputTheme extends InheritedTheme {
  const GtbInputTheme({
    required super.child,
    required this.data,
    super.key,
  });

  final GtbInputThemeData data;

  static GtbInputThemeData of(BuildContext context) {
    final theme = context.dependOnInheritedWidgetOfExactType<GtbInputTheme>();
    return theme?.data ?? GtbThemeProvider.of(context).inputTheme;
  }

  @override
  bool updateShouldNotify(GtbInputTheme oldWidget) {
    return oldWidget.data != data;
  }

  @override
  Widget wrap(BuildContext context, Widget child) {
    return GtbInputTheme(
      data: data,
      child: child,
    );
  }
}

final class GtbInputThemeData {
  GtbInputThemeData({
    required this.enabledInputStyle,
    required this.disabledInputStyle,
    required this.focusWritingInputStyle,
    required this.populatedInputStyle,
    required this.errorInputStyle,
    required this.loadingInputStyle,
  });

  final GtbInputStyle enabledInputStyle;
  final GtbInputStyle disabledInputStyle;
  final GtbInputStyle focusWritingInputStyle;
  final GtbInputStyle populatedInputStyle;
  final GtbInputStyle errorInputStyle;
  final GtbInputStyle loadingInputStyle;

  static GtbInputThemeData lerp(GtbInputThemeData a, GtbInputThemeData b, double t) {
    return GtbInputThemeData(
      enabledInputStyle: GtbInputStyle.lerp(a.enabledInputStyle, b.enabledInputStyle, t),
      disabledInputStyle: GtbInputStyle.lerp(a.disabledInputStyle, b.disabledInputStyle, t),
      focusWritingInputStyle: GtbInputStyle.lerp(
        a.focusWritingInputStyle,
        b.focusWritingInputStyle,
        t,
      ),
      populatedInputStyle: GtbInputStyle.lerp(a.populatedInputStyle, b.populatedInputStyle, t),
      errorInputStyle: GtbInputStyle.lerp(a.errorInputStyle, b.errorInputStyle, t),
      loadingInputStyle: GtbInputStyle.lerp(a.loadingInputStyle, b.loadingInputStyle, t),
    );
  }

  GtbInputThemeData copyWith({
    GtbInputStyle? enabledInputStyle,
    GtbInputStyle? disabledInputStyle,
    GtbInputStyle? focusWritingInputStyle,
    GtbInputStyle? populatedInputStyle,
    GtbInputStyle? errorInputStyle,
    GtbInputStyle? loadingInputStyle,
  }) {
    return GtbInputThemeData(
      enabledInputStyle: enabledInputStyle ?? this.enabledInputStyle,
      disabledInputStyle: disabledInputStyle ?? this.disabledInputStyle,
      focusWritingInputStyle: focusWritingInputStyle ?? this.focusWritingInputStyle,
      populatedInputStyle: populatedInputStyle ?? this.populatedInputStyle,
      errorInputStyle: errorInputStyle ?? this.errorInputStyle,
      loadingInputStyle: loadingInputStyle ?? this.loadingInputStyle,
    );
  }

  GtbInputThemeData copyAllStylesWith({
    TextStyle? textFieldStyle,
    TextStyle? hintStyle,
    TextStyle? labelStyle,
    TextStyle? descriptionStyle,
    TextStyle? errorDescriptionStyle,
    double? progressSize,
    Color? baselineColor,
    Color? leadingColor,
    Color? trailingColor,
    Color? errorIconColor,
    Color? emptyProgressColor,
    Color? filledProgressColor,
  }) {
    return GtbInputThemeData(
      enabledInputStyle: enabledInputStyle.copyWith(
        textFieldStyle: textFieldStyle ?? enabledInputStyle.textFieldStyle,
        hintStyle: hintStyle ?? enabledInputStyle.hintStyle,
        labelStyle: labelStyle ?? enabledInputStyle.labelStyle,
        descriptionStyle: descriptionStyle ?? enabledInputStyle.descriptionStyle,
        errorDescriptionStyle: errorDescriptionStyle ?? enabledInputStyle.errorDescriptionStyle,
        progressSize: progressSize ?? enabledInputStyle.progressSize,
        baselineColor: baselineColor ?? enabledInputStyle.baselineColor,
        leadingColor: leadingColor ?? enabledInputStyle.leadingColor,
        trailingColor: trailingColor ?? enabledInputStyle.trailingColor,
        errorIconColor: errorIconColor ?? enabledInputStyle.errorIconColor,
        emptyProgressColor: emptyProgressColor ?? enabledInputStyle.emptyProgressColor,
        filledProgressColor: filledProgressColor ?? enabledInputStyle.filledProgressColor,
      ),
      disabledInputStyle: disabledInputStyle.copyWith(
        textFieldStyle: textFieldStyle ?? disabledInputStyle.textFieldStyle,
        hintStyle: hintStyle ?? disabledInputStyle.hintStyle,
        labelStyle: labelStyle ?? disabledInputStyle.labelStyle,
        descriptionStyle: descriptionStyle ?? disabledInputStyle.descriptionStyle,
        errorDescriptionStyle: errorDescriptionStyle ?? disabledInputStyle.errorDescriptionStyle,
        progressSize: progressSize ?? disabledInputStyle.progressSize,
        baselineColor: baselineColor ?? disabledInputStyle.baselineColor,
        leadingColor: leadingColor ?? disabledInputStyle.leadingColor,
        trailingColor: trailingColor ?? disabledInputStyle.trailingColor,
        errorIconColor: errorIconColor ?? disabledInputStyle.errorIconColor,
        emptyProgressColor: emptyProgressColor ?? disabledInputStyle.emptyProgressColor,
        filledProgressColor: filledProgressColor ?? disabledInputStyle.filledProgressColor,
      ),
      focusWritingInputStyle: focusWritingInputStyle.copyWith(
        textFieldStyle: textFieldStyle ?? focusWritingInputStyle.textFieldStyle,
        hintStyle: hintStyle ?? focusWritingInputStyle.hintStyle,
        labelStyle: labelStyle ?? focusWritingInputStyle.labelStyle,
        descriptionStyle: descriptionStyle ?? focusWritingInputStyle.descriptionStyle,
        errorDescriptionStyle:
            errorDescriptionStyle ?? focusWritingInputStyle.errorDescriptionStyle,
        progressSize: progressSize ?? focusWritingInputStyle.progressSize,
        baselineColor: baselineColor ?? focusWritingInputStyle.baselineColor,
        leadingColor: leadingColor ?? focusWritingInputStyle.leadingColor,
        trailingColor: trailingColor ?? focusWritingInputStyle.trailingColor,
        errorIconColor: errorIconColor ?? focusWritingInputStyle.errorIconColor,
        emptyProgressColor: emptyProgressColor ?? focusWritingInputStyle.emptyProgressColor,
        filledProgressColor: filledProgressColor ?? focusWritingInputStyle.filledProgressColor,
      ),
      populatedInputStyle: populatedInputStyle.copyWith(
        textFieldStyle: textFieldStyle ?? populatedInputStyle.textFieldStyle,
        hintStyle: hintStyle ?? populatedInputStyle.hintStyle,
        labelStyle: labelStyle ?? populatedInputStyle.labelStyle,
        descriptionStyle: descriptionStyle ?? populatedInputStyle.descriptionStyle,
        errorDescriptionStyle: errorDescriptionStyle ?? populatedInputStyle.errorDescriptionStyle,
        progressSize: progressSize ?? populatedInputStyle.progressSize,
        baselineColor: baselineColor ?? populatedInputStyle.baselineColor,
        leadingColor: leadingColor ?? populatedInputStyle.leadingColor,
        trailingColor: trailingColor ?? populatedInputStyle.trailingColor,
        errorIconColor: errorIconColor ?? populatedInputStyle.errorIconColor,
        emptyProgressColor: emptyProgressColor ?? populatedInputStyle.emptyProgressColor,
        filledProgressColor: filledProgressColor ?? populatedInputStyle.filledProgressColor,
      ),
      errorInputStyle: errorInputStyle.copyWith(
        textFieldStyle: textFieldStyle ?? errorInputStyle.textFieldStyle,
        hintStyle: hintStyle ?? errorInputStyle.hintStyle,
        labelStyle: labelStyle ?? errorInputStyle.labelStyle,
        descriptionStyle: descriptionStyle ?? errorInputStyle.descriptionStyle,
        errorDescriptionStyle: errorDescriptionStyle ?? errorInputStyle.errorDescriptionStyle,
        progressSize: progressSize ?? errorInputStyle.progressSize,
        baselineColor: baselineColor ?? errorInputStyle.baselineColor,
        leadingColor: leadingColor ?? errorInputStyle.leadingColor,
        trailingColor: trailingColor ?? errorInputStyle.trailingColor,
        errorIconColor: errorIconColor ?? errorInputStyle.errorIconColor,
        emptyProgressColor: emptyProgressColor ?? errorInputStyle.emptyProgressColor,
        filledProgressColor: filledProgressColor ?? errorInputStyle.filledProgressColor,
      ),
      loadingInputStyle: loadingInputStyle.copyWith(
        textFieldStyle: textFieldStyle ?? loadingInputStyle.textFieldStyle,
        hintStyle: hintStyle ?? loadingInputStyle.hintStyle,
        labelStyle: labelStyle ?? loadingInputStyle.labelStyle,
        descriptionStyle: descriptionStyle ?? loadingInputStyle.descriptionStyle,
        errorDescriptionStyle: errorDescriptionStyle ?? loadingInputStyle.errorDescriptionStyle,
        progressSize: progressSize ?? loadingInputStyle.progressSize,
        baselineColor: baselineColor ?? loadingInputStyle.baselineColor,
        leadingColor: leadingColor ?? loadingInputStyle.leadingColor,
        trailingColor: trailingColor ?? loadingInputStyle.trailingColor,
        errorIconColor: errorIconColor ?? loadingInputStyle.errorIconColor,
        emptyProgressColor: emptyProgressColor ?? loadingInputStyle.emptyProgressColor,
        filledProgressColor: filledProgressColor ?? loadingInputStyle.filledProgressColor,
      ),
    );
  }
}

final class GtbInputStyle {
  const GtbInputStyle({
    required this.textFieldStyle,
    required this.hintStyle,
    required this.labelStyle,
    required this.descriptionStyle,
    required this.errorDescriptionStyle,
    required this.progressSize,
    required this.baselineColor,
    required this.leadingColor,
    required this.trailingColor,
    required this.errorIconColor,
    required this.emptyProgressColor,
    required this.filledProgressColor,
  });

  final TextStyle textFieldStyle;
  final TextStyle hintStyle;
  final TextStyle labelStyle;
  final TextStyle descriptionStyle;
  final TextStyle errorDescriptionStyle;
  final double progressSize;
  final Color baselineColor;
  final Color leadingColor;
  final Color trailingColor;
  final Color errorIconColor;
  final Color emptyProgressColor;
  final Color filledProgressColor;

  static GtbInputStyle lerp(GtbInputStyle a, GtbInputStyle b, double t) {
    return GtbInputStyle(
      textFieldStyle: TextStyle.lerp(a.textFieldStyle, b.textFieldStyle, t)!,
      hintStyle: TextStyle.lerp(a.hintStyle, b.hintStyle, t)!,
      labelStyle: TextStyle.lerp(a.labelStyle, b.labelStyle, t)!,
      descriptionStyle: TextStyle.lerp(a.descriptionStyle, b.descriptionStyle, t)!,
      errorDescriptionStyle: TextStyle.lerp(a.errorDescriptionStyle, b.errorDescriptionStyle, t)!,
      progressSize: lerpDouble(a.progressSize, b.progressSize, t),
      baselineColor: Color.lerp(a.baselineColor, b.baselineColor, t)!,
      leadingColor: Color.lerp(a.leadingColor, b.leadingColor, t)!,
      trailingColor: Color.lerp(a.trailingColor, b.trailingColor, t)!,
      errorIconColor: Color.lerp(a.errorIconColor, b.errorIconColor, t)!,
      emptyProgressColor: Color.lerp(a.emptyProgressColor, b.emptyProgressColor, t)!,
      filledProgressColor: Color.lerp(a.filledProgressColor, b.filledProgressColor, t)!,
    );
  }

  GtbInputStyle copyWith({
    TextStyle? textFieldStyle,
    TextStyle? hintStyle,
    TextStyle? labelStyle,
    TextStyle? descriptionStyle,
    TextStyle? errorDescriptionStyle,
    double? iconSize,
    double? progressSize,
    Color? baselineColor,
    Color? leadingColor,
    Color? trailingColor,
    Color? errorIconColor,
    Color? emptyProgressColor,
    Color? filledProgressColor,
  }) {
    return GtbInputStyle(
      textFieldStyle: textFieldStyle ?? this.textFieldStyle,
      hintStyle: hintStyle ?? this.hintStyle,
      labelStyle: labelStyle ?? this.labelStyle,
      descriptionStyle: descriptionStyle ?? this.descriptionStyle,
      errorDescriptionStyle: errorDescriptionStyle ?? this.errorDescriptionStyle,
      progressSize: progressSize ?? this.progressSize,
      baselineColor: baselineColor ?? this.baselineColor,
      leadingColor: leadingColor ?? this.leadingColor,
      trailingColor: trailingColor ?? this.trailingColor,
      errorIconColor: errorIconColor ?? this.errorIconColor,
      emptyProgressColor: emptyProgressColor ?? this.emptyProgressColor,
      filledProgressColor: filledProgressColor ?? this.filledProgressColor,
    );
  }
}

GtbInputThemeData createDefaultInputTheme({
  required GtbColorScheme colorScheme,
  required GtbBorderThemeData borderTheme,
  required GtbTypography typography,
}) {
  final enabledInputStyle = GtbInputStyle(
    textFieldStyle: typography.bodyBase.copyWith(
      color: colorScheme.onColorEmphasisMedium,
    ),
    hintStyle: typography.bodyBase.copyWith(
      color: colorScheme.onColorEmphasisMedium,
    ),
    labelStyle: typography.captionBase.copyWith(
      color: colorScheme.onColorEmphasisMedium,
    ),
    descriptionStyle: typography.captionBase.copyWith(
      color: colorScheme.onColorEmphasisMedium,
    ),
    errorDescriptionStyle: typography.captionBase.copyWith(
      color: colorScheme.onColorEmphasisMedium,
    ),
    progressSize: 24.0,
    baselineColor: colorScheme.onColorEmphasisLow,
    leadingColor: colorScheme.onColorEmphasisMedium,
    trailingColor: colorScheme.onColorEmphasisMedium,
    errorIconColor: colorScheme.onColorEmphasisMedium,
    emptyProgressColor: colorScheme.neutralBaseInverse.withValues(alpha: 0.3),
    filledProgressColor: colorScheme.actionMainEnabled,
  );

  final disabledInputStyle = enabledInputStyle.copyWith(
    textFieldStyle: typography.bodyBase.copyWith(
      color: colorScheme.onColorEmphasisDisabled,
    ),
    hintStyle: typography.bodyBase.copyWith(
      color: colorScheme.onColorEmphasisDisabled,
    ),
    labelStyle: typography.captionBase.copyWith(
      color: colorScheme.onColorEmphasisDisabled,
    ),
    descriptionStyle: typography.captionBase.copyWith(
      color: colorScheme.onColorEmphasisDisabled,
    ),
    baselineColor: colorScheme.actionDisabledBase,
    leadingColor: colorScheme.onColorEmphasisDisabled,
    trailingColor: colorScheme.onColorEmphasisDisabled,
    errorIconColor: colorScheme.onColorEmphasisDisabled,
    emptyProgressColor: colorScheme.neutralBaseInverse.withValues(alpha: 0.3 * 0.3),
    filledProgressColor: colorScheme.actionMainEnabled.withValues(alpha: 0.3),
  );

  final focusWritingInputStyle = enabledInputStyle.copyWith(
    textFieldStyle: typography.bodyBase.copyWith(
      color: colorScheme.onColorEmphasisHigh,
    ),
    baselineColor: colorScheme.outlineBaseFocus,
    leadingColor: colorScheme.onColorEmphasisHigh,
    trailingColor: colorScheme.onColorEmphasisHigh,
    errorIconColor: colorScheme.onColorEmphasisMedium,
  );

  final populatedInputStyle = focusWritingInputStyle.copyWith(
    labelStyle: typography.captionBase.copyWith(
      color: colorScheme.onColorEmphasisHigh,
    ),
    descriptionStyle: typography.captionBase.copyWith(
      color: colorScheme.onColorEmphasisHigh,
    ),
    baselineColor: colorScheme.onColorEmphasisHigh,
    errorIconColor: colorScheme.onColorEmphasisHigh,
  );

  final errorInputStyle = enabledInputStyle.copyWith(
    textFieldStyle: typography.bodyBase.copyWith(
      color: colorScheme.statusErrorBase,
    ),
    hintStyle: typography.bodyBase.copyWith(
      color: colorScheme.statusErrorBase,
    ),
    labelStyle: typography.captionBase.copyWith(
      color: colorScheme.statusErrorBase,
    ),
    descriptionStyle: typography.captionBase.copyWith(
      color: colorScheme.statusErrorBase,
    ),
    baselineColor: colorScheme.statusErrorBase,
    leadingColor: colorScheme.statusErrorBase,
    trailingColor: colorScheme.statusErrorBase,
    errorIconColor: colorScheme.statusErrorBase,
    filledProgressColor: colorScheme.statusErrorBase,
  );

  final loadingInputStyle = disabledInputStyle.copyWith(
    textFieldStyle: typography.bodyBase.copyWith(
      color: colorScheme.onColorEmphasisLow,
    ),
    hintStyle: typography.bodyBase.copyWith(
      color: colorScheme.onColorEmphasisLow,
    ),
    labelStyle: typography.captionBase.copyWith(
      color: colorScheme.onColorEmphasisLow,
    ),
    descriptionStyle: typography.captionBase.copyWith(
      color: colorScheme.onColorEmphasisLow,
    ),
    baselineColor: colorScheme.outlineBaseFocus,
    leadingColor: colorScheme.onColorEmphasisLow,
    trailingColor: colorScheme.onColorEmphasisHigh,
    errorIconColor: colorScheme.onColorEmphasisLow,
  );

  return GtbInputThemeData(
    enabledInputStyle: enabledInputStyle,
    disabledInputStyle: disabledInputStyle,
    focusWritingInputStyle: focusWritingInputStyle,
    populatedInputStyle: populatedInputStyle,
    errorInputStyle: errorInputStyle,
    loadingInputStyle: loadingInputStyle,
  );
}
