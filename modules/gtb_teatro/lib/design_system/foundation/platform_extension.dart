import 'package:flutter/foundation.dart';

extension TargetPlatformExtension on TargetPlatform {
  bool get isIOS => this == TargetPlatform.iOS;
  bool get isAndroid => this == TargetPlatform.android;
  bool get isFuchsia => this == TargetPlatform.fuchsia;
  bool get isLinux => this == TargetPlatform.linux;
  bool get isMacOS => this == TargetPlatform.macOS;
  bool get isWindows => this == TargetPlatform.windows;
}
