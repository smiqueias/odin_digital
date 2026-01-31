import 'package:flutter/widgets.dart';
import 'package:gtb_teatro/design_system/gtb_teatro.dart';

enum GtbImageGroupSize {
  small(40.0),
  medium(48.0),
  large(64.0)
  ;

  const GtbImageGroupSize(this.value);

  final double value;
}

const _fixedGtbImageContainerSize = GtbImageContainerSize.size24;
const _fixedGtbIconContainerCircleSize = GtbIconContainerCircleSize.size24;
const _fixedGtbAvatarSize = GtbAvatarSize.size24;

sealed class GtbImageGroupKind {
  const GtbImageGroupKind();

  const factory GtbImageGroupKind.iconIcon({
    required GtbIconContainerCircle primaryIcon,
    required GtbIconContainerCircle secondaryIcon,
  }) = GtbImageGroupKindIconIcon;

  const factory GtbImageGroupKind.iconImage({
    required GtbIconContainerCircle icon,
    required GtbImageContainer image,
  }) = GtbImageGroupKindIconImage;

  const factory GtbImageGroupKind.iconAvatar({
    required GtbIconContainerCircle icon,
    required GtbAvatar avatar,
  }) = GtbImageGroupKindIconAvatar;

  const factory GtbImageGroupKind.imageImage({
    required GtbImageContainer primaryImage,
    required GtbImageContainer secondaryImage,
  }) = GtbImageGroupKindImageImage;

  const factory GtbImageGroupKind.imageIcon({
    required GtbImageContainer image,
    required GtbIconContainerCircle icon,
  }) = GtbImageGroupKindImageIcon;

  const factory GtbImageGroupKind.imageAvatar({
    required GtbImageContainer image,
    required GtbAvatar avatar,
  }) = GtbImageGroupKindImageAvatar;

  const factory GtbImageGroupKind.avatarAvatar({
    required GtbAvatar primaryAvatar,
    required GtbAvatar secondaryAvatar,
  }) = GtbImageGroupKindAvatarAvatar;

  const factory GtbImageGroupKind.avatarIcon({
    required GtbAvatar avatar,
    required GtbIconContainerCircle icon,
  }) = GtbImageGroupKindAvatarIcon;

  const factory GtbImageGroupKind.avatarImage({
    required GtbAvatar avatar,
    required GtbImageContainer image,
  }) = GtbImageGroupKindAvatarImage;
}

final class GtbImageGroupKindIconIcon extends GtbImageGroupKind {
  const GtbImageGroupKindIconIcon({required this.primaryIcon, required this.secondaryIcon});

  final GtbIconContainerCircle primaryIcon;
  final GtbIconContainerCircle secondaryIcon;
}

final class GtbImageGroupKindIconImage extends GtbImageGroupKind {
  const GtbImageGroupKindIconImage({required this.icon, required this.image});

  final GtbIconContainerCircle icon;
  final GtbImageContainer image;
}

final class GtbImageGroupKindIconAvatar extends GtbImageGroupKind {
  const GtbImageGroupKindIconAvatar({required this.icon, required this.avatar});

  final GtbIconContainerCircle icon;
  final GtbAvatar avatar;
}

final class GtbImageGroupKindImageImage extends GtbImageGroupKind {
  const GtbImageGroupKindImageImage({required this.primaryImage, required this.secondaryImage});

  final GtbImageContainer primaryImage;
  final GtbImageContainer secondaryImage;
}

final class GtbImageGroupKindImageIcon extends GtbImageGroupKind {
  const GtbImageGroupKindImageIcon({required this.image, required this.icon});

  final GtbImageContainer image;
  final GtbIconContainerCircle icon;
}

final class GtbImageGroupKindAvatarIcon extends GtbImageGroupKind {
  const GtbImageGroupKindAvatarIcon({required this.avatar, required this.icon});

  final GtbAvatar avatar;
  final GtbIconContainerCircle icon;
}

final class GtbImageGroupKindImageAvatar extends GtbImageGroupKind {
  const GtbImageGroupKindImageAvatar({required this.image, required this.avatar});

  final GtbImageContainer image;
  final GtbAvatar avatar;
}

final class GtbImageGroupKindAvatarAvatar extends GtbImageGroupKind {
  const GtbImageGroupKindAvatarAvatar({required this.primaryAvatar, required this.secondaryAvatar});

  final GtbAvatar primaryAvatar;
  final GtbAvatar secondaryAvatar;
}

final class GtbImageGroupKindAvatarImage extends GtbImageGroupKind {
  const GtbImageGroupKindAvatarImage({required this.avatar, required this.image});

  final GtbAvatar avatar;
  final GtbImageContainer image;
}

class GtbImageGroup extends StatelessWidget {
  const GtbImageGroup({
    required this.kind,
    super.key,
    this.size,
  });

  final GtbImageGroupSize? size;
  final GtbImageGroupKind kind;

  @override
  Widget build(BuildContext context) {
    final theme = GtbThemeProvider.of(context);

    final size = this.size ?? GtbImageGroupTheme.of(context).size;

    final resolvedIconSize = switch (size) {
      GtbImageGroupSize.small => GtbIconContainerCircleSize.size32,
      GtbImageGroupSize.medium => GtbIconContainerCircleSize.size40,
      GtbImageGroupSize.large => GtbIconContainerCircleSize.size64,
    };

    final resolvedImageSize = switch (size) {
      GtbImageGroupSize.small => GtbImageContainerSize.size32,
      GtbImageGroupSize.medium => GtbImageContainerSize.size40,
      GtbImageGroupSize.large => GtbImageContainerSize.size64,
    };

    final resolvedAvatarSize = switch (size) {
      GtbImageGroupSize.small => GtbAvatarSize.size32,
      GtbImageGroupSize.medium => GtbAvatarSize.size40,
      GtbImageGroupSize.large => GtbAvatarSize.size64,
    };

    final (primaryWidget, secondaryWidget) = switch (kind) {
      GtbImageGroupKindIconIcon(:final primaryIcon, :final secondaryIcon) => (
        GtbIconContainerTheme(
          data: GtbIconContainerTheme.of(context).copyWith(
            circleSize: resolvedIconSize,
          ),
          child: primaryIcon,
        ),
        GtbIconContainerTheme(
          data: GtbIconContainerTheme.of(context).copyWith(
            circleSize: _fixedGtbIconContainerCircleSize,
          ),
          child: secondaryIcon,
        ),
      ),
      GtbImageGroupKindIconImage(:final icon, :final image) => (
        GtbIconContainerTheme(
          data: GtbIconContainerTheme.of(context).copyWith(
            circleSize: resolvedIconSize,
          ),
          child: icon,
        ),
        GtbImageContainerTheme(
          data: GtbImageContainerTheme.of(context).copyWith(
            size: _fixedGtbImageContainerSize,
            shape: GtbImageContainerShape.rounded,
          ),
          child: image,
        ),
      ),
      GtbImageGroupKindIconAvatar(:final icon, :final avatar) => (
        GtbIconContainerTheme(
          data: GtbIconContainerTheme.of(context).copyWith(
            circleSize: resolvedIconSize,
          ),
          child: icon,
        ),
        GtbAvatarTheme(
          data: GtbAvatarTheme.of(context).copyWith(
            size: _fixedGtbAvatarSize,
          ),
          child: avatar,
        ),
      ),
      GtbImageGroupKindImageImage(:final primaryImage, :final secondaryImage) => (
        GtbImageContainerTheme(
          data: GtbImageContainerTheme.of(context).copyWith(
            size: resolvedImageSize,
            shape: GtbImageContainerShape.rounded,
          ),
          child: primaryImage,
        ),
        GtbImageContainerTheme(
          data: GtbImageContainerTheme.of(context).copyWith(
            size: _fixedGtbImageContainerSize,
            shape: GtbImageContainerShape.rounded,
          ),
          child: secondaryImage,
        ),
      ),
      GtbImageGroupKindImageIcon(:final image, :final icon) => (
        GtbImageContainerTheme(
          data: GtbImageContainerTheme.of(context).copyWith(
            size: resolvedImageSize,
            shape: GtbImageContainerShape.rounded,
          ),
          child: image,
        ),
        GtbIconContainerTheme(
          data: GtbIconContainerTheme.of(context).copyWith(
            circleSize: _fixedGtbIconContainerCircleSize,
          ),
          child: icon,
        ),
      ),
      GtbImageGroupKindImageAvatar(:final image, :final avatar) => (
        GtbImageContainerTheme(
          data: GtbImageContainerTheme.of(context).copyWith(
            size: resolvedImageSize,
            shape: GtbImageContainerShape.rounded,
          ),
          child: image,
        ),
        GtbAvatarTheme(
          data: GtbAvatarTheme.of(context).copyWith(
            size: _fixedGtbAvatarSize,
          ),
          child: avatar,
        ),
      ),
      GtbImageGroupKindAvatarAvatar(:final primaryAvatar, :final secondaryAvatar) => (
        GtbAvatarTheme(
          data: GtbAvatarTheme.of(context).copyWith(
            size: resolvedAvatarSize,
          ),
          child: primaryAvatar,
        ),
        GtbAvatarTheme(
          data: GtbAvatarTheme.of(context).copyWith(
            size: _fixedGtbAvatarSize,
          ),
          child: secondaryAvatar,
        ),
      ),
      GtbImageGroupKindAvatarIcon(:final avatar, :final icon) => (
        GtbAvatarTheme(
          data: GtbAvatarTheme.of(context).copyWith(
            size: resolvedAvatarSize,
          ),
          child: avatar,
        ),
        GtbIconContainerTheme(
          data: GtbIconContainerTheme.of(context).copyWith(
            circleSize: _fixedGtbIconContainerCircleSize,
          ),
          child: icon,
        ),
      ),
      GtbImageGroupKindAvatarImage(:final avatar, :final image) => (
        GtbAvatarTheme(
          data: GtbAvatarTheme.of(context).copyWith(
            size: resolvedAvatarSize,
          ),
          child: avatar,
        ),
        GtbImageContainerTheme(
          data: GtbImageContainerTheme.of(context).copyWith(
            size: _fixedGtbImageContainerSize,
            shape: GtbImageContainerShape.rounded,
          ),
          child: image,
        ),
      ),
    };

    return SizedBox.fromSize(
      size: Size.square(size.value),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: theme.appColorScheme.neutralBase,
                border: GtbBorder.all(
                  color: theme.appColorScheme.outlineBase,
                  stroke: theme.borderTheme.strokeThin,
                ),
                shape: BoxShape.circle,
              ),
              child: primaryWidget,
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: theme.appColorScheme.neutralBase,
                border: GtbBorder.all(
                  color: theme.appColorScheme.outlineBase,
                  stroke: theme.borderTheme.strokeThin,
                ),
                shape: BoxShape.circle,
              ),
              child: secondaryWidget,
            ),
          ),
        ],
      ),
    );
  }
}

final class GtbImageGroupTheme extends InheritedTheme {
  const GtbImageGroupTheme({
    required super.child,
    required this.data,
    super.key,
  });

  final GtbImageGroupThemeData data;

  static GtbImageGroupThemeData of(BuildContext context) {
    final theme = context.dependOnInheritedWidgetOfExactType<GtbImageGroupTheme>();
    return theme?.data ?? GtbThemeProvider.of(context).imageGroupTheme;
  }

  @override
  bool updateShouldNotify(GtbImageGroupTheme oldWidget) {
    return oldWidget.data != data;
  }

  @override
  Widget wrap(BuildContext context, Widget child) {
    return GtbImageGroupTheme(
      data: data,
      child: child,
    );
  }
}

final class GtbImageGroupThemeData {
  GtbImageGroupThemeData({
    required this.size,
  });

  final GtbImageGroupSize size;

  static GtbImageGroupThemeData lerp(
    GtbImageGroupThemeData a,
    GtbImageGroupThemeData b,
    double t,
  ) {
    return GtbImageGroupThemeData(
      size: t < 0.5 ? a.size : b.size,
    );
  }

  GtbImageGroupThemeData copyWith({
    GtbImageGroupSize? size,
  }) {
    return GtbImageGroupThemeData(
      size: size ?? this.size,
    );
  }
}

GtbImageGroupThemeData createDefaultImageGroupTheme({
  required GtbColorScheme colorScheme,
  required GtbBorderThemeData borderTheme,
  required GtbTypography typography,
}) {
  return GtbImageGroupThemeData(
    size: GtbImageGroupSize.medium,
  );
}
