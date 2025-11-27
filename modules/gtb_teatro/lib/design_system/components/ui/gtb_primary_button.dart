import 'package:flutter/material.dart';
import 'package:gtb_teatro/design_system/fundations/gtb_teatro.dart';

class GtbPrimaryButton extends StatelessWidget {
  final String title;
  final Color? color;
  final IconData? icon;
  final EdgeInsetsGeometry? padding;

  const GtbPrimaryButton({
    super.key,
    required this.title,
    this.color,
    this.padding,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final appTheme = GtbThemeProvider.of(context);
    return Padding(
      padding:
          padding ?? EdgeInsets.symmetric(horizontal: GtbPadding.padding_24),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton.icon(
          onPressed: () {},
          icon: icon == null ? null : Icon(icon, size: GtbIconSizes.size_16),
          style: ElevatedButton.styleFrom(
            backgroundColor: color ?? appTheme.appColorScheme.blue,
            padding: EdgeInsets.symmetric(vertical: GtbPadding.padding_16),
            shape: RoundedRectangleBorder(
              borderRadius: GtbBorderRadius.circular_radius_8,
            ),
          ),
          label: Text(
            title,
            style: appTheme.typography.subtitle.copyWith(
              fontWeight: appTheme.typography.fontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
