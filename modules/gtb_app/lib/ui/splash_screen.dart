import 'package:flutter/material.dart';
import 'package:gtb_teatro/design_system/color_scheme/color_scheme_provider.dart';
import 'package:gtb_teatro/design_system/components/ui/gtb_information_card.dart';
import 'package:gtb_teatro/design_system/components/ui/gtb_primary_button.dart';
import 'package:gtb_teatro/design_system/components/ui/gtb_text_field.dart';
import 'package:gtb_teatro/design_system/fundations/gaps.dart';

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
    final appTheme = GtbThemeProvider.of(context);
    return Scaffold(
      body: Container(
        width: double.infinity,
        color: appTheme.appColorScheme.gray200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GtbPrimaryButton(
              title: 'Entrar',
            ),
            GtbGap.gap_12,
            GtbInformationCard(
              title: 'Cuidados',
              subtitle: 'com o pet',
              icon: Icons.pets,
              showIconButton: true,
              onIconButtonPressed: () => print('press'),
            ),
            GtbTextField(
              inputController: inputController,
              label: 'E-mail',
              onEnterInput: () {
                print(inputController.text);
              },
            ),
          ],
        ),
      ),
    );
  }
}
