import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gtb_teatro/design_system/gtb_teatro.dart';

enum GtbBadgeStatusKind {
  positive,
  warning,
  negative,
  informative,
  neutral,
}

enum GtbBadgeSuitabilityKind {
  conservative,
  moderate,
  sophisticated,
}

sealed class GtbBadgeWidget extends StatelessWidget {
  const GtbBadgeWidget({super.key});
}

final class GtbBadgeStatus extends GtbBadgeWidget {
  const GtbBadgeStatus({
    required this.kind,
    required this.label,
    super.key,
    this.hasOutline = false,
    this.isLoading = false,
    this.semanticsLabel,
    this.semanticsHint,
    this.onPress,
  });

  const GtbBadgeStatus.positive({
    required this.label,
    super.key,
    this.hasOutline = false,
    this.isLoading = false,
    this.semanticsLabel,
    this.semanticsHint,
    this.onPress,
  }) : kind = GtbBadgeStatusKind.positive;

  const GtbBadgeStatus.warning({
    required this.label,
    super.key,
    this.hasOutline = false,
    this.isLoading = false,
    this.semanticsLabel,
    this.semanticsHint,
    this.onPress,
  }) : kind = GtbBadgeStatusKind.warning;

  const GtbBadgeStatus.negative({
    required this.label,
    super.key,
    this.hasOutline = false,
    this.isLoading = false,
    this.semanticsLabel,
    this.semanticsHint,
    this.onPress,
  }) : kind = GtbBadgeStatusKind.negative;

  const GtbBadgeStatus.informative({
    required this.label,
    super.key,
    this.hasOutline = false,
    this.isLoading = false,
    this.semanticsLabel,
    this.semanticsHint,
    this.onPress,
  }) : kind = GtbBadgeStatusKind.informative;

  const GtbBadgeStatus.neutral({
    required this.label,
    super.key,
    this.hasOutline = false,
    this.isLoading = false,
    this.semanticsLabel,
    this.semanticsHint,
    this.onPress,
  }) : kind = GtbBadgeStatusKind.neutral;

  final GtbBadgeStatusKind kind;
  final Widget label;
  final bool hasOutline;
  final bool isLoading;
  final String? semanticsLabel;
  final String? semanticsHint;
  final VoidCallback? onPress;

  @override
  Widget build(BuildContext context) {
    final theme = GtbThemeProvider.of(context);

    final icon = _getIcon();
    final iconColor = _getIconColorOf(theme.appColorScheme);
    final backgroundColor = _getBackgroundColorOf(theme.appColorScheme);

    return GtbBadge(
      backgroundColor: backgroundColor,
      label: label,
      iconContainer: GtbIconContainer(
        icon: icon,
        color: iconColor,
      ),
      hasOutline: hasOutline,
      isLoading: isLoading,
      semanticsLabel: semanticsLabel,
      semanticsHint: semanticsHint,
      onPress: onPress,
    );
  }

  IconData _getIcon() {
    return switch (kind) {
      GtbBadgeStatusKind.positive => GtbIcons.statusSuccess,
      GtbBadgeStatusKind.warning => GtbIcons.statusWarning,
      GtbBadgeStatusKind.negative => GtbIcons.statusDisapproved,
      GtbBadgeStatusKind.informative => GtbIcons.infoOn,
      GtbBadgeStatusKind.neutral => GtbIcons.infoOn,
    };
  }

  Color _getIconColorOf(GtbColorScheme colorScheme) {
    return switch (kind) {
      GtbBadgeStatusKind.positive => colorScheme.statusSuccessBase,
      GtbBadgeStatusKind.warning => colorScheme.statusWarningBase,
      GtbBadgeStatusKind.negative => colorScheme.statusErrorBase,
      GtbBadgeStatusKind.informative => colorScheme.statusInformativeBase,
      GtbBadgeStatusKind.neutral => colorScheme.neutralExtended70,
    };
  }

  Color _getBackgroundColorOf(GtbColorScheme colorScheme) {
    return switch (kind) {
      GtbBadgeStatusKind.positive => colorScheme.statusSuccessBaseSurface,
      GtbBadgeStatusKind.warning => colorScheme.statusWarningBaseSurface,
      GtbBadgeStatusKind.negative => colorScheme.statusErrorBaseSurface,
      GtbBadgeStatusKind.informative => colorScheme.statusInformativeBaseSurface,
      GtbBadgeStatusKind.neutral => colorScheme.neutralExtended30,
    };
  }
}

final class GtbBadgeSuitability extends GtbBadgeWidget {
  const GtbBadgeSuitability({
    required this.kind,
    super.key,
    this.hasOutline = false,
    this.isLoading = false,
    this.semanticsLabel,
    this.semanticsHint,
    this.onPress,
  });

  const GtbBadgeSuitability.conservative({
    super.key,
    this.hasOutline = false,
    this.isLoading = false,
    this.semanticsLabel,
    this.semanticsHint,
    this.onPress,
  }) : kind = GtbBadgeSuitabilityKind.conservative;

  const GtbBadgeSuitability.moderate({
    super.key,
    this.hasOutline = false,
    this.isLoading = false,
    this.semanticsLabel,
    this.semanticsHint,
    this.onPress,
  }) : kind = GtbBadgeSuitabilityKind.moderate;

  const GtbBadgeSuitability.sophisticated({
    super.key,
    this.hasOutline = false,
    this.isLoading = false,
    this.semanticsLabel,
    this.semanticsHint,
    this.onPress,
  }) : kind = GtbBadgeSuitabilityKind.sophisticated;

  final GtbBadgeSuitabilityKind kind;
  final bool hasOutline;
  final bool isLoading;
  final String? semanticsLabel;
  final String? semanticsHint;
  final VoidCallback? onPress;

  @override
  Widget build(BuildContext context) {
    final theme = GtbThemeProvider.of(context);

    return GtbBadge(
      backgroundColor: _getBackgroundColor(theme.appColorScheme),
      hasOutline: hasOutline,
      isLoading: isLoading,
      iconContainer: GtbIconContainer(
        icon: _getIcon(),
        color: theme.appColorScheme.onColorEmphasisMedium,
      ),
      label: Text(
        _getText(),
        style: theme.typography.labelMicro,
      ),
      semanticsLabel: semanticsLabel,
      semanticsHint: semanticsHint,
      onPress: onPress,
    );
  }

  Color _getBackgroundColor(GtbColorScheme colorScheme) {
    return switch (kind) {
      GtbBadgeSuitabilityKind.conservative => colorScheme.supportAqua10,
      GtbBadgeSuitabilityKind.moderate => colorScheme.supportPink10,
      GtbBadgeSuitabilityKind.sophisticated => colorScheme.supportPurple10,
    };
  }

  IconData _getIcon() {
    return switch (kind) {
      GtbBadgeSuitabilityKind.conservative => GtbIcons.conservative,
      GtbBadgeSuitabilityKind.moderate => GtbIcons.moderate,
      GtbBadgeSuitabilityKind.sophisticated => GtbIcons.aggressive,
    };
  }

  String _getText() {
    return switch (kind) {
      GtbBadgeSuitabilityKind.conservative => 'Conservador',
      GtbBadgeSuitabilityKind.moderate => 'Moderado',
      GtbBadgeSuitabilityKind.sophisticated => 'Sofisticado',
    };
  }
}

final class GtbBadge extends GtbBadgeWidget {
  const GtbBadge({
    required this.backgroundColor,
    required this.label,
    super.key,
    this.iconContainer,
    this.imageContainer,
    this.hasOutline = false,
    this.isLoading = false,
    this.semanticsLabel,
    this.semanticsHint,
    this.onPress,
  });

  static const _radius = 24.0;

  final Color backgroundColor;
  final Widget label;
  final GtbIconContainer? iconContainer;
  final GtbImageContainer? imageContainer;
  final bool hasOutline;
  final bool isLoading;
  final String? semanticsLabel;
  final String? semanticsHint;
  final VoidCallback? onPress;

  @override
  Widget build(BuildContext context) {
    final theme = GtbThemeProvider.of(context);
    final colorScheme = theme.appColorScheme;
    final typography = theme.typography;

    return GtbShimmer(
      isLoading: isLoading,
      child: GtbShimmerCover(
        borderRadius: _radius,
        child: Semantics(
          label: semanticsLabel,
          hint: semanticsHint,
          child: Container(
            height: MediaQuery.textScalerOf(context).scale(_radius),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(_radius),
              border: hasOutline
                  ? GtbBorder.all(
                      color: colorScheme.outlineBase,
                      stroke: theme.borderTheme.strokeThin,
                    )
                  : null,
            ),
            child: Material(
              color: kTransparentColor,
              child: GtbInkWell(
                onTap: onPress,
                borderRadius: BorderRadius.circular(_radius),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: GtbPaddingValue.xxs),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    spacing: GtbGapValue.xxs,
                    children: [
                      if (imageContainer case final imageContainer?)
                        GtbImageContainerTheme(
                          data: GtbImageContainerTheme.of(context).copyWith(
                            size: GtbImageContainerSize.size16,
                          ),
                          child: imageContainer,
                        ),
                      if (iconContainer case final iconContainer?)
                        GtbIconContainerTheme(
                          data: GtbIconContainerTheme.of(context).copyWith(
                            size: GtbIconContainerSize.size16,
                          ),
                          child: iconContainer,
                        ),
                      Flexible(
                        child: DefaultTextStyle(
                          style: typography.labelMicro.copyWith(
                            color: colorScheme.onColorEmphasisHigh,
                          ),
                          child: label,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

enum GtbBadgeCountSize {
  large,
  small,
}

final class GtbBadgeCount extends GtbBadgeWidget {
  const GtbBadgeCount({
    required this.count,
    super.key,
    this.size = GtbBadgeCountSize.small,
    this.semanticsLabel,
    this.semanticsHint,
    this.onPress,
  });

  final int count;
  final GtbBadgeCountSize size;
  final String? semanticsLabel;
  final String? semanticsHint;
  final VoidCallback? onPress;

  @override
  Widget build(BuildContext context) {
    final theme = GtbThemeProvider.of(context);
    final colorScheme = theme.appColorScheme;
    final typography = theme.typography;

    return GtbBadge(
      backgroundColor: colorScheme.supportGrey20,
      label: Text(
        count <= 0
            ? '$count' //
            : '+$count',
        style: switch (size) {
          GtbBadgeCountSize.large => typography.labelSmall.copyWith(
            color: colorScheme.onColorEmphasisHigh,
          ),
          GtbBadgeCountSize.small => typography.labelMicro.copyWith(
            color: colorScheme.onColorEmphasisHigh,
          ),
        },
      ),
      semanticsLabel: semanticsLabel,
      semanticsHint: semanticsHint,
      onPress: onPress,
    );
  }
}

final class GtbBadgesGroup extends StatelessWidget {
  const GtbBadgesGroup({
    required this.badges,
    super.key,
    this.badgeSurplus,
    this.textDirection = TextDirection.ltr,
  });

  final List<GtbBadgeWidget> badges;
  final GtbBadgeSurplus? badgeSurplus;
  final TextDirection textDirection;

  bool get hasContent {
    final badgeSurplus = this.badgeSurplus;

    return badges.isNotEmpty || (badgeSurplus != null && badgeSurplus.items.isNotEmpty);
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      textDirection: textDirection,
      spacing: GtbGapValue.xxxs,
      runSpacing: GtbGapValue.xxs,
      children: [
        ...badges,
        if (badgeSurplus case final badgeSurplus? when badgeSurplus.items.isNotEmpty) //
          badgeSurplus,
      ],
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('badges', badges));
  }
}

final class GtbBadgeSurplus extends StatelessWidget {
  const GtbBadgeSurplus({
    required this.items,
    super.key,
    this.backgroundColor,
    this.hasOutline = false,
    this.tooltipAlignment = GtbTooltipAlignment.center,
    this.tooltipPosition = GtbTooltipPosition.bottom,
  });

  final List<Widget> items;
  final Color? backgroundColor;
  final bool hasOutline;
  final GtbTooltipAlignment tooltipAlignment;
  final GtbTooltipPosition tooltipPosition;

  @override
  Widget build(BuildContext context) {
    final colorScheme = GtbThemeProvider.of(context).appColorScheme;

    return GtbTooltip(
      alignment: tooltipAlignment,
      position: tooltipPosition,
      builder: (context, void Function() onHide) {
        return Padding(
          padding: const EdgeInsets.all(GtbPaddingValue.xxs),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: items,
          ),
        );
      },
      child: GtbBadge(
        backgroundColor: backgroundColor ?? colorScheme.neutralExtended30,
        hasOutline: hasOutline,
        label: Text('+${items.length}'),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('collapsedItems', items));
  }
}
