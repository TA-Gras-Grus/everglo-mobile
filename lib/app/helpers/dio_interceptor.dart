import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:everglo_mobile/app/data/models/Response.dart';
import 'package:everglo_mobile/app/helpers/notification_snackbar.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart' as get_dart;
import 'package:get_storage/get_storage.dart';

class ApiClient {
  final Dio dio = Dio(BaseOptions(baseUrl: dotenv.env['API_BASE_URL']!));
  final baseUrl = dotenv.env['API_BASE_URL']!;
  final token = GetStorage().read('userToken');

  Future<Response> get(String pathUrl,
      {Map<String, dynamic>? params, bool isAuth = true}) async {
    try {
      // var token = storage.read('userToken');
      dio.options.headers['content-Type'] = 'application/json';
      dio.options.headers['Accept'] = 'application/json';
      if (isAuth) {
        dio.options.headers['Authorization'] = "Bearer $token";
      }
      dio.options.connectTimeout = Duration(seconds: 25000);
      dio.options.sendTimeout = Duration(seconds: 25000);
      dio.options.receiveTimeout = Duration(seconds: 25000);
      dio.interceptors.clear();
      dio.interceptors.add(DioInterceptor(dio));

      var res = await dio.get(baseUrl + pathUrl, queryParameters: params);

      return res;
    } on DioException catch (e) {
      return e.response!;
    }
  }

  Future<Response> post(String pathUrl,
      {Map<String, dynamic>? data, bool isAuth = true}) async {
    try {
      dio.options.headers['content-Type'] = 'application/json';
      dio.options.headers['Accept'] = 'application/json';
      if (isAuth) {
        dio.options.headers['Authorization'] = "Bearer $token";
      }
      dio.options.connectTimeout = Duration(seconds: 25000);
      dio.options.sendTimeout = Duration(seconds: 25000);
      dio.options.receiveTimeout = Duration(seconds: 25000);
      dio.interceptors.clear();
      dio.interceptors.add(DioInterceptor(dio));

      return data != null
          ? await dio.post(baseUrl + pathUrl, data: data)
          : await dio.post(baseUrl + pathUrl);
    } on DioException {
      throw DioException(requestOptions: RequestOptions());
    }
  }

  Future<Response> patch(String pathUrl,
      {Map<String, dynamic>? data, bool isAuth = true}) async {
    try {
      dio.options.headers['content-Type'] = 'application/json';
      dio.options.headers['Accept'] = 'application/json';
      if (isAuth) {
        dio.options.headers['Authorization'] = "Bearer $token";
      }
      dio.options.connectTimeout = Duration(seconds: 25000);
      dio.options.sendTimeout = Duration(seconds: 25000);
      dio.options.receiveTimeout = Duration(seconds: 25000);
      dio.interceptors.clear();
      dio.interceptors.add(DioInterceptor(dio));

      return data != null
          ? await dio.patch(baseUrl + pathUrl, data: data)
          : await dio.patch(baseUrl + pathUrl);
    } on DioException {
      throw DioException(requestOptions: RequestOptions());
    }
  }
}

class DioInterceptor extends Interceptor {
  DioInterceptor(
    this.dio,
  );

  final Dio dio;

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    printInfo(
      info: 'REQUEST[${options.method}: ${options.path}]'
          ' => Param: ${options.queryParameters}'
          ' => EXTRA: ${options.extra.toString()}'
          ' => DATA: ${options.data}'
          ' => Header: ${options.headers.toString()}',
    );

    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    printInfo(
      info: 'RESPONSE[${response.statusCode}: ${response.requestOptions.path}]'
          ' => DATA: ${response.data.toString()}',
    );

    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == null) {
      printInfo(
        info: 'ERROR[${err.type.name}: ${err.requestOptions.path.toString()}]'
            ' => MSG: ${err.message}',
      );
      NotificationSnackbar()
          .error('Connection Error', 'Please check your internet connection!');
      super.onError(
        DioException(
          error: err.error,
          response: err.response,
          requestOptions: err.requestOptions,
        ),
        handler,
      );
    } else {
      printInfo(
        info: 'ERROR[${err.response?.statusCode}: ${err.requestOptions.path}]'
            ' => DATA: ${err.response}',
      );

      if (err.response?.statusCode == 502) {
        super.onError(
          DioException(
            error: err.error,
            response: err.response,
            requestOptions: err.requestOptions,
          ),
          handler,
        );
      } else if (err.response?.statusCode == 401) {
        ResponseError error =
            ResponseError.fromJson(jsonDecode(err.response.toString()));
        NotificationSnackbar()
            .error('Authentication Failed', error.errors!.message);
        super.onError(err, handler);
      } else {
        NotificationSnackbar().error('Authentication Failed', err.message);
        super.onError(err, handler);
      }
    }
  }
}
