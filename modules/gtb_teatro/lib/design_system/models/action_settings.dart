import 'package:flutter/widgets.dart';
import 'package:gtb_teatro/design_system/models/semantics_data.dart';

final class GtbActionSettings<T extends Function> {
  const GtbActionSettings({
    required this.text,
    this.leftIcon,
    this.rightIcon,
    this.onPress,
    this.semantics = const GtbSemanticsData(),
  });

  final String text;
  final IconData? leftIcon;
  final IconData? rightIcon;
  final T? onPress;
  final GtbSemanticsData semantics;

  GtbActionSettings<T> copyWith({
    String? text,
    IconData? leftIcon,
    IconData? rightIcon,
    T? onPress,
    GtbSemanticsData? semantics,
  }) {
    return GtbActionSettings(
      text: text ?? this.text,
      leftIcon: leftIcon ?? this.leftIcon,
      rightIcon: rightIcon ?? this.rightIcon,
      onPress: onPress ?? this.onPress,
      semantics: semantics ?? this.semantics,
    );
  }
}

final class GtbIconActionSettings {
  const GtbIconActionSettings({
    required this.icon,
    this.onPress,
  });

  final IconData icon;
  final VoidCallback? onPress;

  GtbIconActionSettings copyWith({
    IconData? icon,
    VoidCallback? onPress,
  }) {
    return GtbIconActionSettings(
      icon: icon ?? this.icon,
      onPress: onPress ?? this.onPress,
    );
  }
}
