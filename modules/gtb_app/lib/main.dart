import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async {
  await runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    runApp(const GtbApp());
  }, (error, stack) {});
}

final class GtbApp extends StatefulWidget {
  const GtbApp({super.key});

  @override
  State<GtbApp> createState() => _GtbAppState();
}

class _GtbAppState extends State<GtbApp> {
  @override
  void initState() {
    super.initState();
    initializeApp();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> initializeApp() async {}

  Future<void> _initializeModules() async {}

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
