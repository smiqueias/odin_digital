import 'package:flutter/material.dart';
import 'package:gtb_teatro/design_system/components/global/global_lock_screen.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

Future<T?> showGtbModal<T>({
  required BuildContext context,
  required WidgetBuilder builder,
  Color? barrierColor,
  bool? isDismissible,
  double? maxHeight,
  RouteSettings? routeSettings,
  bool expand = false,
  AnimationController? animationController,
  bool shouldAlignAboveKeyboard = false,
}) async {
  assert(debugCheckHasMediaQuery(context));

  return showCupertinoModalBottomSheet(
    context: context,
    barrierColor: barrierColor ?? GtbGlobalLockScreen.getColor(context),
    topRadius: Radius.zero,
    isDismissible: isDismissible,
    settings: routeSettings,
    expand: expand,
    secondAnimation: animationController,
    builder: (context) {
      return ConstrainedBox(
        constraints: maxHeight == null
            ? const BoxConstraints()
            : BoxConstraints(maxHeight: maxHeight),
        child: Material(
          type: MaterialType.transparency,
          child: Padding(
            padding: shouldAlignAboveKeyboard
                ? EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom) //
                : EdgeInsets.zero,
            child: Builder(builder: builder),
          ),
        ),
      );
    },
  );
}
