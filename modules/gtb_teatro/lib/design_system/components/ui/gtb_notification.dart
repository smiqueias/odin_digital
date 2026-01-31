import 'package:flutter/material.dart';
import 'package:gtb_teatro/design_system/components/global/global_loader.dart';
import 'package:gtb_teatro/design_system/components/ui/gtb_icon_button.dart';
import 'package:gtb_teatro/design_system/components/ui/gtb_link.dart';
import 'package:gtb_teatro/design_system/components/ui/gtb_shimmer.dart';
import 'package:gtb_teatro/design_system/foundation/constants.dart';
import 'package:gtb_teatro/design_system/foundation/icons.dart';
import 'package:gtb_teatro/design_system/gtb_teatro.dart';
import 'package:gtb_teatro/design_system/models/action_settings.dart';

sealed class GtbNotificationKind {
  const GtbNotificationKind();

  const factory GtbNotificationKind.placeholder({
    required IconData icon,
    bool isEnabled,
  }) = GtbNotificationKindPlaceholder;

  const factory GtbNotificationKind.success() = GtbNotificationKindSuccess;

  const factory GtbNotificationKind.error() = GtbNotificationKindError;

  const factory GtbNotificationKind.warning() = GtbNotificationKindWarning;

  const factory GtbNotificationKind.info() = GtbNotificationKindInfo;

  const factory GtbNotificationKind.loader() = GtbNotificationKindLoader;
}

final class GtbNotificationKindPlaceholder extends GtbNotificationKind {
  const GtbNotificationKindPlaceholder({
    required this.icon,
    this.isEnabled = true,
  });

  final IconData icon;
  final bool isEnabled;
}

final class GtbNotificationKindSuccess extends GtbNotificationKind {
  const GtbNotificationKindSuccess();

  final IconData icon = GtbIcons.statusSuccess;
}

final class GtbNotificationKindError extends GtbNotificationKind {
  const GtbNotificationKindError();

  final IconData icon = GtbIcons.statusError;
}

final class GtbNotificationKindWarning extends GtbNotificationKind {
  const GtbNotificationKindWarning();

  final IconData icon = GtbIcons.statusWarning;
}

final class GtbNotificationKindInfo extends GtbNotificationKind {
  const GtbNotificationKindInfo();

  final IconData icon = GtbIcons.infoOn;
}

final class GtbNotificationKindLoader extends GtbNotificationKind {
  const GtbNotificationKindLoader();
}

class GtbNotificationInline extends StatelessWidget {
  const GtbNotificationInline({
    required this.kind,
    required this.title,
    super.key,
  });

  GtbNotificationInline.placeholder({
    required this.title,
    required IconData icon,
    super.key,
    bool isEnabled = true,
  }) : kind = GtbNotificationKind.placeholder(icon: icon, isEnabled: isEnabled);

  const GtbNotificationInline.success({
    required this.title,
    super.key,
  }) : kind = const GtbNotificationKind.success();

  const GtbNotificationInline.error({
    required this.title,
    super.key,
  }) : kind = const GtbNotificationKind.error();

  const GtbNotificationInline.warning({
    required this.title,
    super.key,
  }) : kind = const GtbNotificationKind.warning();

  const GtbNotificationInline.info({
    required this.title,
    super.key,
  }) : kind = const GtbNotificationKind.info();

  const GtbNotificationInline.loader({
    super.key,
    Widget? title,
  }) : kind = const GtbNotificationKind.loader(),
       title = title ?? const Text('Loren ipsum');

  final GtbNotificationKind kind;
  final Widget title;

  @override
  Widget build(BuildContext context) {
    final theme = GtbThemeProvider.of(context);
    final appColorScheme = theme.appColorScheme;

    final textColor = switch (kind) {
      GtbNotificationKindPlaceholder(isEnabled: false) => appColorScheme.onColorEmphasisDisabled,
      GtbNotificationKindPlaceholder(isEnabled: true) || //
      GtbNotificationKindSuccess() ||
      GtbNotificationKindError() ||
      GtbNotificationKindWarning() ||
      GtbNotificationKindInfo() ||
      GtbNotificationKindLoader() => appColorScheme.onColorEmphasisHigh,
    };

    final iconColor = switch (kind) {
      GtbNotificationKindPlaceholder(isEnabled: false) => appColorScheme.onColorEmphasisDisabled,
      GtbNotificationKindPlaceholder(isEnabled: true) => appColorScheme.onColorEmphasisHigh,
      GtbNotificationKindSuccess() => appColorScheme.statusSuccessBase,
      GtbNotificationKindError() => appColorScheme.statusErrorBase,
      GtbNotificationKindWarning() => appColorScheme.statusWarningBase,
      GtbNotificationKindInfo() => appColorScheme.statusInformativeBase,
      GtbNotificationKindLoader() => appColorScheme.onColorEmphasisHigh,
    };

    return GtbShimmer(
      isLoading: kind == const GtbNotificationKind.loader(),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          GtbShimmerCover(
            child: _NotificationIcon(
              kind: kind,
              color: iconColor,
            ),
          ),
          GtbGap.xxs,
          GtbShimmerCover(
            child: Flexible(
              child: DefaultTextStyle(
                style: theme.typography.bodySmall.copyWith(color: textColor),
                child: title,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class GtbNotificationFixed extends StatelessWidget {
  const GtbNotificationFixed({
    required this.kind,
    required this.paragraph,
    super.key,
    this.title,
    this.linkActionSettings,
    this.onPressClose,
  });

  GtbNotificationFixed.placeholder({
    required this.paragraph,
    required IconData icon,
    super.key,
    this.title,
    this.linkActionSettings,
    this.onPressClose,
    bool isEnabled = true,
  }) : kind = GtbNotificationKind.placeholder(icon: icon, isEnabled: isEnabled);

  const GtbNotificationFixed.success({
    required this.paragraph,
    super.key,
    this.title,
    this.linkActionSettings,
    this.onPressClose,
  }) : kind = const GtbNotificationKind.success();

  const GtbNotificationFixed.error({
    required this.paragraph,
    super.key,
    this.title,
    this.linkActionSettings,
    this.onPressClose,
  }) : kind = const GtbNotificationKind.error();

  const GtbNotificationFixed.warning({
    required this.paragraph,
    super.key,
    this.title,
    this.linkActionSettings,
    this.onPressClose,
  }) : kind = const GtbNotificationKind.warning();

  const GtbNotificationFixed.info({
    required this.paragraph,
    super.key,
    this.title,
    this.linkActionSettings,
    this.onPressClose,
  }) : kind = const GtbNotificationKind.info();

  const GtbNotificationFixed.loader({
    super.key,
    Widget? title,
    Widget? paragraph,
    this.linkActionSettings,
  }) : kind = const GtbNotificationKind.loader(),
       title = title ?? const Text('Loren ipsum'),
       paragraph = paragraph ?? const Text('Loren ipsum'),
       onPressClose = null;

  final GtbNotificationKind kind;
  final Widget? title;
  final Widget paragraph;
  final GtbActionSettings<VoidCallback>? linkActionSettings;
  final VoidCallback? onPressClose;

  @override
  Widget build(BuildContext context) {
    final theme = GtbThemeProvider.of(context);
    final title = this.title;

    return GtbShimmer(
      isLoading: kind == const GtbNotificationKind.loader(),
      child: GtbShimmerCover(
        child: _Notification(
          leading: _NotificationIcon(kind: kind),
          title: title == null
              ? null
              : DefaultTextStyle(
                  style: theme.typography.bodyBase.copyWith(
                    color: theme.appColorScheme.onColorEmphasisHigh,
                  ),
                  child: title,
                ),
          paragraph: DefaultTextStyle(
            style: theme.typography.bodySmall.copyWith(
              color: theme.appColorScheme.onColorEmphasisMedium,
            ),
            child: paragraph,
          ),
          backgroundColor: _getBackgroundColor(kind: kind, appColorScheme: theme.appColorScheme),
          hasCloseButton: onPressClose != null,
          hasShadow: false,
          linkActionSettings: linkActionSettings,
          onPressClose: onPressClose,
        ),
      ),
    );
  }
}

class GtbNotificationFloater extends StatelessWidget {
  const GtbNotificationFloater({
    required this.kind,
    required this.title,
    required this.paragraph,
    super.key,
    this.hasIcon = true,
    this.linkActionSettings,
    this.onPressClose,
  });

  GtbNotificationFloater.placeholder({
    required this.title,
    required this.paragraph,
    required IconData icon,
    super.key,
    this.hasIcon = true,
    this.linkActionSettings,
    this.onPressClose,
    bool isEnabled = true,
  }) : kind = GtbNotificationKind.placeholder(icon: icon, isEnabled: isEnabled);

  const GtbNotificationFloater.success({
    required this.title,
    required this.paragraph,
    super.key,
    this.hasIcon = true,
    this.linkActionSettings,
    this.onPressClose,
  }) : kind = const GtbNotificationKind.success();

  const GtbNotificationFloater.error({
    required this.title,
    required this.paragraph,
    super.key,
    this.hasIcon = true,
    this.linkActionSettings,
    this.onPressClose,
  }) : kind = const GtbNotificationKind.error();

  const GtbNotificationFloater.warning({
    required this.title,
    required this.paragraph,
    super.key,
    this.hasIcon = true,
    this.linkActionSettings,
    this.onPressClose,
  }) : kind = const GtbNotificationKind.warning();

  const GtbNotificationFloater.info({
    required this.title,
    required this.paragraph,
    super.key,
    this.hasIcon = true,
    this.linkActionSettings,
    this.onPressClose,
  }) : kind = const GtbNotificationKind.info();

  const GtbNotificationFloater.loader({
    required this.title,
    required this.paragraph,
    super.key,
    this.hasIcon = true,
    this.linkActionSettings,
    this.onPressClose,
  }) : kind = const GtbNotificationKind.loader();

  final GtbNotificationKind kind;
  final Widget title;
  final Widget? paragraph;
  final GtbActionSettings<VoidCallback>? linkActionSettings;
  final bool hasIcon;
  final VoidCallback? onPressClose;

  @override
  Widget build(BuildContext context) {
    final theme = GtbThemeProvider.of(context);
    final paragraph = this.paragraph;

    return _Notification(
      leading: hasIcon
          ? kind == const GtbNotificationKind.loader()
                ? const GtbGlobalLoaderSmall() //
                : _NotificationIcon(kind: kind)
          : null,
      title: DefaultTextStyle(
        style: theme.typography.bodySmall.copyWith(color: theme.appColorScheme.onColorEmphasisHigh),
        child: title,
      ),
      paragraph: paragraph == null
          ? null //
          : DefaultTextStyle(
              style: theme.typography.captionBase.copyWith(
                color: theme.appColorScheme.onColorEmphasisMedium,
              ),
              child: paragraph,
            ),
      backgroundColor: _getBackgroundColor(kind: kind, appColorScheme: theme.appColorScheme),
      hasCloseButton: true,
      hasShadow: true,
      linkActionSettings: linkActionSettings,
      onPressClose: onPressClose,
    );
  }
}

class _NotificationIcon extends StatelessWidget {
  const _NotificationIcon({
    required this.kind,
    this.color,
  });

  final GtbNotificationKind kind;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final theme = GtbThemeProvider.of(context);

    return Padding(
      padding: const EdgeInsets.only(
        top: GtbPaddingValue.xxxs,
        right: GtbPaddingValue.xxxs,
      ),
      child: Icon(
        _getDefaultIcon(kind),
        color: color ?? _getDefaultIconColor(kind, theme.appColorScheme),
        size: 16.0,
      ),
    );
  }

  IconData _getDefaultIcon(GtbNotificationKind kind) {
    return switch (kind) {
      GtbNotificationKindPlaceholder(:final icon) => icon,
      GtbNotificationKindSuccess() => GtbIcons.statusSuccess,
      GtbNotificationKindError() => GtbIcons.statusError,
      GtbNotificationKindWarning() => GtbIcons.statusWarning,
      GtbNotificationKindInfo() => GtbIcons.infoOn,
      GtbNotificationKindLoader() => GtbIcons.empty,
    };
  }

  Color _getDefaultIconColor(GtbNotificationKind kind, GtbColorScheme appColorScheme) {
    return switch (kind) {
      GtbNotificationKindPlaceholder() => appColorScheme.onColorEmphasisHigh,
      GtbNotificationKindSuccess() => appColorScheme.statusSuccessBase,
      GtbNotificationKindError() => appColorScheme.statusErrorBase,
      GtbNotificationKindWarning() => appColorScheme.statusWarningBase,
      GtbNotificationKindInfo() => appColorScheme.statusInformativeBase,
      GtbNotificationKindLoader() => appColorScheme.onColorEmphasisHigh,
    };
  }
}

class _Notification extends StatelessWidget {
  const _Notification({
    required this.leading,
    required this.title,
    required this.paragraph,
    required this.backgroundColor,
    required this.hasCloseButton,
    required this.hasShadow,
    required this.linkActionSettings,
    required this.onPressClose,
  });

  final Widget? leading;
  final Widget? title;
  final Widget? paragraph;
  final Color backgroundColor;
  final bool hasCloseButton;
  final bool hasShadow;
  final GtbActionSettings<VoidCallback>? linkActionSettings;
  final VoidCallback? onPressClose;

  @override
  Widget build(BuildContext context) {
    final theme = GtbThemeProvider.of(context);

    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border.all(
          color: theme.appColorScheme.outlineBase,
          width: 1.0,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(
            4.0,
          ),
        ),
        boxShadow: hasShadow ? theme.appColorScheme.elevationHigh : null,
        color: backgroundColor,
      ),
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          Padding(
            padding: const EdgeInsets.all(GtbPaddingValue.sm),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (leading case final leading?) ...[
                  leading,
                  GtbGap.xs,
                ],
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (title case final title?) title,
                      if (title != null && paragraph != null) //
                        GtbGap.xxs,
                      if (paragraph case final paragraph?) paragraph,
                      if ((title != null || paragraph != null) && linkActionSettings != null) //
                        GtbGap.xs,
                      if (linkActionSettings case final linkActionSettings?)
                        GtbLink.fromActionSettings(
                          actionSettings: linkActionSettings.copyWith(
                            rightIcon: GtbIcons.chevronRight,
                          ),
                          size: GtbLinkSize.small,
                        ),
                    ],
                  ),
                ),
                if (hasCloseButton) //
                  GtbGap.md,
              ],
            ),
          ),
          if (hasCloseButton)
            Material(
              color: kTransparentColor,
              child: Padding(
                padding:
                    const EdgeInsets.all(GtbPaddingValue.sm) -
                    const EdgeInsets.all(kIconButtonExtraSpacing),
                child: GtbIconButton(
                  icon: const Icon(GtbIcons.close),
                  onPress: onPressClose,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

Color _getBackgroundColor({
  required GtbNotificationKind kind,
  required GtbColorScheme appColorScheme,
}) {
  return switch (kind) {
    GtbNotificationKindPlaceholder() => appColorScheme.neutralBase,
    GtbNotificationKindSuccess() => appColorScheme.statusSuccessBaseSurface,
    GtbNotificationKindError() => appColorScheme.statusErrorBaseSurface,
    GtbNotificationKindWarning() => appColorScheme.statusWarningBaseSurface,
    GtbNotificationKindInfo() => appColorScheme.statusInformativeBaseSurface,
    GtbNotificationKindLoader() => appColorScheme.neutralBase,
  };
}
