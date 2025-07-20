import 'package:flutter/widgets.dart';
import 'package:gtb_core/contracts/contracts.dart';

final class GtbHomeModule extends RegisterModule {
  GtbHomeModule({required super.baseUrl})
    : super(
        routes: {
          '': (context) => const Placeholder(),
        },
      );

  @override
  Future<void> register() async {}
}
