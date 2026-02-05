import 'package:flutter/material.dart';
import 'package:odin_teatro/design_system/color_scheme/color_scheme_provider.dart';

final class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();

  static const String routeName = '/splash';
}

class _SplashScreenState extends State<SplashScreen> {
  TextEditingController inputController = TextEditingController();

  @override
  void dispose() {
    inputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = OdinThemeProvider.of(context);
    return Scaffold(
      body: Container(
        width: double.infinity,
        color: appTheme.appColorScheme.actionDisabledBase,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [],
        ),
      ),
    );
  }
}
