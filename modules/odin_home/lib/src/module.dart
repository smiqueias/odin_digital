import 'package:flutter/widgets.dart';
import 'package:odin_core/contracts/contracts.dart';

final class OdinHomeModule extends RegisterModule {
  OdinHomeModule({required super.baseUrl});

  @override
  Future<void> register() async {
    // Register dependencies here
  }

  @override
  Map<String, WidgetBuilder> get navigation => {
    '/home': (context) => const Placeholder(),
  };
}
