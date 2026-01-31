import 'package:flutter/widgets.dart';
import 'package:gtb_teatro/design_system/color_scheme/color_scheme_provider.dart';
import 'package:gtb_teatro/design_system/components/components.dart';
import 'package:gtb_teatro/design_system/foundation/foundations.dart';
import 'package:gtb_teatro/design_system/models/action_settings.dart';

typedef GtbSubListBadges = GtbBadgesGroup;

enum GtbListImageAlignment {
  top,
  center,
  bottom,
}

class GtbList extends StatelessWidget {
  const GtbList({
    required this.content,
    super.key,
    this.imageKind,
    this.action,
    this.detail,
    this.button,
    this.hasDivider = false,
    this.isFullWidth = false,
    this.alignment = GtbListImageAlignment.top,
    this.onPress,
  });

  final GtbSubListAction? action;
  final GtbListImageAlignment alignment;
  final GtbSubListButton? button;
  final GtbSubListContent content;
  final GtbSubListDetail? detail;
  final bool hasDivider;
  final GtbSubListImageKind? imageKind;
  final bool isFullWidth;
  final VoidCallback? onPress;

  @override
  Widget build(BuildContext context) {
    final image = switch (imageKind) {
      null => null,
      GtbSubListImageKindAvatar(:final avatar) => GtbAvatarTheme(
        data: GtbAvatarTheme.of(context).copyWith(
          hasOutline: true,
          size: GtbAvatarSize.size40,
        ),
        child: avatar,
      ),
      GtbSubListImageKindIcon(:final iconContainer) => GtbIconContainerTheme(
        data: GtbIconContainerTheme.of(context).copyWith(
          size: GtbIconContainerSize.size24,
        ),
        child: iconContainer,
      ),
      GtbSubListImageKindIconCircle(:final iconContainerCircle) => GtbIconContainerTheme(
        data: GtbIconContainerTheme.of(context).copyWith(
          circleSize: GtbIconContainerCircleSize.size40,
        ),
        child: iconContainerCircle,
      ),
      GtbSubListImageKindImage(:final imageContainer) => GtbImageContainerTheme(
        data: GtbImageContainerTheme.of(context).copyWith(
          size: GtbImageContainerSize.size40,
          shape: GtbImageContainerShape.rounded,
        ),
        child: imageContainer,
      ),
      GtbSubListImageKindImageGroup(:final imageGroup) => GtbImageGroupTheme(
        data: GtbImageGroupThemeData(size: GtbImageGroupSize.medium),
        child: imageGroup,
      ),
    };

    final hasAnythingAfterImage = image != null && (content.hasContent || action != null);
    final hasAnythingAfterContent = content.hasContent && action != null;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GtbInkWell.outsideResponse(
          onTap: onPress,
          child: Row(
            crossAxisAlignment: switch (alignment) {
              GtbListImageAlignment.top => CrossAxisAlignment.start,
              GtbListImageAlignment.center => CrossAxisAlignment.center,
              GtbListImageAlignment.bottom => CrossAxisAlignment.end,
            },
            children: [
              if (isFullWidth) GtbGap.sm,
              if (image case final image?) image,
              if (hasAnythingAfterImage) GtbGap.xs,
              Expanded(
                child: Column(
                  children: [
                    content,
                    if (detail case final detail?) detail,
                  ],
                ),
              ),
              if (hasAnythingAfterContent) GtbGap.xs,
              if (action case final action?) action,
              if (isFullWidth) GtbGap.sm,
            ],
          ),
        ),
        if (button case final button?) button,
        if (hasDivider)
          const Padding(
            padding: EdgeInsets.only(top: GtbPaddingValue.xs),
            child: GtbGlobalDivider.sectionThin,
          ),
      ],
    );
  }
}

final class GtbSubListContent extends StatelessWidget {
  const GtbSubListContent({
    super.key,
    this.leftOverline,
    this.leftOverlineIcon,
    this.leftTitle,
    this.leftTitleIcon,
    this.leftSubtitle,
    this.leftParagraph,
    this.rightOverline,
    this.rightOverlineIcon,
    this.rightTitle,
    this.rightTitleIcon,
    this.rightSubtitle,
    this.rightParagraph,
    this.slot,
    this.leftFlex = 1,
    this.rightFlex = 1,
    this.slotFlex = 1,
  });

  final Widget? leftOverline;
  final Widget? leftOverlineIcon;
  final Widget? leftTitle;
  final Widget? leftTitleIcon;
  final Widget? leftSubtitle;
  final Widget? leftParagraph;
  final Widget? rightOverline;
  final Widget? rightOverlineIcon;
  final Widget? rightTitle;
  final Widget? rightTitleIcon;
  final Widget? rightSubtitle;
  final Widget? rightParagraph;
  final Widget? slot;
  final int leftFlex;
  final int rightFlex;
  final int slotFlex;

  bool get hasLeftContent =>
      leftOverline != null || //
      leftOverlineIcon != null ||
      leftTitle != null ||
      leftTitleIcon != null ||
      leftSubtitle != null ||
      leftParagraph != null;

  bool get hasRightContent =>
      rightOverline != null || //
      rightOverlineIcon != null ||
      rightTitle != null ||
      rightTitleIcon != null ||
      rightSubtitle != null ||
      rightParagraph != null;

  bool get hasSlot => slot != null;

  bool get hasContent => hasLeftContent || hasSlot || hasRightContent;

  @override
  Widget build(BuildContext context) {
    final hasAnythingAfterLeftContent = hasLeftContent && (hasSlot || hasRightContent);
    final hasAnythingAfterSlot = hasSlot && hasRightContent;
    final hasNothingBeforeRightContent = !hasLeftContent && !hasSlot;

    if (hasSlot) {
      return _MutableAlignmentSubListContent(
        hasLeftContent: hasLeftContent,
        leftFlex: leftFlex,
        leftOverline: leftOverline,
        leftOverlineIcon: leftOverlineIcon,
        leftTitle: leftTitle,
        leftTitleIcon: leftTitleIcon,
        leftSubtitle: leftSubtitle,
        leftParagraph: leftParagraph,
        hasAnythingAfterLeftContent: hasAnythingAfterLeftContent,
        slot: slot,
        slotFlex: slotFlex,
        hasAnythingAfterSlot: hasAnythingAfterSlot,
        hasNothingBeforeRightContent: hasNothingBeforeRightContent,
        hasRightContent: hasRightContent,
        rightFlex: rightFlex,
        rightOverline: rightOverline,
        rightOverlineIcon: rightOverlineIcon,
        rightTitle: rightTitle,
        rightTitleIcon: rightTitleIcon,
        rightSubtitle: rightSubtitle,
        rightParagraph: rightParagraph,
      );
    } else {
      return _ImmutableAlignmentSubListContent(
        hasLeftContent: hasLeftContent,
        leftFlex: leftFlex,
        leftOverline: leftOverline,
        leftOverlineIcon: leftOverlineIcon,
        leftTitle: leftTitle,
        leftTitleIcon: leftTitleIcon,
        leftSubtitle: leftSubtitle,
        leftParagraph: leftParagraph,
        hasRightContent: hasRightContent,
        rightFlex: rightFlex,
        rightOverline: rightOverline,
        rightOverlineIcon: rightOverlineIcon,
        rightTitle: rightTitle,
        rightTitleIcon: rightTitleIcon,
        rightSubtitle: rightSubtitle,
        rightParagraph: rightParagraph,
      );
    }
  }
}

class _ImmutableAlignmentSubListContent extends StatelessWidget {
  const _ImmutableAlignmentSubListContent({
    required this.hasLeftContent,
    required this.leftFlex,
    required this.leftOverline,
    required this.leftOverlineIcon,
    required this.leftTitle,
    required this.leftTitleIcon,
    required this.leftSubtitle,
    required this.leftParagraph,
    required this.hasRightContent,
    required this.rightFlex,
    required this.rightOverline,
    required this.rightOverlineIcon,
    required this.rightTitle,
    required this.rightTitleIcon,
    required this.rightSubtitle,
    required this.rightParagraph,
  });

  final bool hasLeftContent;
  final int leftFlex;
  final Widget? leftOverline;
  final Widget? leftOverlineIcon;
  final Widget? leftTitle;
  final Widget? leftTitleIcon;
  final Widget? leftSubtitle;
  final Widget? leftParagraph;
  final bool hasRightContent;
  final int rightFlex;
  final Widget? rightOverline;
  final Widget? rightOverlineIcon;
  final Widget? rightTitle;
  final Widget? rightTitleIcon;
  final Widget? rightSubtitle;
  final Widget? rightParagraph;

  bool get hasOverline {
    return leftOverline != null || //
        leftOverlineIcon != null ||
        rightOverline != null ||
        rightOverlineIcon != null;
  }

  bool get hasTitle {
    return leftTitle != null || //
        leftTitleIcon != null ||
        rightTitle != null ||
        rightTitleIcon != null;
  }

  bool get hasSubtitle => leftSubtitle != null || rightSubtitle != null;

  bool get hasParagraph => leftParagraph != null || rightParagraph != null;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (hasOverline)
          _ImmutableAlignmentSubListItemRow(
            hasLeftContent: hasLeftContent,
            leftFlex: leftFlex,
            leftSubListContent: _OverlineContent(
              textDirection: TextDirection.ltr,
              overline: leftOverline,
              overlineIcon: leftOverlineIcon,
            ),
            hasRightContent: hasRightContent,
            rightFlex: rightFlex,
            rightSubListContent: _OverlineContent(
              textDirection: TextDirection.rtl,
              overline: rightOverline,
              overlineIcon: rightOverlineIcon,
            ),
          ),
        if (hasTitle)
          _ImmutableAlignmentSubListItemRow(
            hasLeftContent: hasLeftContent,
            leftFlex: leftFlex,
            leftSubListContent: _TitleContent(
              textDirection: TextDirection.ltr,
              title: leftTitle,
              titleIcon: leftTitleIcon,
            ),
            hasRightContent: hasRightContent,
            rightFlex: rightFlex,
            rightSubListContent: _TitleContent(
              textDirection: TextDirection.rtl,
              title: rightTitle,
              titleIcon: rightTitleIcon,
            ),
          ),
        if (hasSubtitle)
          _ImmutableAlignmentSubListItemRow(
            hasLeftContent: hasLeftContent,
            leftFlex: leftFlex,
            leftSubListContent: leftSubtitle != null
                ? _SubtitleContent(
                    textDirection: TextDirection.ltr,
                    subtitle: leftSubtitle!,
                  )
                : null,
            hasRightContent: hasRightContent,
            rightFlex: rightFlex,
            rightSubListContent: rightSubtitle != null
                ? _SubtitleContent(
                    textDirection: TextDirection.rtl,
                    subtitle: rightSubtitle!,
                  )
                : null,
          ),
        if (hasParagraph) GtbGap.xxxs,
        if (hasParagraph)
          _ImmutableAlignmentSubListItemRow(
            hasLeftContent: hasLeftContent,
            leftFlex: leftFlex,
            leftSubListContent: leftParagraph != null
                ? _ParagraphContent(
                    textDirection: TextDirection.ltr,
                    paragraph: leftParagraph!,
                  )
                : null,
            hasRightContent: hasRightContent,
            rightFlex: rightFlex,
            rightSubListContent: rightParagraph != null
                ? _ParagraphContent(
                    textDirection: TextDirection.rtl,
                    paragraph: rightParagraph!,
                  )
                : null,
          ),
      ],
    );
  }
}

class _ImmutableAlignmentSubListItemRow extends StatelessWidget {
  const _ImmutableAlignmentSubListItemRow({
    required this.rightFlex,
    required this.leftFlex,
    required this.leftSubListContent,
    required this.rightSubListContent,
    required this.hasLeftContent,
    required this.hasRightContent,
  });

  final Widget? leftSubListContent;
  final Widget? rightSubListContent;
  final bool hasLeftContent;
  final bool hasRightContent;
  final int rightFlex;
  final int leftFlex;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      spacing: GtbPaddingValue.xxs,
      children: [
        if (hasLeftContent)
          Flexible(
            flex: leftFlex,
            child: leftSubListContent ?? const SizedBox.shrink(),
          ),
        if (hasRightContent)
          Flexible(
            flex: rightFlex,
            child: rightSubListContent ?? const SizedBox.shrink(),
          ),
      ],
    );
  }
}

final class _MutableAlignmentSubListContent extends StatelessWidget {
  const _MutableAlignmentSubListContent({
    required this.hasLeftContent,
    required this.leftFlex,
    required this.leftOverline,
    required this.leftOverlineIcon,
    required this.leftTitle,
    required this.leftTitleIcon,
    required this.leftSubtitle,
    required this.leftParagraph,
    required this.hasAnythingAfterLeftContent,
    required this.slot,
    required this.slotFlex,
    required this.hasAnythingAfterSlot,
    required this.hasNothingBeforeRightContent,
    required this.hasRightContent,
    required this.rightFlex,
    required this.rightOverline,
    required this.rightOverlineIcon,
    required this.rightTitle,
    required this.rightTitleIcon,
    required this.rightSubtitle,
    required this.rightParagraph,
  });

  final bool hasLeftContent;
  final int leftFlex;
  final Widget? leftOverline;
  final Widget? leftOverlineIcon;
  final Widget? leftTitle;
  final Widget? leftTitleIcon;
  final Widget? leftSubtitle;
  final Widget? leftParagraph;
  final bool hasAnythingAfterLeftContent;
  final Widget? slot;
  final int slotFlex;
  final bool hasAnythingAfterSlot;
  final bool hasNothingBeforeRightContent;
  final bool hasRightContent;
  final int rightFlex;
  final Widget? rightOverline;
  final Widget? rightOverlineIcon;
  final Widget? rightTitle;
  final Widget? rightTitleIcon;
  final Widget? rightSubtitle;
  final Widget? rightParagraph;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (hasLeftContent)
          Flexible(
            flex: leftFlex,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (leftOverline != null || leftOverlineIcon != null)
                  _OverlineContent(
                    textDirection: TextDirection.ltr,
                    overline: leftOverline,
                    overlineIcon: leftOverlineIcon,
                  ),
                if (leftTitle != null || leftTitleIcon != null)
                  _TitleContent(
                    textDirection: TextDirection.ltr,
                    title: leftTitle,
                    titleIcon: leftTitleIcon,
                  ),
                if (leftSubtitle case final subtitle?)
                  _SubtitleContent(
                    textDirection: TextDirection.ltr,
                    subtitle: subtitle,
                  ),
                if (leftParagraph case final paragraph?)
                  _ParagraphContent(
                    textDirection: TextDirection.ltr,
                    paragraph: paragraph,
                  ),
              ],
            ),
          ),
        if (hasAnythingAfterLeftContent) GtbGap.xxs,
        if (slot case final slot?)
          Flexible(
            flex: slotFlex,
            child: slot,
          ),
        if (hasAnythingAfterSlot) GtbGap.xxs,
        if (hasNothingBeforeRightContent) const Spacer(),
        if (hasRightContent)
          Flexible(
            flex: rightFlex,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                if (rightOverline != null || rightOverlineIcon != null)
                  _OverlineContent(
                    textDirection: TextDirection.rtl,
                    overline: rightOverline,
                    overlineIcon: rightOverlineIcon,
                  ),
                if (rightTitle != null || rightTitleIcon != null)
                  _TitleContent(
                    textDirection: TextDirection.rtl,
                    title: rightTitle,
                    titleIcon: rightTitleIcon,
                  ),
                if (rightSubtitle case final subtitle?)
                  _SubtitleContent(
                    textDirection: TextDirection.rtl,
                    subtitle: subtitle,
                  ),
                if (rightParagraph case final paragraph?)
                  _ParagraphContent(
                    textDirection: TextDirection.rtl,
                    paragraph: paragraph,
                  ),
              ],
            ),
          ),
      ],
    );
  }
}

final class _ParagraphContent extends StatelessWidget {
  const _ParagraphContent({
    required this.textDirection,
    required this.paragraph,
  });

  final TextDirection textDirection;
  final Widget paragraph;

  @override
  Widget build(BuildContext context) {
    final theme = GtbThemeProvider.of(context);
    final appColorScheme = theme.appColorScheme;
    final typography = theme.typography;

    return DefaultTextStyle(
      textAlign: switch (textDirection) {
        TextDirection.rtl => TextAlign.right,
        TextDirection.ltr => TextAlign.left,
      },
      style: typography.bodySmall.copyWith(
        color: appColorScheme.onColorEmphasisMedium,
      ),
      child: paragraph,
    );
  }
}

final class _SubtitleContent extends StatelessWidget {
  const _SubtitleContent({
    required this.textDirection,
    required this.subtitle,
  });

  final TextDirection textDirection;
  final Widget subtitle;

  @override
  Widget build(BuildContext context) {
    final theme = GtbThemeProvider.of(context);
    final appColorScheme = theme.appColorScheme;
    final typography = theme.typography;

    return DefaultTextStyle(
      textAlign: switch (textDirection) {
        TextDirection.rtl => TextAlign.right,
        TextDirection.ltr => TextAlign.left,
      },
      style: typography.bodySmall.copyWith(
        color: appColorScheme.onColorEmphasisMedium,
      ),
      child: subtitle,
    );
  }
}

final class _TitleContent extends StatelessWidget {
  const _TitleContent({
    required this.textDirection,
    required this.title,
    required this.titleIcon,
  });

  final TextDirection textDirection;
  final Widget? title;
  final Widget? titleIcon;

  @override
  Widget build(BuildContext context) {
    final theme = GtbThemeProvider.of(context);
    final colorScheme = theme.appColorScheme;
    final typography = theme.typography;

    return Row(
      mainAxisSize: MainAxisSize.min,
      textDirection: textDirection,
      spacing: GtbGapValue.xxxs,
      children: [
        if (title case final title?)
          Flexible(
            child: DefaultTextStyle(
              style: typography.bodyBase.copyWith(
                color: colorScheme.onColorEmphasisHigh,
              ),
              textAlign: switch (textDirection) {
                TextDirection.rtl => TextAlign.right,
                TextDirection.ltr => TextAlign.left,
              },
              textWidthBasis: TextWidthBasis.longestLine,
              child: title,
            ),
          ),
        if (titleIcon case final titleIcon?)
          ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.textScalerOf(context).scale(typography.bodyBase.verticalSpacing),
            ),
            child: GtbIconContainerTheme(
              data: GtbIconContainerTheme.of(context).copyWith(
                size: GtbIconContainerSize.size16,
                foregroundColor: colorScheme.onColorEmphasisHigh,
              ),
              child: titleIcon,
            ),
          ),
      ],
    );
  }
}

final class _OverlineContent extends StatelessWidget {
  const _OverlineContent({
    required this.textDirection,
    required this.overline,
    required this.overlineIcon,
  });

  final TextDirection textDirection;
  final Widget? overline;
  final Widget? overlineIcon;

  @override
  Widget build(BuildContext context) {
    final theme = GtbThemeProvider.of(context);
    final appColorScheme = theme.appColorScheme;
    final typography = theme.typography;

    return Row(
      mainAxisSize: MainAxisSize.min,
      textDirection: textDirection,
      spacing: GtbGapValue.xxxs,
      children: [
        if (overline case final overline?)
          Flexible(
            child: DefaultTextStyle(
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: typography.bodySmall.copyWith(
                color: appColorScheme.onColorEmphasisMedium,
              ),
              textAlign: switch (textDirection) {
                TextDirection.rtl => TextAlign.right,
                TextDirection.ltr => TextAlign.left,
              },
              textWidthBasis: TextWidthBasis.longestLine,
              child: overline,
            ),
          ),
        if (overlineIcon case final overlineIcon?)
          ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.textScalerOf(context).scale(typography.bodySmall.verticalSpacing),
            ),
            child: GtbIconContainerTheme(
              data: GtbIconContainerTheme.of(context).copyWith(
                size: GtbIconContainerSize.size16,
                foregroundColor: appColorScheme.onColorEmphasisMedium,
              ),
              child: overlineIcon,
            ),
          ),
      ],
    );
  }
}

final class GtbSubListDetail extends StatelessWidget {
  const GtbSubListDetail({
    super.key,
    this.leftBadges,
    this.rightBadges,
    this.leftInline,
    this.rightInline,
    this.leftLinkSettings,
    this.rightLinkSettings,
    this.leftButtonSettings,
    this.rightButtonSettings,
    this.leftSecondButtonSettings,
    this.rightSecondButtonSettings,
    this.leftFlex = 1,
    this.rightFlex = 1,
  });

  final GtbSubListBadges? leftBadges;
  final GtbSubListBadges? rightBadges;
  final GtbActionSettings<VoidCallback>? leftLinkSettings;
  final GtbActionSettings<VoidCallback>? rightLinkSettings;
  final GtbNotificationInline? leftInline;
  final GtbNotificationInline? rightInline;
  final GtbActionSettings<VoidCallback>? leftButtonSettings;
  final GtbActionSettings<VoidCallback>? rightButtonSettings;
  final GtbActionSettings<VoidCallback>? leftSecondButtonSettings;
  final GtbActionSettings<VoidCallback>? rightSecondButtonSettings;
  final int leftFlex;
  final int rightFlex;

  bool get hasLeftDetail {
    final leftBadges = this.leftBadges;

    return leftBadges != null && leftBadges.hasContent || //
        leftInline != null ||
        leftLinkSettings != null ||
        leftButtonSettings != null ||
        leftSecondButtonSettings != null;
  }

  bool get hasRightDetail {
    final rightBadges = this.rightBadges;

    return rightBadges != null && rightBadges.hasContent || //
        rightInline != null ||
        rightLinkSettings != null ||
        rightButtonSettings != null ||
        rightSecondButtonSettings != null;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: GtbGapValue.xxs,
      children: [
        if (hasLeftDetail)
          Expanded(
            flex: leftFlex,
            child: _GtbSubListDetail(
              badges: leftBadges,
              inline: leftInline,
              link: leftLinkSettings,
              buttonSettings: leftButtonSettings,
              secondButtonSettings: leftSecondButtonSettings,
            ),
          ),
        if (hasRightDetail)
          Expanded(
            flex: rightFlex,
            child: _GtbSubListDetail(
              badges: rightBadges,
              inline: rightInline,
              link: rightLinkSettings,
              buttonSettings: rightButtonSettings,
              secondButtonSettings: rightSecondButtonSettings,
              crossAxisAlignment: CrossAxisAlignment.end,
            ),
          ),
      ],
    );
  }
}

class _GtbSubListDetail extends StatelessWidget {
  const _GtbSubListDetail({
    this.badges,
    this.link,
    this.inline,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.buttonSettings,
    this.secondButtonSettings,
  });

  final GtbSubListBadges? badges;
  final GtbActionSettings<VoidCallback>? link;
  final GtbNotificationInline? inline;
  final CrossAxisAlignment crossAxisAlignment;
  final GtbActionSettings<VoidCallback>? buttonSettings;
  final GtbActionSettings<VoidCallback>? secondButtonSettings;

  bool get hasButton => buttonSettings != null || secondButtonSettings != null;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: crossAxisAlignment,
      children: [
        if (badges case final badges? when badges.hasContent) ...[
          GtbGap.xxs,
          badges,
        ],
        if (link case final linkSettings?)
          Padding(
            padding: const EdgeInsets.only(top: GtbPaddingValue.xxs),
            child: GtbLink.fromActionSettings(
              actionSettings: linkSettings,
              isUnderline: true,
              size: GtbLinkSize.small,
            ),
          ),
        if (inline case final inline?)
          Padding(
            padding: const EdgeInsets.only(top: GtbPaddingValue.xxs),
            child: inline,
          ),
        if (hasButton)
          Padding(
            padding: const EdgeInsets.only(top: GtbPaddingValue.xxs),
            child: Row(
              crossAxisAlignment: crossAxisAlignment,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (buttonSettings case final buttonSettings?)
                  Flexible(
                    child: GtbButton.fromActionSettings(
                      actionSettings: buttonSettings,
                      kind: GtbButtonKind.primary,
                      size: GtbButtonSize.compact,
                    ),
                  ),
                if (secondButtonSettings case final secondButtonSettings?) ...[
                  if (buttonSettings != null) GtbGap.xxs,
                  Flexible(
                    child: GtbButton.fromActionSettings(
                      actionSettings: secondButtonSettings,
                      kind: GtbButtonKind.line,
                      size: GtbButtonSize.compact,
                    ),
                  ),
                ],
              ],
            ),
          ),
      ],
    );
  }
}

enum GtbSubListButtonKind { primary, inline, link }

final class GtbSubListButton extends StatelessWidget {
  const GtbSubListButton({
    required this.actionSettings,
    super.key,
    this.kind = GtbSubListButtonKind.primary,
  });

  final GtbSubListButtonKind kind;
  final GtbActionSettings<VoidCallback> actionSettings;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: GtbPaddingValue.sm),
      child: switch (kind) {
        GtbSubListButtonKind.primary => GtbButton.fromActionSettings(
          actionSettings: actionSettings,
          size: GtbButtonSize.compact,
        ),
        GtbSubListButtonKind.inline => GtbButtonInline.fromActionSettings(
          actionSettings: actionSettings,
          isSelected: false,
        ),
        GtbSubListButtonKind.link => GtbLink.fromActionSettings(
          actionSettings: actionSettings.copyWith(rightIcon: actionSettings.rightIcon ?? GtbIcons.chevronRight),
          size: GtbLinkSize.large,
        ),
      },
    );
  }
}

sealed class GtbSubListImageKind {
  const GtbSubListImageKind();

  const factory GtbSubListImageKind.avatar({required GtbAvatarWidget avatar}) = GtbSubListImageKindAvatar;

  const factory GtbSubListImageKind.icon({required GtbIconContainer iconContainer}) = GtbSubListImageKindIcon;

  const factory GtbSubListImageKind.iconCircle({
    required GtbIconContainerCircle iconContainerCircle,
  }) = GtbSubListImageKindIconCircle;

  const factory GtbSubListImageKind.image({required GtbImageContainer imageContainer}) = GtbSubListImageKindImage;

  const factory GtbSubListImageKind.imageGroup({required GtbImageGroup imageGroup}) = GtbSubListImageKindImageGroup;
}

final class GtbSubListImageKindAvatar extends GtbSubListImageKind {
  const GtbSubListImageKindAvatar({required this.avatar});

  final GtbAvatarWidget avatar;
}

final class GtbSubListImageKindIcon extends GtbSubListImageKind {
  const GtbSubListImageKindIcon({required this.iconContainer});

  final GtbIconContainer iconContainer;
}

final class GtbSubListImageKindIconCircle extends GtbSubListImageKind {
  const GtbSubListImageKindIconCircle({required this.iconContainerCircle});

  final GtbIconContainerCircle iconContainerCircle;
}

final class GtbSubListImageKindImage extends GtbSubListImageKind {
  const GtbSubListImageKindImage({required this.imageContainer});

  final GtbImageContainer imageContainer;
}

final class GtbSubListImageKindImageGroup extends GtbSubListImageKind {
  const GtbSubListImageKindImageGroup({required this.imageGroup});

  final GtbImageGroup imageGroup;
}

sealed class GtbSubListActionKind {
  const GtbSubListActionKind();

  factory GtbSubListActionKind.icon({
    GtbIconContainer rightIconContainer = const GtbIconContainer(icon: GtbIcons.chevronRight),
    GtbIconContainer? leftIconContainer,
    VoidCallback? onPress,
  }) {
    return GtbSubListActionKindIcon(
      rightIconContainer: rightIconContainer,
      leftIconContainer: leftIconContainer,
      onPress: onPress,
    );
  }

  const factory GtbSubListActionKind.link({
    required GtbLink link,
  }) = GtbSubListActionKindLink;

  const factory GtbSubListActionKind.button({
    required GtbButton button,
  }) = GtbSubListActionKindButton;

  const factory GtbSubListActionKind.checkbox({
    required GtbCheckbox checkbox,
  }) = GtbSubListActionKindCheckbox;

  const factory GtbSubListActionKind.switcher({
    required GtbSwitcher switcher,
  }) = GtbSubListActionKindSwitcher;

  const factory GtbSubListActionKind.radioButton({
    required GtbRadioButton<Object?> radioButton,
  }) = GtbSubListActionKindRadioButton;
}

final class GtbSubListActionKindIcon extends GtbSubListActionKind {
  const GtbSubListActionKindIcon({
    required this.rightIconContainer,
    this.leftIconContainer,
    this.onPress,
  });

  final GtbIconContainer? leftIconContainer;
  final GtbIconContainer rightIconContainer;
  final VoidCallback? onPress;
}

final class GtbSubListActionKindLink extends GtbSubListActionKind {
  const GtbSubListActionKindLink({required this.link});

  final GtbLink link;
}

final class GtbSubListActionKindButton extends GtbSubListActionKind {
  const GtbSubListActionKindButton({required this.button});

  final GtbButton button;
}

final class GtbSubListActionKindCheckbox extends GtbSubListActionKind {
  const GtbSubListActionKindCheckbox({required this.checkbox});

  final GtbCheckbox checkbox;
}

final class GtbSubListActionKindSwitcher extends GtbSubListActionKind {
  const GtbSubListActionKindSwitcher({required this.switcher});

  final GtbSwitcher switcher;
}

final class GtbSubListActionKindRadioButton extends GtbSubListActionKind {
  const GtbSubListActionKindRadioButton({required this.radioButton});

  final GtbRadioButton<Object?> radioButton;
}

final class GtbSubListAction extends StatelessWidget {
  const GtbSubListAction({
    required this.kind,
    super.key,
  });

  final GtbSubListActionKind kind;

  @override
  Widget build(BuildContext context) {
    return switch (kind) {
      GtbSubListActionKindIcon(
        leftIconContainer: final leftIconContainer,
        rightIconContainer: final rightIconContainer,
        :final onPress,
      ) =>
        GtbIconContainerTheme(
          data: GtbIconContainerTheme.of(context).copyWith(size: GtbIconContainerSize.size24),
          child: GtbInkWell.outsideResponse(
            onTap: onPress,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (leftIconContainer case final leftIcon?) leftIcon,
                rightIconContainer,
              ],
            ),
          ),
        ),
      GtbSubListActionKindLink(:final link) => link,
      GtbSubListActionKindButton(:final button) => button,
      GtbSubListActionKindCheckbox(:final checkbox) => checkbox,
      GtbSubListActionKindRadioButton(:final radioButton) => radioButton,
      GtbSubListActionKindSwitcher(:final switcher) => Transform.translate(
        offset: const Offset(kSwitcherHorizontalExtraSpacing, 0.0),
        child: switcher,
      ),
    };
  }
}

enum GtbListContentSize {
  compact,
  normal,
}

final class GtbListContent extends StatelessWidget {
  GtbListContent.twoColumns({
    required Widget leftTitle,
    required Widget rightTitle,
    super.key,
    GtbListContentSize size = GtbListContentSize.normal,
    Widget? leftSubtitle,
    Widget? rightSubtitle,
    bool hasDivider = false,
    bool isFullWidth = false,
    int leftFlex = 1,
    int rightFlex = 1,
    GtbInformativeIcon? informativeIcon,
    GtbIconContainer? rightIcon,
    VoidCallback? onPress,
  }) : child = _GtbListContentTwoColumns(
         size: size,
         leftTitle: leftTitle,
         leftSubtitle: leftSubtitle,
         rightTitle: rightTitle,
         rightSubtitle: rightSubtitle,
         hasDivider: hasDivider,
         isFullWidth: isFullWidth,
         leftFlex: leftFlex,
         rightFlex: rightFlex,
         informativeIcon: informativeIcon,
         rightIcon: rightIcon,
         onPress: onPress,
       );

  GtbListContent.copyList({
    required GtbSubListContentItem leftContentItem,
    required GtbSubListContentItem rightContentItem,
    super.key,
    int leftFlex = 1,
    int rightFlex = 1,
    VoidCallback? onPress,
  }) : child = _GtbListContentCopyList(
         leftContentItem: leftContentItem,
         rightContentItem: rightContentItem,
         leftFlex: leftFlex,
         rightFlex: rightFlex,
         onPress: onPress,
       );

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return child;
  }
}

final class _GtbListContentTwoColumns extends StatelessWidget {
  const _GtbListContentTwoColumns({
    required this.leftTitle,
    required this.rightTitle,
    this.size = GtbListContentSize.normal,
    this.leftSubtitle,
    this.rightSubtitle,
    this.hasDivider = false,
    this.isFullWidth = false,
    this.leftFlex = 1,
    this.rightFlex = 1,
    this.informativeIcon,
    this.rightIcon,
    this.onPress,
  });

  final GtbListContentSize size;
  final Widget leftTitle;
  final Widget rightTitle;
  final Widget? leftSubtitle;
  final Widget? rightSubtitle;
  final bool hasDivider;
  final bool isFullWidth;
  final int leftFlex;
  final int rightFlex;
  final GtbInformativeIcon? informativeIcon;
  final GtbIconContainer? rightIcon;
  final VoidCallback? onPress;

  @override
  Widget build(BuildContext context) {
    final theme = GtbThemeProvider.of(context);
    final appColorScheme = theme.appColorScheme;
    final typography = theme.typography;

    final titleTypography = switch (size) {
      GtbListContentSize.compact => typography.bodySmall,
      GtbListContentSize.normal => typography.bodyBase,
    };

    final subtitleTypography = switch (size) {
      GtbListContentSize.compact => typography.captionBase,
      GtbListContentSize.normal => typography.bodySmall,
    };

    return Padding(
      padding: isFullWidth
          ? const EdgeInsets.symmetric(horizontal: GtbPaddingValue.sm) //
          : EdgeInsets.zero,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GtbInkWell.outsideResponse(
            onTap: onPress,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: GtbGapValue.xs,
                  children: [
                    Flexible(
                      flex: leftFlex,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        spacing: GtbGapValue.xxxs,
                        children: [
                          Flexible(
                            child: DefaultTextStyle(
                              style: titleTypography.copyWith(color: appColorScheme.onColorEmphasisMedium),
                              textWidthBasis: TextWidthBasis.longestLine,
                              child: leftTitle,
                            ),
                          ),
                          if (informativeIcon case final informativeIcon?) //
                            GtbIconContainerTheme(
                              data: GtbIconContainerTheme.of(context).copyWith(
                                foregroundColor: appColorScheme.onColorEmphasisMedium,
                              ),
                              child: informativeIcon,
                            ),
                        ],
                      ),
                    ),
                    Flexible(
                      flex: rightFlex,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Flexible(
                            child: DefaultTextStyle(
                              style: titleTypography.copyWith(color: appColorScheme.onColorEmphasisHigh),
                              textAlign: TextAlign.right,
                              child: rightTitle,
                            ),
                          ),
                          if (rightIcon case final rightIcon?) ...[
                            GtbGap.xxxs,
                            GtbIconContainerTheme(
                              data: GtbIconContainerTheme.of(context).copyWith(
                                foregroundColor: appColorScheme.onColorEmphasisMedium,
                                size: GtbIconContainerSize.size16,
                              ),
                              child: rightIcon,
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: leftSubtitle == null
                      ? (MainAxisAlignment.end) //
                      : MainAxisAlignment.spaceBetween,
                  spacing: GtbGapValue.xxs,
                  children: [
                    if (leftSubtitle case final leftSubtitle?)
                      Flexible(
                        flex: leftFlex,
                        child: DefaultTextStyle(
                          style: subtitleTypography.copyWith(color: appColorScheme.onColorEmphasisMedium),
                          child: leftSubtitle,
                        ),
                      ),
                    if (rightSubtitle case final rightSubtitle?)
                      Flexible(
                        flex: rightFlex,
                        child: DefaultTextStyle(
                          style: subtitleTypography.copyWith(color: appColorScheme.onColorEmphasisMedium),
                          textAlign: TextAlign.right,
                          child: rightSubtitle,
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
          if (hasDivider) ...[
            switch (size) {
              GtbListContentSize.compact => GtbGap.xxs,
              GtbListContentSize.normal => GtbGap.xs,
            },
            GtbGlobalDivider.sectionThin,
          ],
        ],
      ),
    );
  }
}

final class _GtbListContentCopyList extends StatelessWidget {
  const _GtbListContentCopyList({
    required this.leftContentItem,
    required this.rightContentItem,
    this.leftFlex = 1,
    this.rightFlex = 1,
    this.onPress,
  });

  final GtbSubListContentItem leftContentItem;
  final GtbSubListContentItem rightContentItem;
  final int leftFlex;
  final int rightFlex;
  final VoidCallback? onPress;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GtbGap.xxs,
        GtbInkWell.outsideResponse(
          onTap: onPress,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                flex: leftFlex,
                child: leftContentItem,
              ),
              GtbGap.xs,
              Flexible(
                flex: rightFlex,
                child: rightContentItem,
              ),
            ],
          ),
        ),
        GtbGap.xxs,
        GtbGlobalDivider.sectionThin,
      ],
    );
  }
}

final class GtbTimelineList extends StatelessWidget {
  const GtbTimelineList({
    required this.imageKind,
    required this.value,
    super.key,
    this.label,
    this.transactionDescription,
    this.badge,
    this.category,
    this.inlineButton1,
    this.inlineButton2,
    this.notificationInline,
    this.notificationButtonActionSettings,
    this.isFullWidth = false,
    this.onPress,
  });

  final GtbSubTimelineListImageKind imageKind;
  final Widget? label;
  final Widget value;
  final Widget? transactionDescription;
  final GtbBadgeWidget? badge;
  final Widget? category;
  final GtbButtonInline? inlineButton1;
  final GtbButtonInline? inlineButton2;
  final GtbNotificationInline? notificationInline;
  final GtbActionSettings<VoidCallback>? notificationButtonActionSettings;
  final bool isFullWidth;
  final VoidCallback? onPress;

  @override
  Widget build(BuildContext context) {
    final theme = GtbThemeProvider.of(context);
    final appColorScheme = theme.appColorScheme;
    final typography = theme.typography;

    final image = switch (imageKind) {
      GtbSubTimelineListImageKindAvatar(:final avatar) => GtbAvatarTheme(
        data: GtbAvatarTheme.of(context).copyWith(
          hasOutline: true,
          size: GtbAvatarSize.size32,
        ),
        child: avatar,
      ),
      GtbSubTimelineListImageKindIconCircle(:final iconContainerCircle) => GtbIconContainerTheme(
        data: GtbIconContainerTheme.of(context).copyWith(
          circleSize: GtbIconContainerCircleSize.size32,
        ),
        child: iconContainerCircle,
      ),
      GtbSubTimelineListImageKindImage(:final imageContainer) => GtbImageContainerTheme(
        data: GtbImageContainerTheme.of(context).copyWith(
          size: GtbImageContainerSize.size32,
          shape: GtbImageContainerShape.rounded,
        ),
        child: imageContainer,
      ),
      GtbSubTimelineListImageKindImageGroup(:final imageGroup) => GtbImageGroupTheme(
        data: GtbImageGroupThemeData(size: GtbImageGroupSize.small),
        child: imageGroup,
      ),
    };

    final hasValuePadding =
        label == null && //
        transactionDescription == null &&
        badge == null &&
        category == null;

    final hasInlineButtons = inlineButton1 != null || inlineButton2 != null;

    final inlineButtonsTopPadding =
        GtbGapValue.xs - //
        (hasValuePadding ? GtbGapValue.xxxs : 0.0);
    final notificationInlineTopPadding =
        GtbGapValue.sm - //
        (hasValuePadding && !hasInlineButtons ? GtbGapValue.xxxs : 0.0);
    final notificationButtonTopPadding = (notificationInline == null ? GtbGapValue.sm : GtbGapValue.xs) - (hasValuePadding && !hasInlineButtons && notificationInline == null ? GtbGapValue.xxxs : 0.0);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GtbInkWell.outsideResponse(
          horizontalSplashOverflow: GtbGapValue.sm,
          onTap: onPress,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (isFullWidth) GtbGap.sm,
              image,
              GtbGap.xs,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (label case final label?)
                      Padding(
                        padding: const EdgeInsets.only(bottom: GtbPaddingValue.xxxs),
                        child: DefaultTextStyle(
                          style: typography.bodySmall.copyWith(color: appColorScheme.onColorEmphasisMedium),
                          child: label,
                        ),
                      ),
                    DefaultTextStyle(
                      style: typography.bodyBase.copyWith(color: appColorScheme.onColorEmphasisHigh),
                      child: hasValuePadding
                          ? ConstrainedBox(
                              constraints: const BoxConstraints(minHeight: 32.0),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: value,
                              ),
                            )
                          : value,
                    ),
                    if (transactionDescription case final transactionDescription?)
                      Padding(
                        padding: const EdgeInsets.only(top: GtbPaddingValue.xxxs),
                        child: DefaultTextStyle(
                          style: typography.captionBase.copyWith(color: appColorScheme.onColorEmphasisMedium),
                          child: transactionDescription,
                        ),
                      ),
                    if (badge case final badge?)
                      Padding(
                        padding: const EdgeInsets.only(top: GtbPaddingValue.xxs),
                        child: badge,
                      ),
                    if (category case final category?)
                      Padding(
                        padding: const EdgeInsets.only(top: GtbPaddingValue.xxxs),
                        child: DefaultTextStyle(
                          style: typography.captionBase.copyWith(color: appColorScheme.onColorEmphasisLow),
                          child: category,
                        ),
                      ),
                    if (hasInlineButtons)
                      Padding(
                        padding: EdgeInsets.only(top: inlineButtonsTopPadding),
                        child: Row(
                          children: [
                            if (inlineButton1 case final inlineButton1?) //
                              inlineButton1,
                            if (inlineButton1 != null && inlineButton2 != null) //
                              GtbGap.xs,
                            if (inlineButton2 case final inlineButton2?) //
                              inlineButton2,
                          ],
                        ),
                      ),
                    if (notificationInline case final notificationInline?) //
                      Padding(
                        padding: EdgeInsets.only(top: notificationInlineTopPadding),
                        child: notificationInline,
                      ),
                    if (notificationButtonActionSettings case final notificationButtonActionSettings?) //
                      Padding(
                        padding: EdgeInsets.only(top: notificationButtonTopPadding),
                        child: GtbButton.fromActionSettings(
                          actionSettings: notificationButtonActionSettings,
                          kind: GtbButtonKind.line,
                          size: GtbButtonSize.compact,
                        ),
                      ),
                  ],
                ),
              ),
              if (isFullWidth) GtbGap.sm,
            ],
          ),
        ),
      ],
    );
  }
}

sealed class GtbSubTimelineListImageKind {
  const GtbSubTimelineListImageKind();

  const factory GtbSubTimelineListImageKind.avatar({required GtbAvatarWidget avatar}) = GtbSubTimelineListImageKindAvatar;

  const factory GtbSubTimelineListImageKind.iconCircle({required GtbIconContainerCircle iconContainerCircle}) = GtbSubTimelineListImageKindIconCircle;

  const factory GtbSubTimelineListImageKind.image({required GtbImageContainer imageContainer}) = GtbSubTimelineListImageKindImage;

  const factory GtbSubTimelineListImageKind.imageGroup({required GtbImageGroup imageGroup}) = GtbSubTimelineListImageKindImageGroup;
}

final class GtbSubTimelineListImageKindAvatar extends GtbSubTimelineListImageKind {
  const GtbSubTimelineListImageKindAvatar({required this.avatar});

  final GtbAvatarWidget avatar;
}

final class GtbSubTimelineListImageKindIconCircle extends GtbSubTimelineListImageKind {
  const GtbSubTimelineListImageKindIconCircle({required this.iconContainerCircle});

  final GtbIconContainerCircle iconContainerCircle;
}

final class GtbSubTimelineListImageKindImage extends GtbSubTimelineListImageKind {
  const GtbSubTimelineListImageKindImage({required this.imageContainer});

  final GtbImageContainer imageContainer;
}

final class GtbSubTimelineListImageKindImageGroup extends GtbSubTimelineListImageKind {
  const GtbSubTimelineListImageKindImageGroup({required this.imageGroup});

  final GtbImageGroup imageGroup;
}

enum _GtbSubListContentItemKind {
  info,
  value,
}

final class GtbSubListContentItem extends StatelessWidget {
  const GtbSubListContentItem.info({
    required this.label,
    super.key,
    GtbInformativeIcon? informativeIcon,
  }) : kind = _GtbSubListContentItemKind.info,
       trailing = informativeIcon;

  const GtbSubListContentItem.value({
    required this.label,
    super.key,
    GtbIconContainer? icon,
  }) : kind = _GtbSubListContentItemKind.value,
       trailing = icon;

  final _GtbSubListContentItemKind kind;
  final Widget label;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final theme = GtbThemeProvider.of(context);
    final appColorScheme = theme.appColorScheme;
    final typography = theme.typography;

    final foregroundColor = switch (kind) {
      _GtbSubListContentItemKind.info => appColorScheme.onColorEmphasisMedium,
      _GtbSubListContentItemKind.value => appColorScheme.onColorEmphasisHigh,
    };

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        DefaultTextStyle(
          style: typography.bodySmall.copyWith(color: foregroundColor),
          child: label,
        ),
        if (trailing case final trailing?) ...[
          GtbGap.xxxs,
          GtbIconContainerTheme(
            data: GtbIconContainerTheme.of(context).copyWith(
              size: GtbIconContainerSize.size16,
              foregroundColor: foregroundColor,
            ),
            child: trailing,
          ),
        ],
      ],
    );
  }
}
