import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:gtb_teatro/design_system/components/ui/gtb_icon_button.dart';
import 'package:gtb_teatro/design_system/foundation/constants.dart';
import 'package:gtb_teatro/design_system/foundation/icons.dart';
import 'package:gtb_teatro/design_system/foundation/spacing.dart';
import 'package:gtb_teatro/design_system/gtb_teatro.dart';
import 'package:intersperse/intersperse.dart';

final class GtbNavBar extends StatelessWidget implements PreferredSizeWidget {
  const GtbNavBar({
    super.key,
    this.title,
    this.actions,
    this.backgroundColor,
    this.foregroundColor,
    this.hasBackButton = true,
    this.leftPadding = GtbPaddingValue.sm,
    this.rightPadding = GtbPaddingValue.sm,
    this.actionsSpacing = GtbGapValue.xs,
    this.onTapBack,
    this.bottom,
    this.bottomOpacity = 1.0,
  });

  final Widget? title;
  final List<Widget>? actions;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final bool hasBackButton;
  final double leftPadding;
  final double rightPadding;
  final double actionsSpacing;
  final VoidCallback? onTapBack;
  final PreferredSizeWidget? bottom;
  final double bottomOpacity;

  @override
  Size get preferredSize => const Size.fromHeight(kNavBarHeight);

  @override
  Widget build(BuildContext context) {
    final theme = GtbNavBarTheme.of(context);

    final effectiveBackgroundColor = backgroundColor ?? theme.backgroundColor;
    final effectiveForegroundColor = foregroundColor ?? theme.foregroundColor;

    return GtbIconButtonTheme(
      data: GtbIconButtonTheme.of(context).copyWith(
        color: effectiveForegroundColor,
        iconSize: 24.0,
      ),
      child: AppBar(
        title: _NavBarTitle(
          hasBackButton: hasBackButton,
          leftPadding: leftPadding,
          title: title,
          onTapBack: onTapBack,
        ),
        titleSpacing: 0.0,
        titleTextStyle: theme.titleTextStyle.copyWith(color: effectiveForegroundColor),
        actions: [
          if (actions case final actions?)
            ...intersperse(
              SizedBox(width: actionsSpacing),
              [
                for (final action in actions)
                  Center(
                    child: action,
                  ),
              ],
            ),
          SizedBox(width: rightPadding),
        ],
        actionsIconTheme: IconThemeData(
          color: effectiveForegroundColor,
          size: 24.0,
        ),
        automaticallyImplyLeading: false,
        backgroundColor: effectiveBackgroundColor,
        foregroundColor: Colors.red,
        elevation: 0.0,
        leadingWidth: 0.0,
        bottom: bottom,
        bottomOpacity: bottomOpacity,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: theme.statusBarColor,
          statusBarIconBrightness: theme.statusBarIconBrightness,
          statusBarBrightness: theme.statusBarBrightness,
        ),
      ),
    );
  }
}

class GtbSliverNavBar extends StatelessWidget implements PreferredSizeWidget {
  const GtbSliverNavBar({
    super.key,
    this.title,
    this.actions,
    this.backgroundColor,
    this.foregroundColor,
    this.hasBackButton = true,
    this.leftPadding = GtbPaddingValue.sm,
    this.rightPadding = GtbPaddingValue.sm,
    this.onTapBack,
    this.flexibleSpace,
    this.bottom,
    this.collapsedHeight,
    this.expandedHeight,
    this.floating = false,
    this.pinned = false,
    this.snap = false,
    this.stretch = false,
  });

  final Widget? title;
  final List<Widget>? actions;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final bool hasBackButton;
  final double leftPadding;
  final double rightPadding;
  final VoidCallback? onTapBack;
  final Widget? flexibleSpace;
  final PreferredSizeWidget? bottom;
  final double? collapsedHeight;
  final double? expandedHeight;
  final bool floating;
  final bool pinned;
  final bool snap;
  final bool stretch;

  @override
  Size get preferredSize => const Size.fromHeight(kNavBarHeight);

  @override
  Widget build(BuildContext context) {
    final theme = GtbNavBarTheme.of(context);

    final effectiveBackgroundColor = backgroundColor ?? theme.backgroundColor;
    final effectiveForegroundColor = foregroundColor ?? theme.foregroundColor;

    return GtbIconButtonTheme(
      data: GtbIconButtonTheme.of(context).copyWith(
        color: effectiveForegroundColor,
        iconSize: 24.0,
      ),
      child: SliverAppBar(
        title: _NavBarTitle(
          hasBackButton: hasBackButton,
          leftPadding: leftPadding,
          title: title,
          onTapBack: onTapBack,
        ),
        titleSpacing: 0.0,
        titleTextStyle: theme.titleTextStyle,
        actions: [
          if (actions case final actions?) ...actions,
          SizedBox(width: rightPadding),
        ],
        actionsIconTheme: IconThemeData(
          color: effectiveForegroundColor,
          size: 24.0,
        ),
        automaticallyImplyLeading: false,
        backgroundColor: effectiveBackgroundColor,
        foregroundColor: effectiveForegroundColor,
        elevation: 0.0,
        leadingWidth: 0.0,
        flexibleSpace: flexibleSpace,
        bottom: bottom,
        collapsedHeight: collapsedHeight,
        expandedHeight: expandedHeight,
        floating: floating,
        pinned: pinned,
        snap: snap,
        stretch: stretch,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: theme.statusBarColor,
          statusBarIconBrightness: theme.statusBarIconBrightness,
          statusBarBrightness: theme.statusBarBrightness,
        ),
      ),
    );
  }
}

class _NavBarTitle extends StatelessWidget {
  const _NavBarTitle({
    required this.hasBackButton,
    required this.leftPadding,
    required this.title,
    this.onTapBack,
  });

  final bool hasBackButton;
  final double leftPadding;
  final Widget? title;
  final VoidCallback? onTapBack;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (hasBackButton)
          Semantics(
            label: 'Voltar',
            child: Padding(
              padding: EdgeInsets.only(left: max(0.0, leftPadding - kIconButtonExtraSpacing)),
              child: GtbIconButton(
                icon: const Icon(GtbIcons.arrowLeft),
                onPress: onTapBack ?? Navigator.of(context).maybePop,
              ),
            ),
          )
        else
          GtbGap.sm,
        if (title case final title?)
          Expanded(
            child: title,
          ),
      ],
    );
  }
}

class GtbNavBarHome extends StatelessWidget implements PreferredSizeWidget {
  const GtbNavBarHome({
    required this.avatar,
    required this.personName,
    super.key,
    this.actions,
    this.hasText = true,
    this.leftPadding = GtbPaddingValue.sm,
    this.rightPadding = GtbPaddingValue.sm,
    this.onPress,
  });

  final GtbAvatar avatar;
  final String personName;
  final bool hasText;
  final List<Widget>? actions;
  final double leftPadding;
  final double rightPadding;
  final VoidCallback? onPress;

  String get greetingText {
    return switch (clock.now().hour) {
      >= 0 && < 12 => 'Bom dia,',
      >= 12 && < 18 => 'Boa tarde,',
      _ => 'Boa noite,',
    };
  }

  @override
  Size get preferredSize => const Size.fromHeight(kNavBarHeight);

  @override
  Widget build(BuildContext context) {
    final navBarTheme = GtbNavBarTheme.of(context);

    return GtbIconButtonTheme(
      data: GtbIconButtonTheme.of(context).copyWith(
        color: navBarTheme.foregroundColor,
        iconSize: 24.0,
      ),
      child: AppBar(
        backgroundColor: navBarTheme.backgroundColor,
        foregroundColor: navBarTheme.foregroundColor,
        elevation: 0.0,
        leadingWidth: 0.0,
        automaticallyImplyLeading: false,
        title: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: onPress,
          child: Row(
            children: [
              SizedBox(width: leftPadding),
              GtbAvatarTheme(
                data: GtbAvatarTheme.of(context).copyWith(
                  hasOutline: false,
                  size: GtbAvatarSize.size40,
                ),
                child: avatar,
              ),
              GtbGap.xxs,
              if (hasText)
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(greetingText),
                      Row(
                        children: [
                          Flexible(
                            child: Text(personName),
                          ),
                          GtbGap.xxxs,
                          const Icon(
                            GtbIcons.chevronRight,
                            size: 16.0,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        titleSpacing: 0.0,
        titleTextStyle: navBarTheme.homeTitleTextStyle.copyWith(color: navBarTheme.foregroundColor),
        actions: [
          if (actions case final actions?) ...actions,
          SizedBox(width: rightPadding),
        ],
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: navBarTheme.statusBarColor,
          statusBarIconBrightness: navBarTheme.statusBarIconBrightness,
          statusBarBrightness: navBarTheme.statusBarBrightness,
        ),
      ),
    );
  }
}

class GtbNavBarLogo extends StatelessWidget implements PreferredSizeWidget {
  const GtbNavBarLogo({
    required this.logoImage,
    super.key,
    this.inverseLogoImage,
  });

  final Widget? logoImage;
  final Widget? inverseLogoImage;

  @override
  Size get preferredSize => const Size.fromHeight(kNavBarHeight);

  @override
  Widget build(BuildContext context) {
    final navBarTheme = GtbNavBarTheme.of(context);

    final resolvedImage = GtbThemeProvider.of(context).isInverse && inverseLogoImage != null
        ? inverseLogoImage
        : logoImage;

    return GtbIconButtonTheme(
      data: GtbIconButtonTheme.of(context).copyWith(
        color: navBarTheme.foregroundColor,
        iconSize: 24.0,
      ),
      child: AppBar(
        backgroundColor: navBarTheme.backgroundColor,
        foregroundColor: navBarTheme.foregroundColor,
        elevation: 0.0,
        leadingWidth: 0.0,
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: GtbPaddingValue.sm,
            vertical: GtbPaddingValue.xxs,
          ),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 40.0),
            child: resolvedImage ?? const SizedBox.shrink(),
          ),
        ),
        titleSpacing: 0.0,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: navBarTheme.statusBarColor,
          statusBarIconBrightness: navBarTheme.statusBarIconBrightness,
          statusBarBrightness: navBarTheme.statusBarBrightness,
        ),
      ),
    );
  }
}

class GtbNavBarSearch extends StatelessWidget implements PreferredSizeWidget {
  const GtbNavBarSearch({
    super.key,
    this.controller,
    this.focusNode,
    this.onPressBack,
    this.onTapOutside,
    this.placeholder,
    this.clearLinkLabel,
    this.shouldAutofocus = true,
  });

  final TextEditingController? controller;
  final FocusNode? focusNode;
  final VoidCallback? onPressBack;
  final TapRegionCallback? onTapOutside;
  final Widget? placeholder;
  final Widget? clearLinkLabel;
  final bool shouldAutofocus;

  @override
  Size get preferredSize => const Size.fromHeight(kNavBarHeight);

  @override
  Widget build(BuildContext context) {
    final navBarTheme = GtbNavBarTheme.of(context);

    return AppBar(
      backgroundColor: navBarTheme.searchBackgroundColor,
      foregroundColor: navBarTheme.foregroundColor,
      elevation: 0.0,
      leadingWidth: 0.0,
      automaticallyImplyLeading: false,
      title: GtbSearch(
        controller: controller,
        focusNode: focusNode,
        onPressBack: onPressBack ?? () => Navigator.of(context).maybePop(),
        onTapOutside: onTapOutside,
        placeholder: placeholder ?? const Text('Pesquisar'),
        clearLinkLabel: clearLinkLabel,
        shouldAutofocus: shouldAutofocus,
      ),
      titleSpacing: 0.0,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: navBarTheme.statusBarColor,
        statusBarIconBrightness: navBarTheme.statusBarIconBrightness,
        statusBarBrightness: navBarTheme.statusBarBrightness,
      ),
    );
  }
}
