import 'package:flutter/material.dart';
import 'package:gtb_teatro/color_scheme/color_scheme_provider.dart';

final class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();

  static const String routeName = '/splash';
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = GtbThemeProvider.of(context).appColorScheme;
    return Container(
      width: double.infinity,
      color: colorScheme.purpleBase,
    );
  }
}
