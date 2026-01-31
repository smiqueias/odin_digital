import 'package:flutter/material.dart';
import 'package:gtb_teatro/design_system/color_scheme/color_scheme_provider.dart';
import 'package:gtb_teatro/design_system/components/ui/gtb_border.dart';
import 'package:gtb_teatro/design_system/foundation/constants.dart';

sealed class GtbGlobalNotificationBadgeKind {
  const factory GtbGlobalNotificationBadgeKind.bullet() = GtbGlobalNotificationBadgeKindBullet;

  const factory GtbGlobalNotificationBadgeKind.counter({
    required int count,
    int? maxCount,
  }) = GtbGlobalNotificationBadgeKindCounter;
}

final class GtbGlobalNotificationBadgeKindBullet implements GtbGlobalNotificationBadgeKind {
  const GtbGlobalNotificationBadgeKindBullet();
}

@immutable
final class GtbGlobalNotificationBadgeKindCounter implements GtbGlobalNotificationBadgeKind {
  const GtbGlobalNotificationBadgeKindCounter({
    required this.count,
    this.maxCount,
  });

  final int count;
  final int? maxCount;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    } else {
      return other is GtbGlobalNotificationBadgeKindCounter && //
          other.count == count &&
          other.maxCount == maxCount;
    }
  }

  @override
  int get hashCode {
    return Object.hashAll([GtbGlobalNotificationBadgeKindCounter, count, maxCount]);
  }
}

final class GtbGlobalNotificationBadge extends StatelessWidget {
  const GtbGlobalNotificationBadge({
    required this.kind,
    super.key,
  });

  const GtbGlobalNotificationBadge.bullet({
    super.key,
  }) : kind = const GtbGlobalNotificationBadgeKind.bullet();

  GtbGlobalNotificationBadge.counter({
    required int count,
    super.key,
    int? maxCount,
  }) : kind = GtbGlobalNotificationBadgeKind.counter(
         count: count,
         maxCount: maxCount,
       );

  final GtbGlobalNotificationBadgeKind kind;

  @override
  Widget build(BuildContext context) {
    final colors = GtbThemeProvider.of(context).appColorScheme;
    final typography = GtbThemeProvider.of(context).typography;

    switch (kind) {
      case GtbGlobalNotificationBadgeKindBullet():
        return DecoratedBox(
          decoration: BoxDecoration(
            color: colors.statusErrorBase,
            shape: BoxShape.circle,
            border: GtbBorder.all(
              color: kTransparentColor,
              stroke: defaultBorderTheme.strokeHairline,
            ),
          ),
          child: SizedBox.square(dimension: 8.0),
        );
      case GtbGlobalNotificationBadgeKindCounter(:final count, :final maxCount):
        return DecoratedBox(
          decoration: BoxDecoration(
            color: colors.statusInformativeBase,
            borderRadius: BorderRadius.circular(16.0 / 2),
            border: GtbBorder.all(
              color: kTransparentColor,
              stroke: 16.0,
            ),
          ),
          child: FittedBox(
            child: Container(
              alignment: Alignment.center,
              constraints: BoxConstraints(
                minHeight: 16.0,
                minWidth: 16.0,
              ),
              padding: EdgeInsets.symmetric(horizontal: 16.0 / 6),
              child: Text(
                maxCount == null || maxCount >= count ? '$count' : '$maxCount+',
                style: typography.labelMicro.copyWith(
                  color: colors.onColorEmphasisHighInverse,
                ),
              ),
            ),
          ),
        );
    }
  }
}
