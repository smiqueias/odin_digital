import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:odin_app/env/environment_config.dart';
import 'package:odin_app/modules_manager.dart';
import 'package:odin_app/ui/splash_screen.dart';
import 'package:odin_core/odin_core.dart';
import 'package:odin_home/odin_home.dart';
import 'package:odin_teatro/design_system/color_scheme/color_scheme_provider.dart';
import 'package:odin_teatro/design_system/color_scheme/instances/odin_light.dart';
import 'package:odin_teatro/design_system/foundation/fonts.dart';
import 'package:odin_teatro/design_system/foundation/typography.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  await runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    runApp(const OdinApp());
  }, (error, stack) {});
}

final class OdinApp extends StatefulWidget {
  const OdinApp({super.key});

  @override
  State<OdinApp> createState() => _OdinAppState();
}

class _OdinAppState extends State<OdinApp> with ModulesManager {
  late final ApiClient _apiClient;
  late final Environment _environment;

  // Modules
  late final OdinHomeModule _odinHomeModule;

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
    _setupModules();
  }

  Future<void> _setupModules() async {
    _odinHomeModule = OdinHomeModule(baseUrl: _environment.baseUrl);

    await registerModulesDependencies();
  }

  void _setupApiClient(Environment env) {
    final dio = Dio()
      ..options.baseUrl = env.baseUrl
      ..options.connectTimeout = Duration(milliseconds: env.httpTimeout)
      ..options.sendTimeout = Duration(milliseconds: env.httpTimeout)
      ..options.receiveTimeout = Duration(milliseconds: env.httpTimeout);

    _apiClient = OdinApiClient(dio: dio);
  }

  Map<String, WidgetBuilder> get odinRoutes => <String, WidgetBuilder>{'/splash': (context) => const SplashScreen(), ..._odinHomeModule.navigation};

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle.light,
      child: OdinThemeProvider(
        typography: defaultTypography,
        appColorScheme: odinLightColorScheme,
        builder: (context) {
          return MaterialApp(
            title: 'Oding Digital',
            theme: ThemeData(fontFamily: FontFamily.fontFamily, useMaterial3: false),
            navigatorKey: navigatorKey,
            initialRoute: SplashScreen.routeName,
            routes: odinRoutes,
          );
        },
      ),
    );
  }

  @override
  List<RegisterModule> get modules {
    return [_odinHomeModule];
  }
}
