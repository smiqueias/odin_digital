import 'package:dio/dio.dart';
import 'package:odin_core/client/odin_api_client+ext.dart';
import 'package:odin_core/contracts/api_client.dart';
import 'package:odin_core/utils/value_objects/api_request.dart';
import 'package:odin_core/utils/value_objects/api_response.dart';
import 'package:odin_core/utils/value_objects/errors/base_exception.dart';

final class OdinApiClient implements ApiClient {
  final Dio _dio;

  OdinApiClient({required Dio dio}) : _dio = dio;

  @override
  Future<ApiResponse> get<T>(ApiRequest request) async {
    try {
      final response = await _dio.get(
        request.path,
        queryParameters: request.queryParameters,
        options: Options(headers: request.headers),
      );
      return response.toApiResponse();
    } on DioException catch (e) {
      throw e.toApiException();
    } catch (error, stacktrace) {
      throw DefaultException(message: error.toString(), stackTracing: stacktrace);
    }
  }

  @override
  Future<ApiResponse> post<T>(ApiRequest request) async {
    try {
      final response = await _dio.post(
        request.path,
        data: request.data,
        queryParameters: request.queryParameters,
        options: Options(headers: request.headers),
      );
      return response.toApiResponse();
    } on DioException catch (e) {
      throw e.toApiException();
    } catch (error, stacktrace) {
      throw DefaultException(message: error.toString(), stackTracing: stacktrace);
    }
  }
}
