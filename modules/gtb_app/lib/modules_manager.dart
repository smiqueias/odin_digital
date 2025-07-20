import 'package:flutter/widgets.dart';
import 'package:gtb_core/contracts/contracts.dart';

mixin ModulesManager<T extends StatefulWidget> on State<T> {
  List<RegisterModule> get modules;

  Future<void> initializeModules() async {
    await Future.forEach(
      modules,
      (modules) async {
        await modules.register();
      },
    );
  }

  Map<String, WidgetBuilder> get gtbRoutes => {
    for (final module in modules) ...module.routes,
  };
}
