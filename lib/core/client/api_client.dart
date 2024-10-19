import '../errors/errors.dart';

abstract class ApiClient {
  Future<ClientResponse> get(
    String path, {
    Map<String, dynamic>? queryParams,
    Map<String, dynamic>? headers,
  });
}

class ApiHeader {
  final Map<String, dynamic> data;
  const ApiHeader({required this.data});
}

class ClientResponse {
  final dynamic data;
  final int statusCode;

  const ClientResponse({
    required this.data,
    required this.statusCode,
  });

  @override
  String toString() => 'ClientResponse(data: $data, statusCode: $statusCode)';
}

class HttpServiceError extends Failure {
  final String message;
  final StackTrace? stackTrace;
  HttpServiceError({required this.message, this.stackTrace});
}
