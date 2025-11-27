import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gtb_app/env/environment_config.dart';
import 'package:gtb_app/modules_manager.dart';
import 'package:gtb_app/ui/splash_screen.dart';
import 'package:gtb_core/gtb_core.dart';
import 'package:gtb_home/gtb_home.dart';
import 'package:gtb_teatro/design_system/color_scheme/color_scheme_provider.dart';
import 'package:gtb_teatro/design_system/color_scheme/instances/gtb_light.dart';
import 'package:gtb_teatro/design_system/fundations/fonts.dart';
import 'package:gtb_teatro/design_system/fundations/typography.dart';

final navigatorKey = GlobalKey<NavigatorState>();

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

  // Modules
  late final GtbHomeModule _gtbHomeModule;

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
    _gtbHomeModule = GtbHomeModule(baseUrl: _environment.baseUrl);

    await registerModulesDependencies();
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

  Map<String, WidgetBuilder> get gtbRoutes => <String, WidgetBuilder>{
    '/splash': (context) => const SplashScreen(),
    ..._gtbHomeModule.navigation,
  };

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
            navigatorKey: navigatorKey,
            initialRoute: SplashScreen.routeName,
            routes: gtbRoutes,
          );
        },
      ),
    );
  }

  @override
  List<RegisterModule> get modules {
    return [_gtbHomeModule];
  }
}
