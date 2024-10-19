import 'package:dio/dio.dart';
import 'package:logging/logging.dart';

import 'api_client.dart';

const baseUrl = 'https://fake-api.tractian.com';

class ApiClientDio implements ApiClient {
  final log = Logger('[ApiClientDio]');
  final Dio _dio;

  ApiClientDio(this._dio) {
    _dio.options.baseUrl = baseUrl;
  }

  @override
  Future<ClientResponse> get(
    String path, {
    Map<String, dynamic>? queryParams,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await _dio.get(
        path,
        options: Options(headers: headers),
        queryParameters: queryParams,
      );
      return ClientResponse(
        data: response.data,
        statusCode: response.statusCode!,
      );
    } on DioException catch (e, s) {
      log.severe(e.toString());
      log.severe(s.toString());
      throw HttpServiceError(message: e.toString(), stackTrace: s);
    }
  }
}
