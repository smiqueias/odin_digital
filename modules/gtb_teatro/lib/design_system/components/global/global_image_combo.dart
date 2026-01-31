import 'package:flutter/widgets.dart';
import 'package:gtb_teatro/design_system/components/ui/gtb_border.dart';
import 'package:gtb_teatro/design_system/components/ui/gtb_image_container.dart';
import 'package:gtb_teatro/design_system/gtb_teatro.dart';

enum GtbGlobalImageComboSize {
  size32,
  size40,
}

class GtbGlobalImageCombo extends StatelessWidget {
  const GtbGlobalImageCombo({
    required this.imageContainers,
    super.key,
    this.size,
    this.maxItems = 5,
    this.maxHiddenItemsFeedback = 9,
  });

  final List<GtbImageContainer> imageContainers;
  final GtbGlobalImageComboSize? size;
  final int maxItems;
  final int maxHiddenItemsFeedback;

  @override
  Widget build(BuildContext context) {
    final resolvedSize = size ?? GtbGlobalImageComboTheme.of(context).size;
    final imageContainerSize = switch (resolvedSize) {
      GtbGlobalImageComboSize.size32 => GtbImageContainerSize.size32,
      GtbGlobalImageComboSize.size40 => GtbImageContainerSize.size40,
    };

    return GtbGlobalImageComboBase(
      imageContainers: imageContainers,
      imageContainerSize: imageContainerSize,
      maxItems: maxItems,
      maxHiddenItemsFeedback: maxHiddenItemsFeedback,
    );
  }
}

class GtbGlobalImageComboBase extends StatelessWidget {
  const GtbGlobalImageComboBase({
    required this.imageContainers,
    required this.imageContainerSize,
    required this.maxItems,
    required this.maxHiddenItemsFeedback,
    super.key,
  });

  final List<GtbImageContainer> imageContainers;
  final GtbImageContainerSize imageContainerSize;
  final int maxItems;
  final int maxHiddenItemsFeedback;

  @override
  Widget build(BuildContext context) {
    assert(imageContainers.isNotEmpty, 'The images list must have at least one item.');

    final theme = GtbThemeProvider.of(context);

    final numberOfImagesToShow = imageContainers.length <= maxItems
        ? imageContainers.length
        : maxItems - 1;
    final numberOfImagesToHide = imageContainers.length - numberOfImagesToShow;

    final shouldUseLargeText = numberOfImagesToHide < 10 || maxHiddenItemsFeedback < 10;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: GtbImageContainerTheme(
        data: GtbImageContainerTheme.of(context).copyWith(
          size: imageContainerSize,
          shape: GtbImageContainerShape.rounded,
        ),
        child: Stack(
          children: [
            if (numberOfImagesToHide > 0)
              Padding(
                padding: EdgeInsets.only(
                  left: _getLeftSpacingFor(0, numberOfImagesToShow + 1, imageContainerSize.value),
                ),
                child: Container(
                  alignment: Alignment.center,
                  width: imageContainerSize.value,
                  height: imageContainerSize.value,
                  decoration: BoxDecoration(
                    color: theme.appColorScheme.neutralBase,
                    border: GtbBorder.all(
                      color: theme.appColorScheme.outlineBase,
                      stroke: theme.borderTheme.strokeThin,
                    ),
                    shape: BoxShape.circle,
                  ),
                  padding: EdgeInsets.only(
                    left: imageContainerSize.value * 0.25,
                    right: 2.0,
                  ),
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      numberOfImagesToHide <= maxHiddenItemsFeedback
                          ? '+$numberOfImagesToHide'
                          : '$maxHiddenItemsFeedback+',
                      style: shouldUseLargeText
                          ? theme.typography.labelSmall
                          : theme.typography.labelTiny,
                    ),
                  ),
                ),
              ),
            for (int i = 0; i < numberOfImagesToShow; i++)
              Padding(
                padding: EdgeInsets.only(
                  left: _getLeftSpacingFor(i, numberOfImagesToShow, imageContainerSize.value),
                ),
                child: imageContainers[i],
              ),
          ],
        ),
      ),
    );
  }

  double _getLeftSpacingFor(int itemIndex, int totalItems, double imageContainerSize) {
    return (totalItems - 1 - itemIndex) * imageContainerSize * 0.75;
  }
}

final class GtbGlobalImageComboTheme extends InheritedTheme {
  const GtbGlobalImageComboTheme({
    required super.child,
    required this.data,
    super.key,
  });

  final GtbGlobalImageComboThemeData data;

  static GtbGlobalImageComboThemeData of(BuildContext context) {
    final theme = context.dependOnInheritedWidgetOfExactType<GtbGlobalImageComboTheme>();
    return theme?.data ?? GtbThemeProvider.of(context).globalImageComboTheme;
  }

  @override
  bool updateShouldNotify(GtbGlobalImageComboTheme oldWidget) {
    return oldWidget.data != data;
  }

  @override
  Widget wrap(BuildContext context, Widget child) {
    return GtbGlobalImageComboTheme(
      data: data,
      child: child,
    );
  }
}

final class GtbGlobalImageComboThemeData {
  GtbGlobalImageComboThemeData({
    required this.size,
  });

  final GtbGlobalImageComboSize size;

  static GtbGlobalImageComboThemeData lerp(
    GtbGlobalImageComboThemeData a,
    GtbGlobalImageComboThemeData b,
    double t,
  ) {
    return GtbGlobalImageComboThemeData(
      size: t < 0.5 ? a.size : b.size,
    );
  }

  GtbGlobalImageComboThemeData copyWith({
    GtbGlobalImageComboSize? size,
  }) {
    return GtbGlobalImageComboThemeData(
      size: size ?? this.size,
    );
  }
}

GtbGlobalImageComboThemeData createDefaultGlobalImageComboTheme({
  required GtbColorScheme colorScheme,
  required GtbBorderThemeData borderTheme,
  required GtbTypography typography,
}) {
  return GtbGlobalImageComboThemeData(
    size: GtbGlobalImageComboSize.size32,
  );
}
