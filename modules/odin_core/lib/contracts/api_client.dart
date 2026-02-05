import 'package:odin_core/utils/utils.dart';

abstract interface class ApiClient {
  Future<ApiResponse> get<T>(ApiRequest request);
  Future<ApiResponse> post<T>(ApiRequest request);
}
