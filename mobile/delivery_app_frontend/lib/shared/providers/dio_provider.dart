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
      // Para ignorar certificados inválidos em desenvolvimento (NÃO USAR EM PRODUÇÃO)
      // validateStatus: (status) => status != null,
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
    print('═════════════════════════════════════════');
    print('[Dio] 🌐 REQUEST');
    print('[Dio] URL: ${options.baseUrl}${options.path}');
    print('[Dio] Method: ${options.method}');
    print('[Dio] Headers: ${options.headers}');
    if (options.data != null) {
      print('[Dio] Data: ${options.data}');
    }
    print('═════════════════════════════════════════');
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print('═════════════════════════════════════════');
    print('[Dio] ✅ RESPONSE');
    print('[Dio] Status: ${response.statusCode}');
    print('[Dio] Path: ${response.requestOptions.path}');
    print('[Dio] Data: ${response.data}');
    print('═════════════════════════════════════════');
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    print('═════════════════════════════════════════');
    print('[Dio] ❌ ERROR');
    print('[Dio] Message: ${err.message}');
    print('[Dio] Error Type: ${err.type}');
    print('[Dio] Status Code: ${err.response?.statusCode}');
    print('[Dio] Response: ${err.response?.data}');
    print('═════════════════════════════════════════');
    handler.next(err);
  }
}


