import 'package:dio/dio.dart' hide Response;
import 'package:app_test_fiap/app/core/api/api_adapter.dart';

class DioClientAdapter implements ApiClientAdapter {
  final String baseUrl;

  late Dio _dio;

  DioClientAdapter({required this.baseUrl}) {
    _dio = Dio();
    _dio.options.baseUrl = baseUrl;
  }

  @override
  Future<Response> delete({required String path}) async {
    final result = await _dio.delete(path);
    return Response(data: result.data, statusCode: result.statusCode);
  }

  @override
  Future<Response> get(
      {required String path, Map<String, String>? queryParam}) async {
    final result = await _dio.get(path, queryParameters: queryParam);
    return Response(data: result.data, statusCode: result.statusCode);
  }

  @override
  Future<Response> post({required String path, Object? data}) async {
    final result = await _dio.post(path, data: data);
    return Response(data: result.data, statusCode: result.statusCode);
  }

  @override
  Future<Response> put({required String path, Object? data}) async {
    final result = await _dio.put(path, data: data);
    return Response(data: result.data, statusCode: result.statusCode);
  }
}
