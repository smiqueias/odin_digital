import 'package:flutter/material.dart';
import 'package:gtb_teatro/design_system/gtb_teatro.dart';
import 'package:intersperse/intersperse.dart';
import 'package:intl/intl.dart';

class GtbFilter extends StatelessWidget {
  const GtbFilter({
    required this.headerTitle,
    required this.slots,
    required this.primaryAction,
    required this.secondaryAction,
    super.key,
  });

  final String headerTitle;
  final List<GtbSubFilterSlot> slots;
  final GtbActionSettings<VoidCallback> primaryAction;
  final GtbActionSettings<VoidCallback> secondaryAction;

  @override
  Widget build(BuildContext context) {
    const sectionDivider = SliverToBoxAdapter(
      child: GtbGlobalDivider.sectionThin,
    );

    return Column(
      children: [
        _FilterHeader(title: headerTitle),
        Expanded(
          child: CustomScrollView(
            slivers: [
              for (final slot in slots) SliverToBoxAdapter(child: slot),
            ].intersperse(sectionDivider).toList(growable: false),
          ),
        ),
        GtbButtonFixed(
          button: GtbButton.fromActionSettings(actionSettings: primaryAction),
          link: GtbLink.fromActionSettings(actionSettings: secondaryAction),
        ),
      ],
    );
  }
}

class GtbSubFilterSlot extends StatelessWidget {
  const GtbSubFilterSlot({
    required this.kind,
    super.key,
    this.padding = const EdgeInsets.only(
      left: GtbPaddingValue.sm,
      right: GtbPaddingValue.sm,
      top: GtbPaddingValue.sm,
      bottom: GtbPaddingValue.md,
    ),
  });

  final GtbSubFilterSlotKind kind;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    final (title, subtitle, titleInfo, onClearLink) = switch (kind) {
      _GtbSubFilterSlotKindCheckbox(
        title: final title,
        subtitle: final subtitle,
        titleInfo: final titleInfo,
        onClearLink: final onClearLink,
      ) ||
      _GtbSubFilterSlotKindCustom(
        title: final title,
        subtitle: final subtitle,
        titleInfo: final titleInfo,
        onClearLink: final onClearLink,
      ) ||
      _GtbSubFilterSlotKindFilterTag(
        title: final title,
        subtitle: final subtitle,
        titleInfo: final titleInfo,
        onClearLink: final onClearLink,
      ) ||
      _GtbSubFilterSlotKindRadioButton(
        title: final title,
        subtitle: final subtitle,
        titleInfo: final titleInfo,
        onClearLink: final onClearLink,
      ) ||
      _GtbSubFilterSlotKindSlider(
        title: final title,
        subtitle: final subtitle,
        titleInfo: final titleInfo,
        onClearLink: final onClearLink,
      ) ||
      _GtbSubFilterSlotKindPeriod(
        title: final title,
        subtitle: final subtitle,
        titleInfo: final titleInfo,
        onClearLink: final onClearLink,
      ) => (title, subtitle, titleInfo, onClearLink),
      _GtbSubFilterSlotKindContent(
        title: final title,
        subtitle: final subtitle,
        titleInfo: final titleInfo,
      ) =>
        (
          title,
          subtitle,
          titleInfo,
          null,
        ),
      _GtbSubFilterSlotKindCheckboxContent() || _GtbSubFilterSlotKindSearchTag() => (null, null, null, null),
    };

    final slot = switch (kind) {
      _GtbSubFilterSlotKindCheckbox(labels: final labels) => _GtbSubFilterSlotCheckbox(labels: labels),
      _GtbSubFilterSlotKindCheckboxContent(label: final label, description: final description) => _GtbSubFilterSlotCheckboxContent(
        label: label,
        description: description,
      ),
      _GtbSubFilterSlotKindContent(link: final link) => _GtbSubFilterSlotContent(link: link),
      _GtbSubFilterSlotKindCustom(child: final child) => _GtbSubFilterSlotCustom(child: child),
      _GtbSubFilterSlotKindFilterTag(tags: final tags) => _GtbSubFilterSlotFilterTag(tags: tags),
      _GtbSubFilterSlotKindPeriod(
        periods: final periods,
        selectedValue: final selectedValue,
        hasCustomPeriod: final hasCustomPeriod,
        onChanged: final onChanged,
      ) =>
        _GtbSubFilterSlotPeriod(
          periods: periods,
          selectedValue: selectedValue,
          hasCustomPeriod: hasCustomPeriod,
          onChanged: onChanged,
        ),
      _GtbSubFilterSlotKindRadioButton(buttons: final buttons) => _GtbSubFilterSlotRadioButton(buttons: buttons),
      _GtbSubFilterSlotKindSearchTag(input: final input, tags: final tags) => _GtbSubFilterSlotSearchTag(
        input: input,
        tags: tags,
      ),
      _GtbSubFilterSlotKindSlider(slider: final slider) => _GtbSubFilterSlotSlider(slider: slider),
    };

    return Padding(
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null) //
            _GtbSubFilterSlotHeader(
              title: title,
              subtitle: subtitle,
              titleInfo: titleInfo,
              onClearLink: onClearLink,
            ),
          slot,
        ],
      ),
    );
  }
}

sealed class GtbSubFilterSlotKind {
  const GtbSubFilterSlotKind();

  const factory GtbSubFilterSlotKind.checkbox({
    required Widget title,
    required List<GtbCheckboxLabel> labels,
    Widget? subtitle,
    String? titleInfo,
    VoidCallback? onClearLink,
  }) = _GtbSubFilterSlotKindCheckbox;

  const factory GtbSubFilterSlotKind.checkboxContent({
    required GtbCheckboxLabel label,
    required Widget description,
  }) = _GtbSubFilterSlotKindCheckboxContent;

  const factory GtbSubFilterSlotKind.content({
    required Widget title,
    required GtbLink link,
    Widget? subtitle,
    String? titleInfo,
  }) = _GtbSubFilterSlotKindContent;

  const factory GtbSubFilterSlotKind.custom({
    required Widget title,
    required Widget child,
    Widget? subtitle,
    String? titleInfo,
    VoidCallback? onClearLink,
  }) = _GtbSubFilterSlotKindCustom;

  const factory GtbSubFilterSlotKind.filterTag({
    required Widget title,
    required List<GtbTagFilter> tags,
    Widget? subtitle,
    String? titleInfo,
    VoidCallback? onClearLink,
  }) = _GtbSubFilterSlotKindFilterTag;

  const factory GtbSubFilterSlotKind.period({
    required Widget title,
    required List<GtbFilterPeriod> periods,
    required GtbFilterPeriod? selectedValue,
    Widget? subtitle,
    String? titleInfo,
    VoidCallback? onClearLink,
    bool? hasCustomPeriod,
    ValueChanged<GtbFilterPeriod?>? onChanged,
  }) = _GtbSubFilterSlotKindPeriod;

  const factory GtbSubFilterSlotKind.radioButton({
    required Widget title,
    required List<GtbRadioButtonLabel<Object>> buttons,
    Widget? subtitle,
    String? titleInfo,
    VoidCallback? onClearLink,
  }) = _GtbSubFilterSlotKindRadioButton<Object>;

  const factory GtbSubFilterSlotKind.searchTag({
    required GtbInputTag input,
    required List<GtbTagSearch> tags,
  }) = _GtbSubFilterSlotKindSearchTag;

  const factory GtbSubFilterSlotKind.slider({
    required Widget title,
    required GtbSlider slider,
    Widget? subtitle,
    String? titleInfo,
    VoidCallback? onClearLink,
  }) = _GtbSubFilterSlotKindSlider;
}

class _FilterHeader extends StatelessWidget {
  const _FilterHeader({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    final theme = GtbThemeProvider.of(context);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: GtbPaddingValue.sm,
            right: GtbPaddingValue.sm - kIconButtonExtraSpacing,
            top: GtbPaddingValue.xs - kIconButtonExtraSpacing,
            bottom: GtbPaddingValue.xs - kIconButtonExtraSpacing,
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: theme.typography.titleSmall.copyWith(
                    color: theme.appColorScheme.onColorEmphasisHigh,
                  ),
                ),
              ),
              GtbGap.xxs,
              GtbIconButton(
                icon: const Icon(GtbIcons.close),
                onPress: Navigator.of(context).pop,
              ),
            ],
          ),
        ),
        GtbGlobalDivider.sectionThin,
      ],
    );
  }
}

final class _GtbSubFilterSlotKindCheckbox extends GtbSubFilterSlotKind {
  const _GtbSubFilterSlotKindCheckbox({
    required this.title,
    required this.labels,
    this.subtitle,
    this.titleInfo,
    this.onClearLink,
  });

  final Widget title;
  final Widget? subtitle;
  final String? titleInfo;
  final VoidCallback? onClearLink;
  final List<GtbCheckboxLabel> labels;
}

final class _GtbSubFilterSlotKindCheckboxContent extends GtbSubFilterSlotKind {
  const _GtbSubFilterSlotKindCheckboxContent({
    required this.label,
    required this.description,
  });

  final GtbCheckboxLabel label;
  final Widget description;
}

final class _GtbSubFilterSlotKindContent extends GtbSubFilterSlotKind {
  const _GtbSubFilterSlotKindContent({
    required this.title,
    required this.link,
    this.subtitle,
    this.titleInfo,
  });

  final Widget title;
  final Widget? subtitle;
  final String? titleInfo;
  final GtbLink link;
}

final class _GtbSubFilterSlotKindCustom extends GtbSubFilterSlotKind {
  const _GtbSubFilterSlotKindCustom({
    required this.title,
    required this.child,
    this.subtitle,
    this.titleInfo,
    this.onClearLink,
  });

  final Widget title;
  final Widget? subtitle;
  final String? titleInfo;
  final VoidCallback? onClearLink;
  final Widget child;
}

final class _GtbSubFilterSlotKindFilterTag extends GtbSubFilterSlotKind {
  const _GtbSubFilterSlotKindFilterTag({
    required this.title,
    required this.tags,
    this.subtitle,
    this.titleInfo,
    this.onClearLink,
  });

  final Widget title;
  final Widget? subtitle;
  final String? titleInfo;
  final VoidCallback? onClearLink;
  final List<GtbTagFilter> tags;
}

final class _GtbSubFilterSlotKindPeriod extends GtbSubFilterSlotKind {
  const _GtbSubFilterSlotKindPeriod({
    required this.title,
    required this.periods,
    required this.selectedValue,
    this.subtitle,
    this.titleInfo,
    this.onClearLink,
    this.hasCustomPeriod,
    this.onChanged,
  });

  final Widget title;
  final Widget? subtitle;
  final String? titleInfo;
  final VoidCallback? onClearLink;
  final List<GtbFilterPeriod> periods;
  final GtbFilterPeriod? selectedValue;
  final bool? hasCustomPeriod;
  final ValueChanged<GtbFilterPeriod?>? onChanged;
}

final class _GtbSubFilterSlotKindRadioButton<T> extends GtbSubFilterSlotKind {
  const _GtbSubFilterSlotKindRadioButton({
    required this.title,
    required this.buttons,
    this.subtitle,
    this.titleInfo,
    this.onClearLink,
  });

  final Widget title;
  final Widget? subtitle;
  final String? titleInfo;
  final VoidCallback? onClearLink;
  final List<GtbRadioButtonLabel<T>> buttons;
}

final class _GtbSubFilterSlotKindSearchTag extends GtbSubFilterSlotKind {
  const _GtbSubFilterSlotKindSearchTag({
    required this.input,
    required this.tags,
  });

  final GtbInputTag input;
  final List<GtbTagSearch> tags;
}

final class _GtbSubFilterSlotKindSlider extends GtbSubFilterSlotKind {
  const _GtbSubFilterSlotKindSlider({
    required this.title,
    required this.slider,
    this.subtitle,
    this.titleInfo,
    this.onClearLink,
  });

  final Widget title;
  final Widget? subtitle;
  final String? titleInfo;
  final VoidCallback? onClearLink;
  final GtbSlider slider;
}

class _GtbSubFilterSlotHeader extends StatelessWidget {
  const _GtbSubFilterSlotHeader({
    required this.title,
    this.subtitle,
    this.titleInfo,
    this.onClearLink,
  });

  final Widget title;
  final Widget? subtitle;
  final String? titleInfo;
  final VoidCallback? onClearLink;

  @override
  Widget build(BuildContext context) {
    final theme = GtbThemeProvider.of(context);
    final onColorEmphasisLow = theme.appColorScheme.onColorEmphasisLow;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Row(
                children: [
                  Flexible(
                    child: DefaultTextStyle(
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.typography.titleSmall.copyWith(
                        color: onColorEmphasisLow,
                      ),
                      child: title,
                    ),
                  ),
                  if (titleInfo case final titleInfo?)
                    Padding(
                      padding: const EdgeInsets.only(left: GtbPaddingValue.xxxs),
                      child: GtbTooltip.defaultContent(
                        alignment: GtbTooltipAlignment.start,
                        position: GtbTooltipPosition.top,
                        label: titleInfo,
                        child: GtbIconContainer(
                          size: GtbIconContainerSize.size16,
                          icon: GtbIcons.info,
                          color: onColorEmphasisLow,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            if (onClearLink case final onClearLink?) ...[
              GtbGap.xs,
              GtbLink(
                isUnderline: true,
                size: GtbLinkSize.small,
                label: const Text('Limpar'),
                onPress: onClearLink,
              ),
            ],
          ],
        ),
        if (subtitle case final subtitle?) //
          Padding(
            padding: const EdgeInsets.only(top: GtbPaddingValue.xxxs),
            child: DefaultTextStyle(
              style: theme.typography.bodySmall.copyWith(
                color: theme.appColorScheme.onColorEmphasisLow,
              ),
              child: subtitle,
            ),
          ),
        GtbGap.xxs,
      ],
    );
  }
}

class _GtbSubFilterSlotCheckbox extends StatelessWidget {
  const _GtbSubFilterSlotCheckbox({required this.labels});

  final List<GtbCheckboxLabel> labels;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GtbGap.sm,
        for (final label in labels) ...[
          label,
        ],
      ],
    );
  }
}

class _GtbSubFilterSlotCheckboxContent extends StatelessWidget {
  const _GtbSubFilterSlotCheckboxContent({
    required this.label,
    required this.description,
  });

  final GtbCheckboxLabel label;
  final Widget description;

  @override
  Widget build(BuildContext context) {
    final theme = GtbThemeProvider.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        label,
        GtbGap.xxs,
        DefaultTextStyle(
          style: theme.typography.bodySmall.copyWith(
            color: theme.appColorScheme.onColorEmphasisLow,
          ),
          child: description,
        ),
      ],
    );
  }
}

class _GtbSubFilterSlotContent extends StatelessWidget {
  const _GtbSubFilterSlotContent({required this.link});

  final GtbLink link;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: GtbPaddingValue.xxs),
      child: link,
    );
  }
}

class _GtbSubFilterSlotCustom extends StatelessWidget {
  const _GtbSubFilterSlotCustom({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: GtbPaddingValue.sm),
      child: child,
    );
  }
}

class _GtbSubFilterSlotFilterTag extends StatelessWidget {
  const _GtbSubFilterSlotFilterTag({required this.tags});

  final List<GtbTagFilter> tags;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: GtbPaddingValue.sm),
      child: Wrap(
        spacing: GtbGapValue.xxs,
        runSpacing: GtbGapValue.xxs,
        children: tags,
      ),
    );
  }
}

@immutable
class GtbFilterPeriod {
  const GtbFilterPeriod({
    required this.label,
    required this.startDate,
    required this.endDate,
  });

  final String label;
  final DateTime? startDate;
  final DateTime? endDate;

  GtbCalendarPeriod? toCalendarPeriod() {
    if (startDate case final startDate?) {
      if (endDate case final endDate?) {
        return GtbCalendarPeriod(
          startDate: startDate,
          endDate: endDate,
        );
      }
    }

    return null;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    } else {
      return other is GtbFilterPeriod && //
          other.label == label &&
          other.startDate == startDate &&
          other.endDate == endDate;
    }
  }

  @override
  int get hashCode {
    return Object.hashAll([GtbFilterPeriod, label, startDate, endDate]);
  }
}

class _GtbSubFilterSlotPeriod extends StatefulWidget {
  const _GtbSubFilterSlotPeriod({
    required this.periods,
    required this.selectedValue,
    this.hasCustomPeriod,
    this.onChanged,
  });

  final List<GtbFilterPeriod> periods;
  final GtbFilterPeriod? selectedValue;
  final bool? hasCustomPeriod;
  final ValueChanged<GtbFilterPeriod?>? onChanged;

  @override
  State<_GtbSubFilterSlotPeriod> createState() => _GtbSubFilterSlotPeriodState();
}

final class _GtbSubFilterSlotPeriodState extends State<_GtbSubFilterSlotPeriod> {
  late GtbFilterPeriod _customPeriod;
  final _dateFormat = DateFormat.yMd();
  final _startDateTextController = TextEditingController();
  final _endDateTextController = TextEditingController();
  bool _isCustomPeriodSelected = false;

  @override
  void initState() {
    super.initState();

    _customPeriod = const GtbFilterPeriod(
      label: 'Período personalizado',
      startDate: null,
      endDate: null,
    );
  }

  @override
  void didUpdateWidget(covariant _GtbSubFilterSlotPeriod oldWidget) {
    super.didUpdateWidget(oldWidget);

    _isCustomPeriodSelected = widget.selectedValue == _customPeriod;
  }

  @override
  Widget build(BuildContext context) {
    final hasCustomPeriod = widget.hasCustomPeriod ?? true;
    const hintText = '00/00/0000';

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GtbGap.sm,
        ...widget.periods
            .map<Widget>((period) {
              return GtbRadioButtonLabel<GtbFilterPeriod?>(
                label: period.label,
                value: period,
                selectedValue: widget.selectedValue,
                position: GtbRadioButtonPosition.left,
                onChanged: _updateSelectedPeriod,
              );
            })
            .intersperse(GtbGap.xxs),
        if (hasCustomPeriod) ...[
          GtbGap.xxs,
          GtbRadioButtonLabel<GtbFilterPeriod?>(
            label: _customPeriod.label,
            value: _customPeriod,
            selectedValue: widget.selectedValue,
            position: GtbRadioButtonPosition.left,
            onChanged: _updateSelectedPeriod,
          ),
          AnimatedAlignOpacity.builder(
            alignment: Alignment.topCenter,
            heightFactor: _isCustomPeriodSelected ? 1.0 : 0.0,
            builder: (context) {
              return Padding(
                padding: const EdgeInsets.only(top: GtbPaddingValue.xs),
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () => _openPeriodPicker(context),
                  child: Row(
                    children: [
                      Flexible(
                        child: IgnorePointer(
                          child: GtbTextField(
                            state: GtbTextFieldState.enabled,
                            size: GtbTextFieldSize.small,
                            controller: _startDateTextController,
                            label: const Text('Data inicial'),
                            leading: const GtbIconContainer(icon: GtbIcons.schedule),
                            hintText: hintText,
                          ),
                        ),
                      ),
                      GtbGap.xs,
                      Flexible(
                        child: IgnorePointer(
                          child: GtbTextField(
                            state: GtbTextFieldState.enabled,
                            size: GtbTextFieldSize.small,
                            controller: _endDateTextController,
                            label: const Text('Data final'),
                            leading: const GtbIconContainer(icon: GtbIcons.schedule),
                            hintText: hintText,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ],
    );
  }

  void _updateSelectedPeriod(GtbFilterPeriod? period) {
    setState(() {
      _isCustomPeriodSelected = period == _customPeriod;
    });

    widget.onChanged?.call(period);
  }

  Future<void> _openPeriodPicker(BuildContext context) async {
    final customPeriod = await showGtbPeriodPicker(
      context: context,
      initialSelectedPeriod: _customPeriod.toCalendarPeriod(),
      primaryActionSettingsBuilder: (context, data) {
        return GtbActionSettings(
          text: 'Selecionar',
          onPress: data == null
              ? null //
              : () => Navigator.of(context).pop(data),
        );
      },
      secondaryActionSettingsBuilder: (context, data) {
        return GtbActionSettings(
          text: 'Fechar',
          onPress: Navigator.of(context).pop,
        );
      },
    );

    _customPeriod = GtbFilterPeriod(
      label: _customPeriod.label,
      startDate: customPeriod?.startDate,
      endDate: customPeriod?.endDate,
    );

    _startDateTextController.text = _formatDate(_customPeriod.startDate);
    _endDateTextController.text = _formatDate(_customPeriod.endDate);

    _updateSelectedPeriod(_customPeriod);
  }

  String _formatDate(DateTime? date) {
    if (date == null) {
      return '';
    } else {
      return _dateFormat.format(date);
    }
  }
}

class _GtbSubFilterSlotRadioButton<T> extends StatelessWidget {
  const _GtbSubFilterSlotRadioButton({required this.buttons});

  final List<GtbRadioButtonLabel<T>> buttons;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GtbGap.sm,
        ...buttons,
      ],
    );
  }
}

class _GtbSubFilterSlotSearchTag extends StatelessWidget {
  const _GtbSubFilterSlotSearchTag({
    required this.input,
    required this.tags,
  });

  final GtbInputTag input;
  final List<GtbTagSearch> tags;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        input,
        if (tags.isNotEmpty) ...[
          GtbGap.sm,
          Wrap(
            spacing: GtbGapValue.xxs,
            runSpacing: GtbGapValue.xxs,
            children: tags,
          ),
        ],
      ],
    );
  }
}

class _GtbSubFilterSlotSlider extends StatelessWidget {
  const _GtbSubFilterSlotSlider({required this.slider});

  final GtbSlider slider;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: GtbPaddingValue.sm),
      child: slider,
    );
  }
}
