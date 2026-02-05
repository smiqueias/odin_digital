import 'package:flutter/widgets.dart';
import 'package:odin_core/contracts/contracts.dart';

mixin ModulesManager<T extends StatefulWidget> on State<T> {
  List<RegisterModule> get modules;

  Future<void> registerModulesDependencies() async {
    await Future.forEach(modules, (modules) async {
      await modules.register();
    });
  }
}
