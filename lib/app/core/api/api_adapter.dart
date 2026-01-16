abstract class ApiClientAdapter<T> {
  Future<Response<T>> post({required String path, Object? data});
  Future<Response<T>> get({required String path, Map<String, String>? queryParam});
  Future<Response<T>> delete({required String path});
  Future<Response<T>> put({required String path, Object? data});
}

class Response<T> {
  T? data;
  int? statusCode;

  Response({this.data, this.statusCode});
}
