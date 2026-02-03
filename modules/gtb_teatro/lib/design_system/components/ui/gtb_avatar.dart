import 'package:flutter/widgets.dart';
import 'package:gtb_teatro/design_system/gtb_teatro.dart';

enum GtbAvatarSize {
  size24(24.0),
  size32(32.0),
  size40(40.0),
  size48(48.0),
  size64(64.0),
  size80(80.0),
  size112(112.0)
  ;

  const GtbAvatarSize(this.value);

  final double value;
}

sealed class GtbAvatarWidget extends StatelessWidget {
  const GtbAvatarWidget({super.key});
}

class GtbAvatar extends GtbAvatarWidget {
  const GtbAvatar({
    super.key,
    this.size,
    this.hasOutline,
    this.image,
    this.initials,
    this.notificationBadge,
    this.statusBadge,
  });

  final GtbAvatarSize? size;
  final bool? hasOutline;
  final Widget? image;
  final Widget? initials;
  final GtbGlobalNotificationBadge? notificationBadge;
  final GtbGlobalStatusBadge? statusBadge;

  @override
  Widget build(BuildContext context) {
    final theme = GtbAvatarTheme.of(context);

    final size = this.size ?? theme.size;
    final hasOutline = this.hasOutline ?? theme.hasOutline;

    final radius = size.value / 2;

    final resolvedNotificationBadge = notificationBadge != null && size.value <= GtbAvatarSize.size32.value
        ? const GtbGlobalNotificationBadge.bullet() //
        : notificationBadge;

    return FittedBox(
      fit: BoxFit.scaleDown,
      child: DecoratedBox(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: theme.backgroundColor,
          border: hasOutline
              ? GtbBorder.all(
                  color: theme.borderColor,
                  stroke: theme.borderWidth,
                )
              : null,
        ),
        child: SizedBox.square(
          dimension: size.value,
          child: Stack(
            children: [
              if (image case final image?)
                ClipOval(
                  child: SizedBox.square(
                    dimension: size.value,
                    child: image,
                  ),
                )
              else
                Center(
                  child: DefaultTextStyle(
                    style: theme.textStyleBySize[size]!,
                    child: initials ?? const Text(''),
                  ),
                ),
              if (resolvedNotificationBadge case final notificationBadge?)
                Align(
                  alignment: FractionalOffset.fromOffsetAndSize(
                    circleOffset(radius: radius, angle: 140.0) + const Offset(8.0, 0.0),
                    Size.square(size.value),
                  ),
                  child: notificationBadge,
                ),
              if (statusBadge case final statusBadge?)
                Align(
                  alignment: FractionalOffset.fromOffsetAndSize(
                    circleOffset(radius: radius, angle: 40.0) + const Offset(8.0, 0.0),
                    Size.square(size.value),
                  ),
                  child: statusBadge,
                ),
            ],
          ),
        ),
      ),
    );
  }

  static String initialsFrom(String personName) {
    final name = personName.trim().toUpperCase();

    if (name.isEmpty) {
      return '';
    } else {
      final names = name.split(' ');

      if (names.length > 1) {
        final lastName = names[names.length - 1];
        return '${name[0]}${lastName[0]}';
      } else {
        return name[0];
      }
    }
  }
}

final class GtbAvatarShimmer extends GtbAvatarWidget {
  const GtbAvatarShimmer({
    super.key,
    this.size,
  });

  final GtbAvatarSize? size;

  @override
  Widget build(BuildContext context) {
    final size = this.size ?? GtbAvatarTheme.of(context).size;

    return GtbShimmer(
      child: GtbShimmerCover(
        borderRadius: size.value / 2.0,
        child: SizedBox.square(dimension: size.value),
      ),
    );
  }
}

final class GtbAvatarTheme extends InheritedTheme {
  const GtbAvatarTheme({
    required super.child,
    required this.data,
    super.key,
  });

  final GtbAvatarThemeData data;

  static GtbAvatarThemeData of(BuildContext context) {
    final theme = context.dependOnInheritedWidgetOfExactType<GtbAvatarTheme>();
    return theme?.data ?? GtbThemeProvider.of(context).avatarTheme;
  }

  @override
  bool updateShouldNotify(GtbAvatarTheme oldWidget) {
    return oldWidget.data != data;
  }

  @override
  Widget wrap(BuildContext context, Widget child) {
    return GtbAvatarTheme(
      data: data,
      child: child,
    );
  }
}

final class GtbAvatarThemeData {
  GtbAvatarThemeData({
    required this.size,
    required this.backgroundColor,
    required this.borderColor,
    required this.borderWidth,
    required this.hasOutline,
    required this.textStyleBySize,
  });

  final GtbAvatarSize size;
  final Color backgroundColor;
  final Color borderColor;
  final double borderWidth;
  final bool hasOutline;
  final Map<GtbAvatarSize, TextStyle?> textStyleBySize;

  static GtbAvatarThemeData lerp(
    GtbAvatarThemeData a,
    GtbAvatarThemeData b,
    double t,
  ) {
    return GtbAvatarThemeData(
      size: t < 0.5 ? a.size : b.size,
      backgroundColor: Color.lerp(a.backgroundColor, b.backgroundColor, t)!,
      borderColor: Color.lerp(a.borderColor, b.borderColor, t)!,
      borderWidth: lerpDouble(a.borderWidth, b.borderWidth, t),
      hasOutline: t < 0.5 ? a.hasOutline : b.hasOutline,
      textStyleBySize: {
        GtbAvatarSize.size24: TextStyle.lerp(
          a.textStyleBySize[GtbAvatarSize.size24],
          b.textStyleBySize[GtbAvatarSize.size24],
          t,
        ),
        GtbAvatarSize.size32: TextStyle.lerp(
          a.textStyleBySize[GtbAvatarSize.size32],
          b.textStyleBySize[GtbAvatarSize.size32],
          t,
        ),
        GtbAvatarSize.size40: TextStyle.lerp(
          a.textStyleBySize[GtbAvatarSize.size40],
          b.textStyleBySize[GtbAvatarSize.size40],
          t,
        ),
        GtbAvatarSize.size48: TextStyle.lerp(
          a.textStyleBySize[GtbAvatarSize.size48],
          b.textStyleBySize[GtbAvatarSize.size48],
          t,
        ),
        GtbAvatarSize.size64: TextStyle.lerp(
          a.textStyleBySize[GtbAvatarSize.size64],
          b.textStyleBySize[GtbAvatarSize.size64],
          t,
        ),
        GtbAvatarSize.size80: TextStyle.lerp(
          a.textStyleBySize[GtbAvatarSize.size80],
          b.textStyleBySize[GtbAvatarSize.size80],
          t,
        ),
        GtbAvatarSize.size112: TextStyle.lerp(
          a.textStyleBySize[GtbAvatarSize.size112],
          b.textStyleBySize[GtbAvatarSize.size112],
          t,
        ),
      },
    );
  }

  GtbAvatarThemeData copyWith({
    GtbAvatarSize? size,
    Color? backgroundColor,
    Color? borderColor,
    double? borderWidth,
    bool? hasOutline,
    Map<GtbAvatarSize, TextStyle?>? textStyleBySize,
  }) {
    return GtbAvatarThemeData(
      size: size ?? this.size,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      borderColor: borderColor ?? this.borderColor,
      borderWidth: borderWidth ?? this.borderWidth,
      hasOutline: hasOutline ?? this.hasOutline,
      textStyleBySize: textStyleBySize ?? this.textStyleBySize,
    );
  }
}

GtbAvatarThemeData createDefaultAvatarTheme({
  required GtbColorScheme colorScheme,
  required GtbBorderThemeData borderTheme,
  required GtbTypography typography,
}) {
  return GtbAvatarThemeData(
    size: GtbAvatarSize.size32,
    backgroundColor: colorScheme.neutralExtended30,
    borderColor: colorScheme.outlineBase,
    borderWidth: borderTheme.strokeThin,
    hasOutline: true,
    textStyleBySize: {
      GtbAvatarSize.size24: typography.labelMicro.copyWith(color: colorScheme.onColorEmphasisHigh),
      GtbAvatarSize.size32: typography.labelSmall.copyWith(color: colorScheme.onColorEmphasisHigh),
      GtbAvatarSize.size40: typography.labelSmall.copyWith(color: colorScheme.onColorEmphasisHigh),
      GtbAvatarSize.size48: typography.labelSmall.copyWith(color: colorScheme.onColorEmphasisHigh),
      GtbAvatarSize.size64: typography.titleSmall.copyWith(color: colorScheme.onColorEmphasisHigh),
      GtbAvatarSize.size80: typography.titleSmall.copyWith(color: colorScheme.onColorEmphasisHigh),
      GtbAvatarSize.size112: typography.titleSmall.copyWith(color: colorScheme.onColorEmphasisHigh),
    },
  );
}
