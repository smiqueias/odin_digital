import 'package:flutter/widgets.dart';
import 'package:gtb_teatro/design_system/color_scheme/color_scheme.dart';
import 'package:gtb_teatro/design_system/components/global/global_divider.dart';
import 'package:gtb_teatro/design_system/components/global/global_image_combo.dart';
import 'package:gtb_teatro/design_system/components/global/global_progress_bar.dart';
import 'package:gtb_teatro/design_system/components/global/global_status_badge.dart';
import 'package:gtb_teatro/design_system/components/ui/gtb_avatar.dart';
import 'package:gtb_teatro/design_system/components/ui/gtb_border.dart';
import 'package:gtb_teatro/design_system/components/ui/gtb_button.dart';
import 'package:gtb_teatro/design_system/components/ui/gtb_checkbox.dart';
import 'package:gtb_teatro/design_system/components/ui/gtb_icon_button.dart';
import 'package:gtb_teatro/design_system/components/ui/gtb_icon_container.dart';
import 'package:gtb_teatro/design_system/components/ui/gtb_image_container.dart';
import 'package:gtb_teatro/design_system/components/ui/gtb_image_group.dart';
import 'package:gtb_teatro/design_system/components/ui/gtb_input.dart';
import 'package:gtb_teatro/design_system/components/ui/gtb_link.dart';
import 'package:gtb_teatro/design_system/components/ui/gtb_nav_bar.dart';
import 'package:gtb_teatro/design_system/components/ui/gtb_radio_button.dart';
import 'package:gtb_teatro/design_system/components/ui/gtb_tooltip.dart';
import 'package:gtb_teatro/design_system/foundation/typography.dart';

final class GtbThemeProvider extends InheritedWidget {
  final GtbColorScheme appColorScheme;
  final GtbTypography typography;
  final bool isInverse;

  late final GtbIconContainerThemeData iconContainerTheme;
  late final GtbLinkThemeData linkTheme;
  late final GtbIconButtonThemeData iconButtonTheme;
  late final GtbDividerThemeData dividerTheme;
  late final GtbGlobalProgressBarThemeData globalProgressBarTheme;
  late final GtbInputControlButtonThemeData inputControlButtonTheme;
  late final GtbInputThemeData inputTheme;
  late final GtbButtonThemeData buttonTheme;
  late final GtbBorderThemeData borderTheme;
  late final GtbRadioButtonThemeData radioButtonTheme;
  late final GtbCheckboxThemeData checkboxTheme;
  late final GtbAvatarThemeData avatarTheme;
  late final GtbStatusBadgeThemeData statusBadgeTheme;
  late final GtbNavBarThemeData navBarTheme;
  late final GtbImageContainerThemeData imageContainerTheme;
  late final GtbGlobalImageComboThemeData globalImageComboTheme;
  late final GtbImageGroupThemeData imageGroupTheme;
  late final GtbTooltipThemeData tooltipTheme;

  GtbThemeProvider({
    super.key,
    required this.appColorScheme,
    required this.typography,
    required WidgetBuilder builder,
    this.isInverse = false,
  }) : iconContainerTheme = createDefaultIconContainerTheme(
         borderTheme: defaultBorderTheme,
         colorScheme: appColorScheme,
         typography: typography,
       ),

       linkTheme = createDefaultLinkTheme(
         typography: typography,
         colorScheme: appColorScheme,
         borderTheme: defaultBorderTheme,
       ),

       iconButtonTheme = createDefaultIconButtonTheme(
         colorScheme: appColorScheme,
         borderTheme: defaultBorderTheme,
         typography: typography,
       ),

       dividerTheme = createDefaultDividerTheme(
         colorScheme: appColorScheme,
         borderTheme: defaultBorderTheme,
         typography: typography,
       ),

       globalProgressBarTheme = createDefaultGlobalProgressBarTheme(
         colorScheme: appColorScheme,
         borderTheme: defaultBorderTheme,
         typography: typography,
       ),

       inputControlButtonTheme = createDefaultInputControlButtonTheme(
         colorScheme: appColorScheme,
         borderTheme: defaultBorderTheme,
         typography: typography,
       ),

       inputTheme = createDefaultInputTheme(
         colorScheme: appColorScheme,
         borderTheme: defaultBorderTheme,
         typography: typography,
       ),

       buttonTheme = createDefaultButtonTheme(
         colorScheme: appColorScheme,
         borderTheme: defaultBorderTheme,
         typography: typography,
       ),

       borderTheme = defaultBorderTheme,

       radioButtonTheme = createDefaultRadioButtonTheme(
         colorScheme: appColorScheme,
         borderTheme: defaultBorderTheme,
         typography: typography,
       ),

       checkboxTheme = createDefaultCheckboxTheme(
         colorScheme: appColorScheme,
         borderTheme: defaultBorderTheme,
         typography: typography,
       ),

       avatarTheme = createDefaultAvatarTheme(
         colorScheme: appColorScheme,
         borderTheme: defaultBorderTheme,
         typography: typography,
       ),

       statusBadgeTheme = createDefaultStatusBadgeTheme(
         colorScheme: appColorScheme,
         borderTheme: defaultBorderTheme,
         typography: typography,
       ),

       navBarTheme = createDefaultNavBarTheme(
         colorScheme: appColorScheme,
         borderTheme: defaultBorderTheme,
         typography: typography,
       ),

       imageContainerTheme = createDefaultImageContainerTheme(
         colorScheme: appColorScheme,
         borderTheme: defaultBorderTheme,
         typography: typography,
       ),

       globalImageComboTheme = createDefaultGlobalImageComboTheme(
         colorScheme: appColorScheme,
         borderTheme: defaultBorderTheme,
         typography: typography,
       ),

       imageGroupTheme = createDefaultImageGroupTheme(
         colorScheme: appColorScheme,
         borderTheme: defaultBorderTheme,
         typography: typography,
       ),

       tooltipTheme = createDefaultTooltipTheme(
         colorScheme: appColorScheme,
         borderTheme: defaultBorderTheme,
         typography: typography,
       ),

       super(
         child: Builder(
           builder: builder,
         ),
       );

  static GtbThemeProvider of(BuildContext context) {
    final scheme = context.dependOnInheritedWidgetOfExactType<GtbThemeProvider>();

    if (scheme != null) {
      return scheme;
    } else {
      throw Exception("No color scheme");
    }
  }

  @override
  bool updateShouldNotify(GtbThemeProvider oldWidget) {
    return oldWidget.appColorScheme != appColorScheme;
  }
}
