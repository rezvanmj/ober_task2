import 'dart:async';

import 'package:dio/dio.dart';

const baseUrl = 'https://api.lexilaw.net/';
const imageBaseUrl = 'https://hel1.your-object-storage.com/lexilaw-uploads/';

abstract class ApiProviderInterface {
  Future<Response> get(path, {Map<String, dynamic>? data});

  Future<Response> put(path, {Map? data});

  Future<Response> post(path, {Map? data});

  Future<Response> patch(path, {Map? data});

  Future<Response> postAuth(path, {Map? data});

  Future<Response> upload(
    path, {
    Map? data,
    required int fileSize,
    required ProgressCallback onSendProgress,
  });

  Future<Response> delete(path);

  void initLogger();
}

class ApiProvider extends ApiProviderInterface {
  ApiProvider._internal();

  static final ApiProvider _singleton = ApiProvider._internal();

  factory ApiProvider() {
    return _singleton;
  }

  static BaseOptions options = BaseOptions(
    baseUrl: baseUrl,
    connectTimeout: const Duration(seconds: 30),
    receiveTimeout: const Duration(seconds: 30),
    sendTimeout: const Duration(seconds: 30),
    headers: {"Content-Type": "application/json", "Accept": "application/json"},
  );

  final Dio _dio = Dio(options);

  @override
  Future<Response> get(path, {Map<String, dynamic>? data}) async =>
      await _dio.get(
        path,
        queryParameters: data,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
        // options: Options(
        //   headers: {"Authorization": "Bearer ${CacheProvider().getToken()}"},
        // ),
      );

  @override
  Future<Response> post(path, {dynamic data}) async => await _dio.post(
    path,
    data: data,
    options: Options(
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ),
  );

  @override
  Future<Response> postAuth(path, {dynamic data}) async => await _dio.post(
    path,
    data: data,
    options: Options(
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ),
  );

  @override
  Future<Response> put(path, {Map? data}) async => await _dio.put(
    path,
    data: data,
    options: Options(
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ),
  );

  @override
  Future<Response> patch(path, {Map? data}) async => await _dio.patch(
    path,
    data: data,
    options: Options(
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ),
  );

  @override
  Future<Response> delete(path) async => await _dio.delete(
    path,
    options: Options(
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ),
  );

  @override
  Future<Response> upload(
    path, {
    dynamic data,
    required int fileSize,
    required ProgressCallback onSendProgress,
  }) async => await _dio.post(
    path,
    data: data,
    onSendProgress: onSendProgress,
    options: Options(
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ),
  );

  @override
  void initLogger() {
    _dio.interceptors.addAll([
      // AuthInterceptor(_dio),
      // PrettyDioLogger(
      //   requestHeader: true,
      //   requestBody: true,
      //   responseBody: true,
      //   responseHeader: false,
      //   error: true,
      //   compact: true,
      //   maxWidth: 90,
      // ),
    ]);
  }
}
