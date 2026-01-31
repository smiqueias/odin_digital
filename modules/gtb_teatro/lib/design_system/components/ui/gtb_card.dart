import 'package:flutter/material.dart';
import 'package:gtb_teatro/design_system/gtb_teatro.dart';
import 'package:gtb_teatro/design_system/models/action_settings.dart';
import 'package:intersperse/intersperse.dart';

typedef GtbSubCardBadges = GtbBadgesGroup;

const _kImageAspectRatio = 1.82;

final class GtbCard extends StatelessWidget {
  const GtbCard({
    super.key,
    this.image,
    this.progressBar,
    this.stripe,
    this.header,
    this.details,
    this.notification,
    this.footer,
    this.badges,
    this.hasDivider = true,
    this.backgroundColor,
    this.borderColor,
    this.borderStrokeWidth,
    this.borderDashedStyle,
    this.shouldFillHeight = false,
    this.onPress,
  });

  final Widget? image;
  final GtbGlobalProgressBar? progressBar;
  final GtbSubCardStripe? stripe;
  final GtbSubCardHeader? header;
  final List<GtbSubCardDetail>? details;
  final GtbNotificationInline? notification;
  final GtbSubCardFooter? footer;
  final GtbSubCardBadges? badges;
  final bool hasDivider;
  final Color? backgroundColor;
  final Color? borderColor;
  final double? borderStrokeWidth;
  final GtbDashedBorderStyle? borderDashedStyle;
  final bool shouldFillHeight;
  final VoidCallback? onPress;

  @override
  Widget build(BuildContext context) {
    final details = this.details;
    final hasDetails = details != null && details.isNotEmpty;
    final hasNotification = notification != null;

    final content = hasDetails || hasNotification
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: GtbGapValue.xs,
            children: [
              if (hasDetails) ...details,
              if (notification case final notification?) //
                notification,
            ],
          )
        : null;

    return _GtbCardBase(
      image: image,
      progressBar: progressBar,
      stripe: stripe,
      header: header,
      content: content,
      footer: footer,
      badges: badges,
      hasTopDivider: hasDivider,
      hasFooterDivider: false,
      shouldAddSpacingBeforeFooter: false,
      backgroundColor: backgroundColor,
      borderColor: borderColor,
      borderStrokeWidth: borderStrokeWidth,
      borderDashedStyle: borderDashedStyle,
      shouldFillHeight: shouldFillHeight,
      onPress: onPress,
    );
  }
}

final class GtbCardExpandController {
  _GtbCardExpandState? _state;

  bool get isExpanded => _state?._isExpanded ?? false;

  void expand() {
    if (!isExpanded) {
      _state?.setExpanded(value: true);
    }
  }

  void collapse() {
    if (isExpanded) {
      _state?.setExpanded(value: false);
    }
  }
}

final class GtbCardExpand extends StatefulWidget {
  const GtbCardExpand({
    required Widget this.expansionRegion,
    super.key,
    this.image,
    this.progressBar,
    this.stripe,
    this.header,
    this.details,
    this.footer,
    this.badges,
    this.hasTopDivider = true,
    this.hasMiddleDivider = true,
    this.hasBottomDivider = true,
    this.backgroundColor,
    this.borderColor,
    this.borderStrokeWidth,
    this.borderDashedStyle,
    this.shouldFillHeight = false,
    this.onPress,
    this.isInitiallyExpanded = false,
    this.expandedExpansionLinkText = 'Retrair conteúdo',
    this.collapsedExpansionLinkText = 'Expandir conteúdo',
    this.controller,
    this.onExpansionChanged,
  }) : expansionRegionBuilder = null;

  const GtbCardExpand.builder({
    required WidgetBuilder this.expansionRegionBuilder,
    super.key,
    this.image,
    this.progressBar,
    this.stripe,
    this.header,
    this.details,
    this.footer,
    this.badges,
    this.hasTopDivider = true,
    this.hasMiddleDivider = true,
    this.hasBottomDivider = true,
    this.backgroundColor,
    this.borderColor,
    this.borderStrokeWidth,
    this.borderDashedStyle,
    this.shouldFillHeight = false,
    this.onPress,
    this.isInitiallyExpanded = false,
    this.expandedExpansionLinkText = 'Retrair conteúdo',
    this.collapsedExpansionLinkText = 'Expandir conteúdo',
    this.controller,
    this.onExpansionChanged,
  }) : expansionRegion = null;

  final Widget? image;
  final GtbGlobalProgressBar? progressBar;
  final GtbSubCardStripe? stripe;
  final GtbSubCardHeader? header;
  final List<GtbSubCardDetail>? details;
  final GtbSubCardFooter? footer;
  final GtbSubCardBadges? badges;
  final bool hasTopDivider;
  final bool hasMiddleDivider;
  final bool hasBottomDivider;
  final Color? backgroundColor;
  final Color? borderColor;
  final double? borderStrokeWidth;
  final GtbDashedBorderStyle? borderDashedStyle;
  final bool shouldFillHeight;
  final VoidCallback? onPress;
  final bool isInitiallyExpanded;
  final String expandedExpansionLinkText;
  final String collapsedExpansionLinkText;
  final Widget? expansionRegion;
  final WidgetBuilder? expansionRegionBuilder;
  final GtbCardExpandController? controller;
  final ValueChanged<bool>? onExpansionChanged;

  @override
  State<GtbCardExpand> createState() => _GtbCardExpandState();
}

final class _GtbCardExpandState extends State<GtbCardExpand> with SingleTickerProviderStateMixin {
  bool _isExpanded = false;
  late final AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    widget.controller?._state = this;

    _isExpanded = widget.isInitiallyExpanded;

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
      value: _isExpanded ? 1.0 : 0.0,
    );
  }

  @override
  void didUpdateWidget(covariant GtbCardExpand oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.controller != widget.controller) {
      oldWidget.controller?._state = null;
      widget.controller?._state = this;
    }
  }

  @override
  void dispose() {
    widget.controller?._state = null;

    _animationController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = GtbThemeProvider.of(context);
    final colorScheme = theme.appColorScheme;
    final typography = theme.typography;

    return _GtbCardBase(
      image: widget.image,
      progressBar: widget.progressBar,
      stripe: widget.stripe,
      header: widget.header,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.details case final details?) //
            Padding(
              padding: const EdgeInsets.only(bottom: GtbPaddingValue.xs),
              child: Column(
                children: (details as List<Widget>)
                    .intersperse(GtbGap.xs) //
                    .toList(growable: false),
              ),
            ),
          if (widget.hasMiddleDivider)
            const Padding(
              padding: EdgeInsets.only(bottom: GtbPaddingValue.xs),
              child: GtbGlobalDivider.sectionThin,
            ),
          GtbInkWell.outsideResponse(
            onTap: () => setExpanded(value: !_isExpanded),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    _isExpanded
                        ? (widget.expandedExpansionLinkText) //
                        : widget.collapsedExpansionLinkText,
                    style: typography.labelSmall.copyWith(color: colorScheme.onColorEmphasisHigh),
                  ),
                ),
                GtbGap.xs,
                RotationTransition(
                  turns: _animationController.drive(
                    Tween<double>(begin: 0.0, end: 0.5).chain(
                      CurveTween(curve: Curves.easeIn),
                    ),
                  ),
                  child: const Icon(GtbIcons.chevronDown),
                ),
              ],
            ),
          ),
          if (widget.expansionRegionBuilder case final builder?)
            AnimatedAlignOpacity.builder(
              alignment: Alignment.topCenter,
              heightFactor: _isExpanded ? 1.0 : 0.0,
              builder: (context) {
                return Padding(
                  padding: const EdgeInsets.only(top: GtbPaddingValue.xs),
                  child: builder(context),
                );
              },
            )
          else
            AnimatedAlignOpacity(
              alignment: Alignment.topCenter,
              heightFactor: _isExpanded ? 1.0 : 0.0,
              child: Padding(
                padding: const EdgeInsets.only(top: GtbPaddingValue.xs),
                child: widget.expansionRegion ?? const SizedBox(),
              ),
            ),
        ],
      ),
      footer: widget.footer,
      badges: widget.badges,
      hasTopDivider: widget.hasTopDivider,
      hasFooterDivider: widget.hasBottomDivider,
      shouldAddSpacingBeforeFooter: true,
      backgroundColor: widget.backgroundColor,
      borderColor: widget.borderColor,
      borderStrokeWidth: widget.borderStrokeWidth,
      borderDashedStyle: widget.borderDashedStyle,
      shouldFillHeight: widget.shouldFillHeight,
      onPress: widget.onPress,
    );
  }

  void setExpanded({required bool value}) {
    if (_isExpanded != value) {
      setState(() {
        _isExpanded = value;
      });

      if (_isExpanded) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }

      widget.onExpansionChanged?.call(_isExpanded);
    }
  }
}

final class _GtbCardBase extends StatelessWidget {
  const _GtbCardBase({
    required this.hasTopDivider,
    required this.hasFooterDivider,
    required this.shouldAddSpacingBeforeFooter,
    required this.shouldFillHeight,
    this.image,
    this.progressBar,
    this.stripe,
    this.header,
    this.content,
    this.footer,
    this.badges,
    this.backgroundColor,
    this.borderColor,
    this.borderStrokeWidth,
    this.borderDashedStyle,
    this.onPress,
  });

  final Widget? image;
  final GtbGlobalProgressBar? progressBar;
  final GtbSubCardStripe? stripe;
  final GtbSubCardHeader? header;
  final Widget? content;
  final GtbSubCardFooter? footer;
  final GtbSubCardBadges? badges;
  final bool hasTopDivider;
  final bool hasFooterDivider;
  final bool shouldAddSpacingBeforeFooter;
  final bool shouldFillHeight;
  final Color? backgroundColor;
  final Color? borderColor;
  final double? borderStrokeWidth;
  final GtbDashedBorderStyle? borderDashedStyle;
  final VoidCallback? onPress;

  @override
  Widget build(BuildContext context) {
    final theme = GtbThemeProvider.of(context);

    final resolvedBorderColor = borderColor ?? theme.appColorScheme.outlineBase;
    final resolvedBorderStrokeWidth = borderStrokeWidth ?? theme.borderTheme.strokeThin;
    final resolvedBorderStyle = borderDashedStyle ?? const GtbBorderStyle.solid();

    final hasHeader = header?.hasContent() ?? false;
    final hasBadges = badges?.hasContent ?? false;
    final hasContent = content != null;
    final hasFooter = footer?.hasContent() ?? false;
    final shouldAddSpacingBeforeFooterDivider =
        hasHeader || hasTopDivider || hasBadges || hasContent;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: backgroundColor ?? theme.appColorScheme.actionNeutralEnabled,
        borderRadius: BorderRadius.circular(GtbGapValue.xxxs),
        border: GtbBorder.all(
          color: resolvedBorderColor,
          stroke: resolvedBorderStrokeWidth,
          style: resolvedBorderStyle,
        ),
      ),
      child: Material(
        color: kTransparentColor,
        clipBehavior: Clip.antiAlias,
        borderRadius: BorderRadius.circular(GtbGapValue.xxxs + 2 * resolvedBorderStrokeWidth),
        child: GtbInkWell(
          onTap: onPress,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (image case final image?)
                Padding(
                  padding: EdgeInsets.only(
                    left: resolvedBorderStrokeWidth,
                    right: resolvedBorderStrokeWidth,
                    top: resolvedBorderStrokeWidth,
                  ),
                  child: AspectRatio(
                    aspectRatio: _kImageAspectRatio,
                    child: image,
                  ),
                ),
              if (progressBar case final progressBar?)
                GtbGlobalProgressBarTheme(
                  data: GtbGlobalProgressBarTheme.of(
                    context,
                  ).copyWith(kind: GtbGlobalProgressBarKind.squared),
                  child: progressBar,
                ),
              Flexible(
                flex: shouldFillHeight ? 1 : 0,
                child: Stack(
                  children: [
                    if (stripe case final stripe?) stripe,
                    Padding(
                      padding: const EdgeInsets.only(
                        left: GtbPaddingValue.sm,
                        right: GtbPaddingValue.sm,
                        top: GtbPaddingValue.sm,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: GtbGapValue.xs,
                        children: [
                          if (header case final header? when hasHeader) header,
                          if (hasTopDivider) GtbGlobalDivider.sectionThin,
                          if (badges case final badges? when hasBadges) badges,
                          if (content case final content?) content,
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              if (footer case final footer? when hasFooter)
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (shouldAddSpacingBeforeFooterDivider) GtbGap.xs,
                    if (hasFooterDivider) GtbGlobalDivider.sectionThin,
                    if (shouldAddSpacingBeforeFooter) GtbGap.xs,
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: GtbPaddingValue.sm),
                      child: footer,
                    ),
                  ],
                ),
              GtbGap.sm,
            ],
          ),
        ),
      ),
    );
  }
}

class GtbSubCardStripe extends StatelessWidget {
  const GtbSubCardStripe({
    required this.color,
    super.key,
  });

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(GtbPaddingValue.xxxs),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(100.0),
        ),
        child: const SizedBox(width: double.infinity, height: 4.0),
      ),
    );
  }
}

enum GtbSubCardHeaderImagePosition {
  top,
  left,
}

final class GtbSubCardHeader extends StatelessWidget {
  const GtbSubCardHeader({
    super.key,
    this.leftOverline,
    this.leftTitle,
    this.leftCaption,
    this.leftFlex = 1,
    this.rightOverline,
    this.rightTitle,
    this.rightCaption,
    this.rightFlex = 1,
    this.cardCorner,
    this.cardImage,
    this.upperBadge,
    this.imagePosition = GtbSubCardHeaderImagePosition.left,
  });

  final Widget? leftOverline;
  final Widget? leftTitle;
  final Widget? leftCaption;
  final int leftFlex;
  final Widget? rightOverline;
  final Widget? rightTitle;
  final Widget? rightCaption;
  final int rightFlex;
  final GtbSubCardCorner? cardCorner;
  final GtbSubCardImage? cardImage;
  final GtbBadgeWidget? upperBadge;
  final GtbSubCardHeaderImagePosition imagePosition;

  @override
  Widget build(BuildContext context) {
    final theme = GtbThemeProvider.of(context);
    final colors = theme.appColorScheme;

    final cardImage = this.cardImage;
    final hasTopImage = cardImage != null && imagePosition == GtbSubCardHeaderImagePosition.top;
    final hasLeftImage = cardImage != null && imagePosition == GtbSubCardHeaderImagePosition.left;
    final hasLeftTexts = leftOverline != null || leftTitle != null || leftCaption != null;
    final hasRightTexts = rightOverline != null || rightTitle != null || rightCaption != null;
    final hasCardCornerAfterTexts = !hasTopImage && cardCorner != null;
    final hasTextsRow = hasLeftImage || hasLeftTexts || hasRightTexts || hasCardCornerAfterTexts;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: GtbGapValue.xs,
      children: [
        if (hasTopImage)
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              cardImage,
              GtbGap.xs,
              if (cardCorner case final cardCorner?) cardCorner,
            ],
          ),
        if (upperBadge case final upperBadge?) //
          upperBadge,
        if (hasTextsRow)
          Row(
            children: [
              if (hasLeftImage) ...[
                cardImage,
                GtbGap.xxs,
              ],
              if (hasLeftTexts)
                Expanded(
                  flex: leftFlex,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (leftOverline case final leftOverline?)
                        DefaultTextStyle(
                          overflow: TextOverflow.ellipsis,
                          style: theme.typography.labelTiny.copyWith(
                            color: colors.onColorEmphasisLow,
                          ),
                          child: leftOverline,
                        ),
                      if (leftTitle case final leftTitle?)
                        DefaultTextStyle(
                          overflow: TextOverflow.ellipsis,
                          style: theme.typography.bodyBase.copyWith(
                            color: colors.onColorEmphasisHigh,
                          ),
                          child: leftTitle,
                        ),
                      if (leftCaption case final leftCaption?)
                        DefaultTextStyle(
                          overflow: TextOverflow.ellipsis,
                          style: theme.typography.captionBase.copyWith(
                            color: colors.onColorEmphasisLow,
                          ),
                          child: leftCaption,
                        ),
                    ],
                  ),
                ),
              if (hasLeftTexts && hasRightTexts) GtbGap.xs,
              if (!hasLeftTexts && !hasRightTexts) const Spacer(),
              if (hasRightTexts)
                Expanded(
                  flex: rightFlex,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      if (rightOverline case final rightOverline?)
                        DefaultTextStyle(
                          overflow: TextOverflow.ellipsis,
                          style: theme.typography.labelTiny.copyWith(
                            color: colors.onColorEmphasisLow,
                          ),
                          child: rightOverline,
                        ),
                      if (rightTitle case final rightTitle?)
                        DefaultTextStyle(
                          overflow: TextOverflow.ellipsis,
                          style: theme.typography.bodyBase.copyWith(
                            color: colors.onColorEmphasisHigh,
                          ),
                          child: rightTitle,
                        ),
                      if (rightCaption case final rightCaption?)
                        DefaultTextStyle(
                          overflow: TextOverflow.ellipsis,
                          style: theme.typography.captionBase.copyWith(
                            color: colors.onColorEmphasisLow,
                          ),
                          child: rightCaption,
                        ),
                    ],
                  ),
                ),
              if (cardCorner case final cardCorner? when hasCardCornerAfterTexts) ...[
                GtbGap.xxs,
                cardCorner,
              ],
            ],
          ),
      ],
    );
  }

  bool hasContent() {
    return leftOverline != null ||
        leftTitle != null ||
        leftCaption != null ||
        rightOverline != null ||
        rightTitle != null ||
        rightCaption != null ||
        cardCorner != null ||
        cardImage != null;
  }
}

sealed class GtbSubCardImageKind {
  const GtbSubCardImageKind();

  const factory GtbSubCardImageKind.avatar({
    required GtbAvatarWidget avatar,
  }) = GtbSubCardImageKindAvatar;

  const factory GtbSubCardImageKind.iconCircle({
    required GtbIconContainerCircle iconContainerCircle,
  }) = GtbSubCardImageKindIconCircle;

  const factory GtbSubCardImageKind.image({
    required GtbImageContainer imageContainer,
  }) = GtbSubCardImageKindImage;

  const factory GtbSubCardImageKind.imageCombo({
    required GtbGlobalImageCombo imageCombo,
  }) = GtbSubCardImageKindImageCombo;

  const factory GtbSubCardImageKind.imageGroup({
    required GtbImageGroup imageGroup,
  }) = GtbSubCardImageKindImageGroup;
}

final class GtbSubCardImageKindAvatar extends GtbSubCardImageKind {
  const GtbSubCardImageKindAvatar({required this.avatar});

  final GtbAvatarWidget avatar;
}

final class GtbSubCardImageKindIconCircle extends GtbSubCardImageKind {
  const GtbSubCardImageKindIconCircle({required this.iconContainerCircle});

  final GtbIconContainerCircle iconContainerCircle;
}

final class GtbSubCardImageKindImage extends GtbSubCardImageKind {
  const GtbSubCardImageKindImage({required this.imageContainer});

  final GtbImageContainer imageContainer;
}

final class GtbSubCardImageKindImageCombo extends GtbSubCardImageKind {
  const GtbSubCardImageKindImageCombo({required this.imageCombo});

  final GtbGlobalImageCombo imageCombo;
}

final class GtbSubCardImageKindImageGroup extends GtbSubCardImageKind {
  const GtbSubCardImageKindImageGroup({required this.imageGroup});

  final GtbImageGroup imageGroup;
}

class GtbSubCardImage extends StatelessWidget {
  const GtbSubCardImage({
    required this.kind,
    super.key,
  });

  final GtbSubCardImageKind kind;

  @override
  Widget build(BuildContext context) {
    return switch (kind) {
      GtbSubCardImageKindAvatar(:final avatar) => GtbAvatarTheme(
        data: GtbAvatarTheme.of(context).copyWith(
          hasOutline: true,
          size: GtbAvatarSize.size40,
        ),
        child: avatar,
      ),
      GtbSubCardImageKindIconCircle(:final iconContainerCircle) => GtbIconContainerTheme(
        data: GtbIconContainerTheme.of(context).copyWith(
          circleSize: GtbIconContainerCircleSize.size40,
        ),
        child: iconContainerCircle,
      ),
      GtbSubCardImageKindImage(:final imageContainer) => GtbImageContainerTheme(
        data: GtbImageContainerTheme.of(context).copyWith(
          size: GtbImageContainerSize.size40,
          shape: GtbImageContainerShape.rounded,
        ),
        child: imageContainer,
      ),
      GtbSubCardImageKindImageCombo(:final imageCombo) => GtbGlobalImageComboTheme(
        data: GtbGlobalImageComboThemeData(
          size: GtbGlobalImageComboSize.size40,
        ),
        child: imageCombo,
      ),
      GtbSubCardImageKindImageGroup(:final imageGroup) => GtbImageGroupTheme(
        data: GtbImageGroupThemeData(size: GtbImageGroupSize.medium),
        child: imageGroup,
      ),
    };
  }
}

sealed class GtbSubCardCornerKind {
  const GtbSubCardCornerKind({
    required this.widget,
  });

  const factory GtbSubCardCornerKind.checkbox(GtbCheckbox checkbox) = GtbSubCardCornerKindCheckbox;

  const factory GtbSubCardCornerKind.radioButton(GtbRadioButton<Object?> radioButton) =
      GtbSubCardCornerKindRadioButton;

  const factory GtbSubCardCornerKind.badge(GtbBadgeWidget badge) = GtbSubCardCornerKindBadge;

  final Widget widget;
}

final class GtbSubCardCornerKindCheckbox extends GtbSubCardCornerKind {
  const GtbSubCardCornerKindCheckbox(GtbCheckbox checkbox) : super(widget: checkbox);
}

final class GtbSubCardCornerKindRadioButton extends GtbSubCardCornerKind {
  const GtbSubCardCornerKindRadioButton(GtbRadioButton<Object?> radioButton)
    : super(widget: radioButton);
}

final class GtbSubCardCornerKindBadge extends GtbSubCardCornerKind {
  const GtbSubCardCornerKindBadge(GtbBadgeWidget badge) : super(widget: badge);
}

final class GtbSubCardCorner extends StatelessWidget {
  const GtbSubCardCorner({
    required this.kind,
    super.key,
  });

  final GtbSubCardCornerKind kind;

  @override
  Widget build(BuildContext context) {
    if (kind is GtbSubCardCornerKindCheckbox) {
      return Transform.translate(
        offset: const Offset(kCheckboxExtraSpacing, -kCheckboxExtraSpacing),
        child: kind.widget,
      );
    } else if (kind is GtbSubCardCornerKindRadioButton) {
      return Transform.translate(
        offset: const Offset(kRadioButtonExtraSpacing, -kRadioButtonExtraSpacing),
        child: kind.widget,
      );
    } else {
      return kind.widget;
    }
  }
}

sealed class GtbSubCardDetail extends StatelessWidget {
  const GtbSubCardDetail({super.key});

  const factory GtbSubCardDetail.slot(Widget slot) = GtbSubCardDetailSlot;

  const factory GtbSubCardDetail.description(Text text) = GtbSubCardDetailDescription;

  const factory GtbSubCardDetail.twoColumns({
    required Widget leftTitle,
    Widget? leftOverline,
    Widget? rightOverline,
    Widget? rightTitle,
    Widget? leftCaption,
    Widget? rightCaption,
    int? leftFlex,
    int? rightFlex,
  }) = GtbSubCardDetailTwoColumns;

  const factory GtbSubCardDetail.list(List<GtbSubCardDetailListRow> rows) = GtbSubCardDetailList;
}

final class GtbSubCardDetailSlot extends GtbSubCardDetail {
  const GtbSubCardDetailSlot(this.slot, {super.key});

  final Widget slot;

  @override
  Widget build(BuildContext context) => slot;
}

final class GtbSubCardDetailDescription extends GtbSubCardDetail {
  const GtbSubCardDetailDescription(this.text, {super.key});

  final Widget text;

  @override
  Widget build(BuildContext context) {
    final theme = GtbThemeProvider.of(context);

    return DefaultTextStyle(
      style: theme.typography.bodySmall.copyWith(color: theme.appColorScheme.onColorEmphasisHigh),
      child: text,
    );
  }
}

final class GtbSubCardDetailTwoColumns extends GtbSubCardDetail {
  const GtbSubCardDetailTwoColumns({
    required this.leftTitle,
    super.key,
    this.leftOverline,
    this.rightOverline,
    this.rightTitle,
    this.leftCaption,
    this.rightCaption,
    this.leftFlex,
    this.rightFlex,
  });

  final Widget? leftOverline;
  final Widget? rightOverline;
  final Widget leftTitle;
  final Widget? rightTitle;
  final Widget? leftCaption;
  final Widget? rightCaption;
  final int? leftFlex;
  final int? rightFlex;

  @override
  Widget build(BuildContext context) {
    final theme = GtbThemeProvider.of(context);
    final colorScheme = theme.appColorScheme;
    final typography = theme.typography;
    final overlineStyle = typography.captionBase.copyWith(color: colorScheme.onColorEmphasisLow);
    final titleStyle = typography.titleSmall.copyWith(color: colorScheme.onColorEmphasisHigh);
    final captionStyle = typography.captionBase.copyWith(color: colorScheme.onColorEmphasisLow);

    final leftFlex = this.leftFlex ?? 1;
    final rightFlex = this.rightFlex ?? 1;

    final hasOverline = leftOverline != null || rightOverline != null;
    final hasCaption = leftCaption != null || rightCaption != null;

    return Column(
      children: [
        if (hasOverline) //
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (leftOverline case final leftOverline?) //
                Flexible(
                  flex: leftFlex,
                  child: DefaultTextStyle(
                    style: overlineStyle,
                    child: leftOverline,
                  ),
                ),
              if (rightOverline case final rightOverline?) //
                Expanded(
                  flex: rightFlex,
                  child: DefaultTextStyle(
                    textAlign: TextAlign.right,
                    style: overlineStyle,
                    child: rightOverline,
                  ),
                ),
            ],
          ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              flex: leftFlex,
              child: DefaultTextStyle(
                style: titleStyle,
                child: leftTitle,
              ),
            ),
            if (rightTitle case final rightTitle?) //
              Expanded(
                flex: rightFlex,
                child: DefaultTextStyle(
                  textAlign: TextAlign.right,
                  style: titleStyle,
                  child: rightTitle,
                ),
              ),
          ],
        ),
        if (hasCaption) //
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (leftCaption case final leftCaption?) //
                Flexible(
                  flex: leftFlex,
                  child: DefaultTextStyle(
                    style: captionStyle,
                    child: leftCaption,
                  ),
                ),
              if (rightCaption case final rightCaption?) //
                Expanded(
                  flex: rightFlex,
                  child: DefaultTextStyle(
                    textAlign: TextAlign.right,
                    style: captionStyle,
                    child: rightCaption,
                  ),
                ),
            ],
          ),
      ],
    );
  }
}

final class GtbSubCardDetailList extends GtbSubCardDetail {
  const GtbSubCardDetailList(this.rows, {super.key})
    : assert(rows.length >= 2, 'GtbSubCardDetailKindList must have at least two list rows'),
      assert(rows.length <= 12, 'GtbSubCardDetailKindList must have at most twelve list rows');

  final List<GtbSubCardDetailListRow> rows;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: (rows as List<Widget>)
          .intersperse(GtbGlobalDivider.sectionThin) //
          .toList(growable: false),
    );
  }
}

final class GtbSubCardDetailListRow extends StatelessWidget {
  const GtbSubCardDetailListRow({
    required this.label,
    required this.value,
    super.key,
    this.leftFlex = 1,
    this.rightFlex = 1,
    this.informativeIcon,
  });

  final Widget label;
  final Widget value;
  final int leftFlex;
  final int rightFlex;
  final GtbInformativeIcon? informativeIcon;

  @override
  Widget build(BuildContext context) {
    final theme = GtbThemeProvider.of(context);
    final colorScheme = theme.appColorScheme;
    final typography = theme.typography;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: GtbPaddingValue.xxs),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        spacing: GtbGapValue.xs,
        children: [
          Flexible(
            flex: leftFlex,
            child: Row(
              children: [
                Flexible(
                  child: DefaultTextStyle(
                    style: typography.bodySmall.copyWith(color: colorScheme.onColorEmphasisMedium),
                    textWidthBasis: TextWidthBasis.longestLine,
                    child: label,
                  ),
                ),
                if (informativeIcon case final informativeIcon?) ...[
                  GtbGap.xxxs,
                  informativeIcon,
                ],
              ],
            ),
          ),
          Flexible(
            flex: rightFlex,
            child: DefaultTextStyle(
              textAlign: TextAlign.right,
              style: typography.bodySmall.copyWith(color: colorScheme.onColorEmphasisHigh),
              child: value,
            ),
          ),
        ],
      ),
    );
  }
}

final class GtbSubCardFooter extends StatelessWidget {
  const GtbSubCardFooter({
    super.key,
    this.button,
    this.linkSettings,
    this.leftIconSettings,
    this.rightIconSettings,
  });

  final Widget? button;
  final GtbActionSettings<VoidCallback>? linkSettings;
  final GtbIconActionSettings? leftIconSettings;
  final GtbIconActionSettings? rightIconSettings;

  @override
  Widget build(BuildContext context) {
    const iconButtonSize = 30.0;
    const iconSize = 24.0;
    final hasAnythingAfterButton = button != null && linkSettings != null;

    return Row(
      children: [
        if (button case final button?)
          GtbDefaultButtonProperties(
            kind: GtbButtonKind.line,
            size: GtbButtonSize.compact,
            child: button,
          ),
        if (hasAnythingAfterButton) GtbGap.xs,
        if (linkSettings case final linkSettings?)
          GtbLink.fromActionSettings(
            actionSettings: linkSettings.copyWith(
              rightIcon: linkSettings.rightIcon ?? GtbIcons.chevronRight,
            ),
            size: GtbLinkSize.small,
          ),
        const Spacer(),
        Transform.translate(
          offset: const Offset((iconButtonSize - iconSize) / 2, 0),
          child: Row(
            children: [
              if (leftIconSettings case final leftIconSettings?)
                GtbIconButton.fromActionSettings(
                  actionSettings: leftIconSettings,
                  minSize: iconButtonSize,
                ),
              if (leftIconSettings != null && rightIconSettings != null) //
                GtbGap.xs,
              if (rightIconSettings case final rightIconSettings?)
                GtbIconButton.fromActionSettings(
                  actionSettings: rightIconSettings,
                  minSize: iconButtonSize,
                ),
            ],
          ),
        ),
      ],
    );
  }

  bool hasContent() {
    return button != null || //
        linkSettings != null ||
        leftIconSettings != null ||
        rightIconSettings != null;
  }
}

final class GtbCardShimmer extends StatelessWidget {
  const GtbCardShimmer({
    super.key,
    this.hasImage = false,
    this.backgroundColor,
    this.borderColor,
    this.borderStrokeWidth,
    this.borderDashedStyle,
  });

  final bool hasImage;
  final Color? backgroundColor;
  final Color? borderColor;
  final double? borderStrokeWidth;
  final GtbDashedBorderStyle? borderDashedStyle;

  @override
  Widget build(BuildContext context) {
    const smallTextShimmerBox = GtbShimmerCover(
      child: SizedBox(
        width: double.infinity,
        height: 21.0,
      ),
    );
    const mediumTextShimmerBox = GtbShimmerCover(
      child: SizedBox(
        width: double.infinity,
        height: 24.0,
      ),
    );
    const largeTextShimmerBox = GtbShimmerCover(
      child: SizedBox(
        width: double.infinity,
        height: 32.0,
      ),
    );

    if (hasImage) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GtbCard(
            backgroundColor: backgroundColor,
            borderColor: borderColor,
            borderStrokeWidth: borderStrokeWidth,
            borderDashedStyle: borderDashedStyle,
            hasDivider: false,
            image: const GtbShimmer(
              child: GtbShimmerCover(
                child: AspectRatio(
                  aspectRatio: _kImageAspectRatio,
                  child: SizedBox(width: double.infinity),
                ),
              ),
            ),
            details: const [
              GtbSubCardDetail.slot(
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GtbShimmer(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          smallTextShimmerBox,
                          GtbGap.xxxs,
                          FractionallySizedBox(
                            widthFactor: 0.5,
                            child: smallTextShimmerBox,
                          ),
                          GtbGap.xxxs,
                          GtbShimmerCover(
                            borderRadius: 100.0,
                            child: SizedBox(
                              width: 64.0,
                              height: 23.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                    GtbGap.xs,
                    GtbGlobalDivider.sectionThin,
                    GtbGap.xs,
                    GtbShimmer(
                      child: FractionallySizedBox(
                        widthFactor: 0.25,
                        child: largeTextShimmerBox,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      );
    } else {
      return const GtbCard(
        header: GtbSubCardHeader(
          cardImage: GtbSubCardImage(
            kind: GtbSubCardImageKind.avatar(
              avatar: GtbAvatarShimmer(),
            ),
          ),
          leftTitle: GtbShimmer(
            child: mediumTextShimmerBox,
          ),
          leftCaption: GtbShimmer(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: GtbPaddingValue.xxxs),
              child: FractionallySizedBox(
                widthFactor: 0.5,
                child: smallTextShimmerBox,
              ),
            ),
          ),
        ),
        details: [
          GtbSubCardDetail.slot(
            GtbShimmer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  smallTextShimmerBox,
                  GtbGap.xxxs,
                  smallTextShimmerBox,
                  GtbGap.xxxs,
                  smallTextShimmerBox,
                  GtbGap.xxxs,
                  FractionallySizedBox(
                    widthFactor: 0.8,
                    child: smallTextShimmerBox,
                  ),
                  GtbGap.xs,
                  FractionallySizedBox(
                    widthFactor: 0.25,
                    child: largeTextShimmerBox,
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    }
  }
}
