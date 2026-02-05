import 'package:odin_core/utils/utils.dart';

final class ApiException extends BaseException {
  dynamic error;
  ApiResponse? response;

  ApiException({
    required super.message,
    super.statusCode,
    super.data,
    required this.error,
    this.response,
    super.stackTracing,
  });
}
