import 'package:flutter/widgets.dart';
import 'package:gtb_core/contracts/contracts.dart';

final class GtbHomeModule extends RegisterModule {
  GtbHomeModule({required super.baseUrl});

  @override
  Future<void> register() async {
    // Register dependencies here
  }

  @override
  Map<String, WidgetBuilder> get navigation => {
    '/home': (context) => const Placeholder(),
  };
}
