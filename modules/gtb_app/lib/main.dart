import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gtb_app/env/environment_config.dart';
import 'package:gtb_app/modules_manager.dart';
import 'package:gtb_core/gtb_core.dart';
import 'package:gtb_home/gtb_home.dart';
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

class _GtbAppState extends State<GtbApp> with ModulesManager {
  late final ApiClient _apiClient;
  late final Environment _environment;

  @override
  void initState() {
    super.initState();
    _initializeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _initializeDependencies() async {
    _environment = EnvironmentConfig.instance.setupEnvironment;
    _setupApiClient(_environment);
  }

  void _setupApiClient(Environment env) {
    final dio = Dio()
      ..options.baseUrl = env.baseUrl
      ..options.connectTimeout = Duration(
        milliseconds: env.httpTimeout,
      )
      ..options.sendTimeout = Duration(
        milliseconds: env.httpTimeout,
      )
      ..options.receiveTimeout = Duration(
        milliseconds: env.httpTimeout,
      );

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

  @override
  List<RegisterModule> get modules {
    final baseUrl = _environment.baseUrl;
    return [
      GtbHomeModule(
        baseUrl: baseUrl,
      ),
    ];
  }
}
