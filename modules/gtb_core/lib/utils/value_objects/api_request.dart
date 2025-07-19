class ApiRequest<T> {
  final String path;
  final T? data;
  final String baseUrl;
  final Map<String, dynamic>? queryParameters;
  final Map<String, dynamic>? headers;

  ApiRequest({
    required this.path,
    this.data,
    this.queryParameters,
    this.headers,
    this.baseUrl = '',
  });

  ApiRequest copyWith({
    String? path,
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) {
    return ApiRequest(
      path: path ?? this.path,
      data: data ?? this.data,
      queryParameters: queryParameters ?? this.queryParameters,
      headers: headers ?? this.headers,
    );
  }
}
