import 'package:flutter/widgets.dart';
import 'package:gtb_teatro/design_system/components/ui/gtb_border.dart';

WidgetStateProperty<T> generateState<T>(
  T normal, {
  T? selected,
  T? disabled,
  T? disabledAndSelected,
  T? pressed,
  T? pressedAndSelected,
}) {
  return WidgetStateProperty.resolveWith(
    (states) {
      if (states.containsAll({WidgetState.pressed, WidgetState.selected})) {
        return pressedAndSelected ?? pressed ?? normal;
      } else if (states.contains(WidgetState.pressed)) {
        return pressed ?? normal;
      } else if (states.containsAll({WidgetState.disabled, WidgetState.selected})) {
        return disabledAndSelected ?? disabled ?? normal;
      } else if (states.contains(WidgetState.disabled)) {
        return disabled ?? normal;
      } else if (states.contains(WidgetState.selected)) {
        return selected ?? normal;
      } else {
        return normal;
      }
    },
  );
}

WidgetStateProperty<GtbBorderSide> generateStateBorderSide(
  double stroke,
  Color color, {
  Color? disabledColor,
  Color? selectedColor,
  Color? pressedColor,
  Color? pressedAndSelectedColor,
  GtbBorderStyle borderStyle = const GtbBorderStyle.none(),
}) {
  return WidgetStateProperty.resolveWith(
    (states) {
      final Color resolvedColor;

      if (states.containsAll({WidgetState.pressed, WidgetState.selected})) {
        resolvedColor = pressedAndSelectedColor ?? pressedColor ?? color;
      } else if (states.contains(WidgetState.pressed)) {
        resolvedColor = pressedColor ?? color;
      } else if (states.contains(WidgetState.disabled)) {
        resolvedColor = disabledColor ?? color;
      } else if (states.contains(WidgetState.selected)) {
        resolvedColor = selectedColor ?? color;
      } else {
        resolvedColor = color;
      }

      return GtbBorderSide(
        stroke: stroke,
        color: resolvedColor,
        borderStyle: borderStyle,
      );
    },
  );
}
