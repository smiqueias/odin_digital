import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gtb_teatro/design_system/gtb_teatro.dart';

final class GtbModal extends StatelessWidget {
  const GtbModal({
    required this.title,
    super.key,
    this.content,
    this.primaryAction,
    this.secondaryAction,
    this.linkAction,
    this.backgroundColor,
    this.contentPadding = const EdgeInsets.all(GtbPaddingValue.sm),
  }) : assert(
         content != null || primaryAction != null || secondaryAction != null || linkAction != null,
         'You have to provide at least one of the following parameters: content, primaryAction, secondaryAction, linkAction',
       );

  GtbModal.defaultContent({
    required this.title,
    super.key,
    Widget? subtitle,
    Widget? paragraph,
    this.linkAction,
    this.primaryAction,
    this.secondaryAction,
    this.backgroundColor,
  }) : content = (subtitle != null || paragraph != null)
           ? _GtbModalDefaultContent(
               subtitle: subtitle,
               paragraph: paragraph,
             )
           : null,
       contentPadding = const EdgeInsets.all(GtbPaddingValue.sm);

  final Widget title;
  final Widget? content;
  final GtbActionSettings<VoidCallback>? linkAction;
  final GtbActionSettings<VoidCallback>? primaryAction;
  final GtbActionSettings<VoidCallback>? secondaryAction;
  final EdgeInsets contentPadding;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final theme = GtbThemeProvider.of(context);
    final colorScheme = theme.appColorScheme;

    final primaryAction = this.primaryAction;
    final secondaryAction = this.secondaryAction;
    final linkAction = this.linkAction;
    final hasButtonFixed = primaryAction != null || secondaryAction != null || linkAction != null;

    return Material(
      color: backgroundColor ?? colorScheme.neutralBase,
      child: SafeArea(
        bottom: false,
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: GtbPaddingValue.sm,
                    right: GtbPaddingValue.xxl,
                    top: GtbPaddingValue.sm,
                  ),
                  child: DefaultTextStyle(
                    style: theme.typography.titleSmall.copyWith(
                      color: theme.appColorScheme.onColorEmphasisHigh,
                    ),
                    child: title,
                  ),
                ),
                if (content case final content?)
                  Flexible(
                    child: Padding(
                      padding: hasButtonFixed
                          // Discount the GtbBaseButtonFixed top padding
                          ? contentPadding.copyWith(
                              bottom: max(0.0, contentPadding.bottom - GtbGapValue.sm),
                            )
                          : contentPadding,
                      child: content,
                    ),
                  ),
                if (hasButtonFixed)
                  GtbBaseButtonFixed(
                    button: primaryAction == null
                        ? null //
                        : GtbButton.fromActionSettings(
                            actionSettings: primaryAction,
                          ),
                    link: secondaryAction == null
                        ? null //
                        : GtbLink.fromActionSettings(
                            actionSettings: secondaryAction,
                            isUnderline: true,
                          ),
                    externalLink: linkAction == null
                        ? null //
                        : GtbLink.fromActionSettings(
                            actionSettings: linkAction,
                          ),
                    hasDivider: false,
                    semantics: secondaryAction?.semantics ?? const GtbSemanticsData(),
                  )
                else
                  const GtbBottomSafeAreaSpacer(),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(GtbPaddingValue.sm) - const EdgeInsets.all(kIconButtonExtraSpacing),
              child: GtbIconButton(
                icon: const Icon(GtbIcons.close),
                color: theme.appColorScheme.onColorEmphasisHigh,
                onPress: Navigator.of(context).pop,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

final class _GtbModalDefaultContent extends StatelessWidget {
  const _GtbModalDefaultContent({
    required this.subtitle,
    required this.paragraph,
  });

  final Widget? subtitle;
  final Widget? paragraph;

  @override
  Widget build(BuildContext context) {
    final theme = GtbThemeProvider.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (subtitle case final subtitle?)
          DefaultTextStyle(
            style: theme.typography.titleSmall.copyWith(
              color: theme.appColorScheme.onColorEmphasisHigh,
            ),
            child: subtitle,
          ),
        if (subtitle != null && paragraph != null) GtbGap.xxs,
        if (paragraph case final paragraph?)
          DefaultTextStyle(
            style: theme.typography.bodyBase.copyWith(
              color: theme.appColorScheme.onColorEmphasisMedium,
            ),
            child: paragraph,
          ),
      ],
    );
  }
}
