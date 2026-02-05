abstract base class BaseException<T> implements Exception {
  const BaseException({required this.message, this.data, this.statusCode, this.stackTracing});

  final T? data;
  final String message;
  final int? statusCode;
  final dynamic stackTracing;
}

final class DefaultException extends BaseException {
  const DefaultException({required super.message, required super.stackTracing});
}
