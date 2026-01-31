import 'package:flutter/widgets.dart';

final class GtbBottomSafeAreaSpacer extends StatelessWidget {
  const GtbBottomSafeAreaSpacer({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: MediaQuery.paddingOf(context).bottom);
  }
}

final class GtbSliverBottomSafeAreaSpacer extends StatelessWidget {
  const GtbSliverBottomSafeAreaSpacer({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(height: MediaQuery.paddingOf(context).bottom),
    );
  }
}
