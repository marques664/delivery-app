import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/constants/api_constants.dart';

/// Provider do Dio - client HTTP para toda a aplicação
final dioProvider = Provider<Dio>((ref) {
  final dio = Dio(
    BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      connectTimeout: ApiConstants.connectTimeout,
      receiveTimeout: ApiConstants.receiveTimeout,
      headers: {
        'Content-Type': 'application/json',
      },
    ),
  );

  // Interceptadores para debug/logging
  dio.interceptors.add(
    LoggingInterceptor(),
  );

  return dio;
});

/// Interceptador customizado para logging
class LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    print('[Dio] Request: ${options.method} ${options.path}');
    print('[Dio] Headers: ${options.headers}');
    if (options.data != null) {
      print('[Dio] Data: ${options.data}');
    }
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print('[Dio] Response: ${response.statusCode} ${response.requestOptions.path}');
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    print('[Dio] Error: ${err.message}');
    print('[Dio] Error Type: ${err.type}');
    handler.next(err);
  }
}


