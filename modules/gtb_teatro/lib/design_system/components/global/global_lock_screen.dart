import 'package:flutter/widgets.dart';
import 'package:gtb_teatro/design_system/gtb_teatro.dart';

class GtbGlobalLockScreen extends StatelessWidget {
  const GtbGlobalLockScreen({
    super.key,
    this.child,
  });

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: getColor(context),
      child: child ?? const SizedBox.expand(),
    );
  }

  static Color getColor(BuildContext context) {
    return GtbThemeProvider.of(context).appColorScheme.specialFixedBlack.withValues(
      alpha: 0.5,
    );
  }
}
