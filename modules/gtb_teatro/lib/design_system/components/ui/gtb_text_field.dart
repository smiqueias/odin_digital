import 'package:flutter/material.dart';
import 'package:gtb_teatro/design_system/fundations/gtb_teatro.dart';

class GtbTextField extends StatefulWidget {
  final EdgeInsetsGeometry? padding;
  final String label;
  final int? maxLength;
  final TextEditingController inputController;
  final VoidCallback onEnterInput;

  const GtbTextField({
    super.key,
    this.padding,
    required this.inputController,
    required this.label,
    required this.onEnterInput,
    this.maxLength,
  });

  @override
  State<GtbTextField> createState() => _GtbTextFieldState();
}

class _GtbTextFieldState extends State<GtbTextField> {
  @override
  Widget build(BuildContext context) {
    final appTheme = GtbThemeProvider.of(context);
    return Padding(
      padding:
          widget.padding ??
          EdgeInsets.symmetric(horizontal: GtbPadding.padding_24),
      child: TextField(
        cursorColor: appTheme.appColorScheme.blue,
        controller: widget.inputController,
        onChanged: (value) {
          widget.onEnterInput();
        },
        maxLength: widget.maxLength ?? 30,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          hintText: widget.label,
          hintStyle: appTheme.typography.input,
          counterText: '',
          filled: true,
          fillColor: appTheme.appColorScheme.gray100,
          contentPadding: EdgeInsets.symmetric(
            horizontal: GtbPadding.padding_16,
            vertical: GtbPadding.padding_12,
          ),
          border: OutlineInputBorder(
            borderRadius: GtbBorderRadius.circular_radius_8,
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
