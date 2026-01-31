import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:gtb_teatro/design_system/components/feedback/ink_well.dart';
import 'package:gtb_teatro/design_system/components/global/global_notification_badge.dart';
import 'package:gtb_teatro/design_system/components/ui/gtb_border.dart';
import 'package:gtb_teatro/design_system/components/ui/gtb_shimmer.dart';
import 'package:gtb_teatro/design_system/foundation/icons.dart';
import 'package:gtb_teatro/design_system/foundation/lerp.dart';
import 'package:gtb_teatro/design_system/gtb_teatro.dart';

enum GtbIconContainerSize {
  size16(16.0),
  size24(24.0),
  size32(32.0),
  size40(40.0),
  size48(48.0),
  size64(64.0),
  size72(72.0),
  size80(80.0),
  size96(96.0),
  size112(112.0),
  size128(128.0)
  ;

  const GtbIconContainerSize(this.value);

  static GtbIconContainerSize? lerp(GtbIconContainerSize? a, GtbIconContainerSize? b, double t) {
    return lerpEnum(values, a, b, t);
  }

  final double value;
}

final class GtbIconContainer extends StatelessWidget {
  const GtbIconContainer({
    required this.icon,
    super.key,
    this.size,
    this.color,
    this.hasNotification = false,
    this.isLoading = false,
    this.onPress,
  });

  final IconData icon;
  final GtbIconContainerSize? size;
  final Color? color;
  final bool hasNotification;
  final bool isLoading;
  final VoidCallback? onPress;

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      final size = this.size ?? GtbIconContainerSize.size24;

      return GtbShimmer(
        child: GtbShimmerCover(
          child: SizedBox(
            width: size.value,
            height: size.value,
          ),
        ),
      );
    } else {
      return GtbInkWell.outsideResponse(
        onTap: onPress,
        child: _IconContainer(
          icon: icon,
          size: size,
          color: color,
          notificationBadge: hasNotification
              ? const GtbGlobalNotificationBadge.bullet() //
              : null,
        ),
      );
    }
  }
}

final class GtbIconContainerNotification extends GtbIconContainer {
  const GtbIconContainerNotification({
    required super.icon,
    super.key,
    super.size,
    super.color,
  }) : super(hasNotification: true);
}

final class GtbIconContainerShimmer extends GtbIconContainer {
  const GtbIconContainerShimmer({
    super.key,
    super.size,
  }) : super(
         icon: GtbIcons.agro,
         isLoading: true,
       );
}

final class _IconContainer extends StatelessWidget {
  const _IconContainer({
    required this.icon,
    this.size,
    this.notificationBadge,
    this.color,
  });

  final IconData icon;
  final GtbIconContainerSize? size;
  final GtbGlobalNotificationBadge? notificationBadge;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final theme = GtbIconContainerTheme.of(context);

    final child = Icon(
      icon,
      size: size?.value ?? theme.size.value,
      color: color ?? theme.foregroundColor,
      applyTextScaling: theme.applyTextScaling,
    );

    if (notificationBadge case final notificationBadge?) {
      return Stack(
        alignment: Alignment.topRight,
        children: [
          child,
          notificationBadge,
        ],
      );
    } else {
      return child;
    }
  }
}

enum GtbIconContainerCircleSize {
  size24(24.0, GtbIconContainerSize.size16),
  size32(32.0, GtbIconContainerSize.size16),
  size40(40.0, GtbIconContainerSize.size24),
  size48(48.0, GtbIconContainerSize.size32),
  size64(64.0, GtbIconContainerSize.size40),
  size72(72.0, GtbIconContainerSize.size40),
  size80(80.0, GtbIconContainerSize.size48),
  size96(96.0, GtbIconContainerSize.size64),
  size112(112.0, GtbIconContainerSize.size64),
  size128(128.0, GtbIconContainerSize.size72)
  ;

  const GtbIconContainerCircleSize(
    this.size,
    this.iconSize,
  );

  final double size;
  final GtbIconContainerSize iconSize;
}

final class GtbIconContainerCircle extends StatelessWidget {
  const GtbIconContainerCircle({
    required this.icon,
    super.key,
    this.size,
    this.notificationBadge,
    this.foregroundColor,
    this.backgroundColor,
    this.hasOutline,
    this.isLoading = false,
    this.onPress,
  });

  final IconData icon;
  final GtbIconContainerCircleSize? size;
  final GtbGlobalNotificationBadge? notificationBadge;
  final Color? foregroundColor;
  final Color? backgroundColor;
  final bool? hasOutline;
  final bool isLoading;
  final VoidCallback? onPress;

  @override
  Widget build(BuildContext context) {
    return GtbInkWell(
      onTap: onPress,
      child: _IconContainerCircle(
        icon: icon,
        size: size,
        notificationBadge: notificationBadge,
        foregroundColor: foregroundColor,
        backgroundColor: backgroundColor,
        hasOutline: hasOutline,
        isLoading: isLoading,
      ),
    );
  }
}

final class GtbIconContainerCircleNotification extends GtbIconContainerCircle {
  const GtbIconContainerCircleNotification({
    required super.icon,
    required GtbGlobalNotificationBadge super.notificationBadge,
    super.key,
    super.size,
    super.foregroundColor,
    super.backgroundColor,
    super.hasOutline,
  });
}

final class GtbIconContainerCircleShimmer extends GtbIconContainerCircle {
  const GtbIconContainerCircleShimmer({
    super.key,
    super.size,
  }) : super(
         icon: GtbIcons.empty,
         isLoading: true,
       );
}

final class _IconContainerCircle extends StatelessWidget {
  const _IconContainerCircle({
    required this.icon,
    required this.isLoading,
    this.size,
    this.foregroundColor,
    this.backgroundColor,
    this.hasOutline,
    this.notificationBadge,
  });

  final IconData icon;
  final GtbIconContainerCircleSize? size;
  final Color? foregroundColor;
  final Color? backgroundColor;
  final bool? hasOutline;
  final bool isLoading;
  final GtbGlobalNotificationBadge? notificationBadge;

  @override
  Widget build(BuildContext context) {
    final theme = GtbIconContainerTheme.of(context);
    final size = this.size ?? theme.circleSize;
    final position = size.size / 2.0 + size.size * sqrt1_2 / 2.0;
    final hasOutline = this.hasOutline ?? theme.hasOutline;

    if (isLoading) {
      return GtbShimmer(
        child: GtbShimmerCover(
          borderRadius: size.size,
          child: SizedBox(
            width: size.size,
            height: size.size,
          ),
        ),
      );
    } else {
      final resolvedNotificationBadge = switch ((notificationBadge, size)) {
        (null, _) => null,
        (_?, GtbIconContainerCircleSize.size24) => const GtbGlobalNotificationBadge.bullet(),
        (_?, GtbIconContainerCircleSize.size32) => const GtbGlobalNotificationBadge.bullet(),
        (_?, _) => notificationBadge,
      };

      final child = Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: backgroundColor ?? theme.backgroundColor,
          border: hasOutline
              ? GtbBorder.all(
                  color: theme.borderColor,
                  stroke: theme.borderWidth,
                )
              : null,
        ),
        width: size.size,
        height: size.size,
        child: _IconContainer(
          icon: icon,
          size: size.iconSize,
          color: foregroundColor,
        ),
      );

      if (resolvedNotificationBadge case final resolvedNotificationBadge?) {
        return Stack(
          clipBehavior: Clip.none,
          children: [
            child,
            Positioned(
              left: position,
              bottom: position,
              child: FractionalTranslation(
                translation: const Offset(-0.5, 0.5),
                child: resolvedNotificationBadge,
              ),
            ),
          ],
        );
      } else {
        return child;
      }
    }
  }
}

class GtbIconContainerTheme extends StatefulWidget {
  const GtbIconContainerTheme({
    required this.child,
    required this.data,
    super.key,
  });

  final Widget child;
  final GtbIconContainerThemeData data;

  static GtbIconContainerThemeData of(BuildContext context) {
    final theme = context.dependOnInheritedWidgetOfExactType<GtbIconContainerThemeScope>();
    return theme?.data ?? GtbThemeProvider.of(context).iconContainerTheme;
  }

  @override
  State<GtbIconContainerTheme> createState() => _GtbIconContainerThemeState();
}

class _GtbIconContainerThemeState extends State<GtbIconContainerTheme> {
  @override
  Widget build(BuildContext context) {
    return GtbIconContainerThemeScope(
      data: widget.data,
      child: IconTheme(
        data: IconTheme.of(context).copyWith(
          color: widget.data.foregroundColor,
          size: widget.data.size.value,
          applyTextScaling: true,
        ),
        child: widget.child,
      ),
    );
  }
}

final class GtbIconContainerThemeScope extends InheritedTheme {
  const GtbIconContainerThemeScope({
    required this.data,
    required super.child,
    super.key,
  });

  final GtbIconContainerThemeData data;

  @override
  bool updateShouldNotify(GtbIconContainerThemeScope oldWidget) {
    return oldWidget.data != data;
  }

  @override
  Widget wrap(BuildContext context, Widget child) {
    return GtbIconContainerTheme(
      data: data,
      child: child,
    );
  }
}

final class GtbIconContainerThemeData {
  GtbIconContainerThemeData({
    required this.size,
    required this.circleSize,
    required this.foregroundColor,
    required this.backgroundColor,
    required this.borderColor,
    required this.borderWidth,
    required this.hasOutline,
    required this.applyTextScaling,
  });

  final GtbIconContainerSize size;
  final GtbIconContainerCircleSize circleSize;
  final Color foregroundColor;
  final Color backgroundColor;
  final Color borderColor;
  final double borderWidth;
  final bool hasOutline;
  final bool applyTextScaling;

  static GtbIconContainerThemeData lerp(
    GtbIconContainerThemeData a,
    GtbIconContainerThemeData b,
    double t,
  ) {
    return GtbIconContainerThemeData(
      size: t < 0.5 ? a.size : b.size,
      circleSize: t < 0.5 ? a.circleSize : b.circleSize,
      foregroundColor: Color.lerp(a.foregroundColor, b.foregroundColor, t)!,
      backgroundColor: Color.lerp(a.backgroundColor, b.backgroundColor, t)!,
      borderColor: Color.lerp(a.borderColor, b.borderColor, t)!,
      borderWidth: lerpDouble(a.borderWidth, b.borderWidth, t),
      hasOutline: lerpBool(a.hasOutline, b.hasOutline, t),
      applyTextScaling: lerpBool(a.applyTextScaling, b.applyTextScaling, t),
    );
  }

  GtbIconContainerThemeData copyWith({
    GtbIconContainerSize? size,
    GtbIconContainerCircleSize? circleSize,
    Color? foregroundColor,
    Color? backgroundColor,
    Color? borderColor,
    double? borderWidth,
    bool? hasOutline,
    bool? applyTextScaling,
  }) {
    return GtbIconContainerThemeData(
      size: size ?? this.size,
      circleSize: circleSize ?? this.circleSize,
      foregroundColor: foregroundColor ?? this.foregroundColor,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      borderColor: borderColor ?? this.borderColor,
      borderWidth: borderWidth ?? this.borderWidth,
      hasOutline: hasOutline ?? this.hasOutline,
      applyTextScaling: applyTextScaling ?? this.applyTextScaling,
    );
  }
}

GtbIconContainerThemeData createDefaultIconContainerTheme({
  required GtbColorScheme colorScheme,
  required GtbBorderThemeData borderTheme,
  required GtbTypography typography,
}) {
  return GtbIconContainerThemeData(
    size: GtbIconContainerSize.size24,
    circleSize: GtbIconContainerCircleSize.size24,
    foregroundColor: colorScheme.onColorEmphasisHigh,
    backgroundColor: colorScheme.neutralExtended30,
    borderColor: colorScheme.outlineBase,
    borderWidth: borderTheme.strokeThin,
    hasOutline: true,
    applyTextScaling: true,
  );
}
