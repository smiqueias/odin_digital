import 'package:flutter/widgets.dart';
import 'package:gtb_teatro/design_system/components/ui/gtb_button.dart';
import 'package:gtb_teatro/design_system/gtb_teatro.dart';
import 'package:gtb_teatro/design_system/models/action_settings.dart';

class GtbCoachmark extends StatelessWidget {
  const GtbCoachmark({
    super.key,
    this.title,
    this.paragraph,
    this.primaryActionSettings,
    this.secondaryActionSettings,
  });

  final String? title;
  final String? paragraph;
  final GtbActionSettings<VoidCallback>? primaryActionSettings;
  final GtbActionSettings<VoidCallback>? secondaryActionSettings;

  @override
  Widget build(BuildContext context) {
    final theme = GtbThemeProvider.of(context);

    return Padding(
      padding: const EdgeInsets.all(GtbPaddingValue.sm),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title case final title?)
            Text(
              title,
              style: theme.typography.titleSmall.copyWith(
                color: theme.appColorScheme.onColorEmphasisHigh,
              ),
            ),
          if (paragraph case final paragraph?) ...[
            GtbGap.xxs,
            Text(
              paragraph,
              style: theme.typography.titleSmall.copyWith(
                color: theme.appColorScheme.onColorEmphasisMedium,
              ),
            ),
          ],
          GtbGap.sm,
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (secondaryActionSettings case final secondaryActionSettings?)
                GtbButton.fromActionSettings(
                  actionSettings: secondaryActionSettings,
                  kind: GtbButtonKind.line,
                  size: GtbButtonSize.compact,
                ),
              GtbGap.xs,
              if (primaryActionSettings case final primaryActionSettings?)
                GtbButton.fromActionSettings(
                  actionSettings: primaryActionSettings,
                  size: GtbButtonSize.compact,
                ),
            ],
          ),
        ],
      ),
    );
  }
}
