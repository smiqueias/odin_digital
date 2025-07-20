import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gtb_app/env/environment_config.dart';
import 'package:gtb_core/gtb_core.dart';
import 'package:gtb_teatro/gtb_teatro.dart';

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
  late final ApiClient _apiClient;
  late final EnvironmentConfig _environmentConfig;

  @override
  void initState() {
    super.initState();
    initializeApp();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> initializeApp() async {
    _environmentConfig = EnvironmentConfig.config;
    _setupApiClient(_environmentConfig);
  }

  Future<void> _initializeModules() async {}

  void _setupApiClient(EnvironmentConfig environmentConfig) {
    final dio = Dio()
      ..options.baseUrl = environmentConfig.baseUrl
      ..options.connectTimeout = Duration(milliseconds: environmentConfig.httpTimeout)
      ..options.sendTimeout = Duration(milliseconds: environmentConfig.httpTimeout)
      ..options.receiveTimeout = Duration(milliseconds: environmentConfig.httpTimeout);

    _apiClient = GtbApiClient(dio: dio);
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle.light,
      child: GtbThemeProvider(
        typography: defaultTypography,
        appColorScheme: gtbLight,
        builder: (context) {
          return MaterialApp(
            title: 'GTB Digital',
            theme: ThemeData(
              fontFamily: FontFamily.fontFamily,
              useMaterial3: false,
            ),
          );
        },
      ),
    );
  }
}
