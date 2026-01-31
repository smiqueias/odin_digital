import 'package:flutter/widgets.dart';

typedef LerpCallback<T> = T Function(T, T, double);

double lerpDouble(num a, num b, double t) {
  assert(a.isFinite, 'Cannot interpolate between finite and non-finite values');
  assert(b.isFinite, 'Cannot interpolate between finite and non-finite values');
  assert(t.isFinite, 't must be finite when interpolating between values');
  return a * (1.0 - t) + b * t;
}

double? lerpNullableDouble(num? a, num? b, double t) {
  if (a == b || (a?.isNaN ?? false) && (b?.isNaN ?? false)) {
    return a?.toDouble();
  }
  final resolvedA = a ?? 0.0;
  final resolvedB = b ?? 0.0;
  assert(resolvedA.isFinite, 'Cannot interpolate between finite and non-finite values');
  assert(resolvedB.isFinite, 'Cannot interpolate between finite and non-finite values');
  assert(t.isFinite, 't must be finite when interpolating between values');
  return resolvedA * (1.0 - t) + resolvedB * t;
}

lerpEnum<T extends Enum>(List<T> enumValues, T? a, T? b, double t) {
  if (a == null || b == null) {
    return t < 0.5 ? a : b;
  } else {
    final startIndex = a.index;
    final endIndex = b.index;

    final interpolatedIndex = ((1 - t) * startIndex + t * endIndex).round();

    return enumValues[interpolatedIndex.clamp(0, enumValues.length - 1)];
  }
}

@pragma('vm:prefer-inline')
// ignore: avoid_positional_boolean_parameters
bool lerpBool(bool a, bool b, double t) => t < 0.5 ? a : b;

WidgetStateProperty<T?>? lerpWidgetStateProperty<T>(
  WidgetStateProperty<T> a,
  WidgetStateProperty<T> b,
  double t,
  LerpCallback<T> lerpFunction,
) {
  return _LerpProperties<T>(a, b, t, lerpFunction);
}

class _LerpProperties<T> implements WidgetStateProperty<T?> {
  const _LerpProperties(this.a, this.b, this.t, this.lerpFunction);

  final WidgetStateProperty<T> a;
  final WidgetStateProperty<T> b;
  final double t;
  final T Function(T, T, double) lerpFunction;

  @override
  T resolve(Set<WidgetState> states) {
    final resolvedA = a.resolve(states);
    final resolvedB = b.resolve(states);
    return lerpFunction(resolvedA, resolvedB, t);
  }
}
