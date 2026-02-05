import 'package:flutter/widgets.dart';

abstract base class RegisterModule {
  final String baseUrl;

  RegisterModule({
    required this.baseUrl,
  });

  Future<void> register();

  Map<String, WidgetBuilder> get navigation;
}
