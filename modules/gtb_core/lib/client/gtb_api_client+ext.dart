import 'package:dio/dio.dart';
import 'package:gtb_core/client/api_client_exception.dart';
import 'package:gtb_core/utils/value_objects/api_response.dart';

extension DioResponseAdapter on Response {
  ApiResponse toApiResponse() {
    return ApiResponse(data: data, statusCode: statusCode, message: statusMessage);
  }
}

extension DioExceptionAdapter on DioException {
  ApiException toApiException() {
    return ApiException(
      error: error,
      message: message ?? '',
      data: response?.data ?? {},
      response: response?.toApiResponse(),
      statusCode: response?.statusCode,
    );
  }
}
