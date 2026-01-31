import 'package:flutter/material.dart';
import 'package:gtb_teatro/design_system/gtb_teatro.dart';

const _searchAnimationsDuration = Duration(milliseconds: 250);
const _searchAnimationsCurve = Curves.easeInOut;

final class GtbInputTag extends StatefulWidget {
  const GtbInputTag({
    super.key,
    this.controller,
    this.focusNode,
    this.onInsert,
    this.onTapOutside,
    this.placeholder,
  });

  final TextEditingController? controller;
  final FocusNode? focusNode;
  final VoidCallback? onInsert;
  final TapRegionCallback? onTapOutside;
  final Widget? placeholder;

  @override
  State<GtbInputTag> createState() => _GtbInputTagState();
}

final class _GtbInputTagState extends State<GtbInputTag> with TickerProviderStateMixin {
  late final AnimationController _focusAnimationController;
  late final Animation<double> _focusAnimation;

  late FocusNode _focusNode;
  late TextEditingController _textEditingController;

  @override
  void initState() {
    super.initState();

    _focusAnimationController = AnimationController(vsync: this, duration: _searchAnimationsDuration);

    _focusAnimation = CurvedAnimation(
      parent: _focusAnimationController,
      curve: _searchAnimationsCurve,
    );

    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(_handleChangesInFocusNode);

    _textEditingController = widget.controller ?? TextEditingController();
  }

  @override
  void didUpdateWidget(GtbInputTag oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.focusNode != oldWidget.focusNode) {
      if (oldWidget.focusNode == null) {
        _focusNode.removeListener(_handleChangesInFocusNode);
        _focusNode.dispose();
      }

      _focusNode = widget.focusNode ?? FocusNode();
      _focusNode.addListener(_handleChangesInFocusNode);
    }

    if (widget.controller != oldWidget.controller) {
      if (oldWidget.controller == null) {
        _textEditingController.dispose();
      }

      _textEditingController = widget.controller ?? TextEditingController();
    }
  }

  @override
  void dispose() {
    _focusNode.removeListener(_handleChangesInFocusNode);

    if (widget.focusNode == null) {
      _focusNode.dispose();
    }

    if (widget.controller == null) {
      _textEditingController.dispose();
    }

    super.dispose();
  }

  void _handleChangesInFocusNode() {
    if (_focusNode.hasFocus) {
      _focusAnimationController.forward();
    } else {
      _focusAnimationController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = GtbThemeProvider.of(context);
    final colorScheme = theme.appColorScheme;
    final typography = theme.typography;

    return AnimatedBuilder(
      animation: _focusAnimation,
      builder: (context, child) {
        final borderColor = colorScheme.outlineBase;

        final borderSide = GtbBorderSide(
          color: borderColor,
          stroke: 1.0,
          borderStyle: const GtbBorderStyle.solid(),
        );

        final defaultBorder = GtbBorder.fromGtbBorderSide(borderSide);

        return MouseRegion(
          cursor: SystemMouseCursors.text,
          child: TextFieldTapRegion(
            onTapOutside: widget.onTapOutside,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: colorScheme.neutralBase,
                border: defaultBorder,
                borderRadius: BorderRadius.circular(GtbGapValue.xxxs),
              ),
              child: Material(
                color: kTransparentColor,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: GtbPaddingValue.xxs,
                    horizontal: GtbPaddingValue.xs,
                  ),
                  child: ListenableBuilder(
                    listenable: _textEditingController,
                    builder: (context, child) {
                      return Row(
                        children: [
                          child!,
                          GtbGap.xxxs,
                          Expanded(
                            child: ListenableBuilder(
                              listenable: _focusNode,
                              builder: (context, child) {
                                return Stack(
                                  children: [
                                    child!,
                                    if (_textEditingController.text.isEmpty)
                                      if (widget.placeholder case final placeholder?)
                                        DefaultTextStyle(
                                          style: typography.bodyBase.copyWith(
                                            color: colorScheme.onColorEmphasisLow,
                                            leadingDistribution: TextLeadingDistribution.even,
                                          ),
                                          child: IgnorePointer(
                                            child: placeholder,
                                          ),
                                        ),
                                  ],
                                );
                              },
                              child: EditableText(
                                controller: _textEditingController,
                                focusNode: _focusNode,
                                style: typography.bodyBase.copyWith(
                                  color: colorScheme.onColorEmphasisHigh,
                                  leadingDistribution: TextLeadingDistribution.even,
                                ),
                                cursorColor: colorScheme.onColorEmphasisHigh,
                                backgroundCursorColor: colorScheme.supportAqua50,
                              ),
                            ),
                          ),
                          GtbGap.xs,
                          AnimatedOpacity(
                            duration: _searchAnimationsDuration,
                            curve: _searchAnimationsCurve,
                            opacity: _textEditingController.text.isEmpty ? 0.0 : 1.0,
                            child: GtbLink(
                              label: const Text('Inserir'),
                              isUnderline: true,
                              onPress: () {
                                widget.onInsert?.call();
                                _textEditingController.clear();
                              },
                            ),
                          ),
                          GtbGap.xxs,
                        ],
                      );
                    },
                    child: const GtbIconContainer(
                      icon: GtbIcons.toolsSearch,
                      size: GtbIconContainerSize.size24,
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
