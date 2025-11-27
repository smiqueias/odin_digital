import 'package:flutter/material.dart';
import 'package:gtb_teatro/design_system/fundations/gtb_teatro.dart';

class GtbInformationCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color? iconColor;
  final EdgeInsetsGeometry? padding;
  final bool showIconButton;
  final VoidCallback? onIconButtonPressed;

  const GtbInformationCard({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.icon,
    this.iconColor,
    this.padding,
    this.showIconButton = false,
    this.onIconButtonPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appTheme = GtbThemeProvider.of(context);
    return Padding(
      padding:
          padding ?? EdgeInsets.symmetric(horizontal: GtbPadding.padding_24),
      child: SizedBox(
        width: double.infinity,
        child: Card(
          elevation: GtbElevation.none,
          shape: RoundedRectangleBorder(
            borderRadius: GtbBorderRadius.circular_radius_8,
          ),
          child: Padding(
            padding: EdgeInsets.all(GtbPadding.padding_12),
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color:
                        iconColor ?? appTheme.appColorScheme.blue.withAlpha(30),
                    borderRadius: GtbBorderRadius.circular_radius_10,
                  ),
                  padding: EdgeInsets.all(GtbPadding.padding_10),
                  child: Icon(
                    icon,
                    size: appTheme.typography.fontSize.md_24,
                    color: iconColor ?? appTheme.appColorScheme.blue,
                  ),
                ),
                GtbGap.gap_12,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: appTheme.typography.button,
                    ),
                    Text(
                      subtitle,
                      style: appTheme.typography.input.copyWith(
                        color: appTheme.appColorScheme.gray500,
                      ),
                    ),
                  ],
                ),
                GtbGap.gapFlex,
                if (showIconButton) ...[
                  IconButton(
                    onPressed: onIconButtonPressed,
                    icon: Icon(Icons.arrow_forward_ios_outlined),
                    iconSize: GtbIconSizes.size_16,
                    constraints: BoxConstraints(
                      minWidth: 45,
                      minHeight: 32,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
