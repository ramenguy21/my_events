import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiService {
  final Dio _dio;
  static final String baseUrl = dotenv.env['USERS_API_URL'] ?? '';

  ApiService()
    : _dio = Dio(
        BaseOptions(
          baseUrl: baseUrl,
          connectTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 10),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'x-api-key': 'reqres-free-v1',
          },
        ),
      ) {
    if (!baseUrl.endsWith('/')) {
      throw Exception('API_BASE_URL must end with a trailing slash (/)');
    }
    _dio.interceptors.add(
      LogInterceptor(
        request: true,
        responseBody: true,
        error: true,
        requestHeader: true,
      ),
    );
  }

  Future<Response> post(String endpoint, Map<String, dynamic> data) async {
    try {
      return await _dio.post(endpoint, data: data);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<Response> get(
    String endpoint, {
    Map<String, dynamic>? queryParams,
  }) async {
    try {
      return await _dio.get(endpoint, queryParameters: queryParams);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<Response> put(String endpoint, Map<String, dynamic> data) async {
    try {
      return await _dio.put(endpoint, data: data);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<Response> delete(String endpoint) async {
    try {
      return await _dio.delete(endpoint);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return Exception('Connection timeout');
      case DioExceptionType.badResponse:
        return Exception('Server error: ${error.response?.statusCode}');
      case DioExceptionType.cancel:
        return Exception('Request cancelled');
      default:
        return Exception('Network error: ${error.message}');
    }
  }
}
