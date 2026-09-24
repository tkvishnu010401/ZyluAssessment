import 'package:dio/dio.dart';
import '../constants/api_urls.dart';

class DioClient {
  static DioClient? _instance;
  late final Dio dio;

  DioClient._internal() {
    dio = Dio(
      BaseOptions(
        baseUrl: ApiUrls.baseUrl,
        connectTimeout: const Duration(seconds: 12),
        receiveTimeout: const Duration(seconds: 12),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      ),
    );

    // Logging & Error Interceptor
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          debugPrint('🌐 [DIO REQUEST] ${options.method} ${options.uri}');
          return handler.next(options);
        },
        onResponse: (response, handler) {
          debugPrint('✅ [DIO RESPONSE] ${response.statusCode} from ${response.requestOptions.uri}');
          return handler.next(response);
        },
        onError: (DioException error, handler) {
          debugPrint('❌ [DIO ERROR] ${error.type} for ${error.requestOptions.uri}: ${error.message}');
          return handler.next(error);
        },
      ),
    );
  }

  static DioClient get instance => _instance ??= DioClient._internal();
}

void debugPrint(String message) {
  // Using dart:developer or printing in debug mode
  // ignore: avoid_print
  print(message);
}
