import 'package:flutter/widgets.dart';
import 'package:gtb_teatro/design_system/components/feedback/ink_well.dart';
import 'package:gtb_teatro/design_system/components/feedback/show_modal.dart';
import 'package:gtb_teatro/design_system/components/ui/gtb_icon_container.dart';
import 'package:gtb_teatro/design_system/components/ui/gtb_modal.dart';
import 'package:gtb_teatro/design_system/components/ui/gtb_tooltip.dart';
import 'package:gtb_teatro/design_system/foundation/icons.dart';
import 'package:gtb_teatro/design_system/models/action_settings.dart';

final class GtbInformativeIcon extends StatelessWidget {
  GtbInformativeIcon.modalAction({
    required String title,
    required String message,
    super.key,
    this.color,
    this.size = GtbIconContainerSize.size16,
    RouteSettings? routeSettings,
    GtbActionSettings<VoidCallback>? primaryAction,
  }) : actionKind = _GtbIconInfoActionKind.modal(
         title: title,
         message: message,
         primaryAction: primaryAction,
         routeSettings: routeSettings,
       );

  GtbInformativeIcon.tooltipAction({
    required GtbTooltipAlignment alignment,
    required GtbTooltipPosition position,
    required String message,
    super.key,
    this.color,
    this.size = GtbIconContainerSize.size16,
  }) : actionKind = _GtbIconInfoActionKind.tooltip(
         alignment: alignment,
         position: position,
         message: message,
       );

  GtbInformativeIcon.customAction({
    required VoidCallback onPress,
    super.key,
    this.color,
    this.size = GtbIconContainerSize.size16,
  }) : actionKind = _GtbIconInfoActionKind.custom(onPress: onPress);

  final _GtbIconInfoActionKind actionKind;
  final Color? color;
  final GtbIconContainerSize size;

  @override
  Widget build(BuildContext context) {
    final icon = IconTheme.merge(
      data: const IconThemeData(applyTextScaling: true),
      child: GtbIconContainer(
        icon: GtbIcons.info,
        color: color,
        size: size,
      ),
    );

    return switch (actionKind) {
      GtbIconInfoActionKindModal(
        :final title,
        :final message,
        :final primaryAction,
        :final routeSettings,
      ) =>
        GtbInkWell.outsideResponse(
          onTap: () {
            showGtbModal<void>(
              context: context,
              routeSettings: routeSettings,
              builder: (context) {
                return GtbModal.defaultContent(
                  title: Text(title),
                  paragraph: Text(message),
                  primaryAction: primaryAction,
                );
              },
            );
          },
          child: icon,
        ),
      GtbIconInfoActionKindTooltip(:final alignment, :final position, :final message) =>
        GtbTooltip.defaultContent(
          alignment: alignment,
          position: position,
          label: message,
          child: icon,
        ),
      GtbIconInfoActionKindCustom(:final onPress) => GtbInkWell.outsideResponse(
        onTap: onPress,
        child: icon,
      ),
    };
  }
}

sealed class _GtbIconInfoActionKind {
  const _GtbIconInfoActionKind();

  const factory _GtbIconInfoActionKind.modal({
    required String title,
    required String message,
    required GtbActionSettings<VoidCallback>? primaryAction,
    RouteSettings? routeSettings,
  }) = GtbIconInfoActionKindModal;

  const factory _GtbIconInfoActionKind.tooltip({
    required GtbTooltipAlignment alignment,
    required GtbTooltipPosition position,
    required String message,
  }) = GtbIconInfoActionKindTooltip;

  const factory _GtbIconInfoActionKind.custom({
    required VoidCallback onPress,
  }) = GtbIconInfoActionKindCustom;
}

final class GtbIconInfoActionKindModal extends _GtbIconInfoActionKind {
  const GtbIconInfoActionKindModal({
    required this.title,
    required this.message,
    required this.primaryAction,
    this.routeSettings,
  });

  final String title;
  final String message;
  final GtbActionSettings<VoidCallback>? primaryAction;
  final RouteSettings? routeSettings;
}

final class GtbIconInfoActionKindTooltip extends _GtbIconInfoActionKind {
  const GtbIconInfoActionKindTooltip({
    required this.alignment,
    required this.position,
    required this.message,
  });

  final GtbTooltipAlignment alignment;
  final GtbTooltipPosition position;
  final String message;
}

final class GtbIconInfoActionKindCustom extends _GtbIconInfoActionKind {
  const GtbIconInfoActionKindCustom({
    required this.onPress,
  });

  final VoidCallback onPress;
}
