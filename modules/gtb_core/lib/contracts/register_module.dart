import 'package:flutter/widgets.dart';

abstract base class RegisterModule {
  final String baseUrl;
  final Map<String, WidgetBuilder> routes;

  RegisterModule({
    required this.baseUrl,
    required this.routes,
  });

  Future<void> register();
}
