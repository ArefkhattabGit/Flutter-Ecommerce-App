import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';

class DioHelper {
  static Dio? dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://student.valuxapps.com/api/',
        receiveDataWhenStatusError: true,
        headers: {
          'Content-Type': 'application/json',
        },
      ),
    );
    // TODO : THIS LINE SHOULD BEE IN THIS CLASS TO GIVE CERTIFICATE TO USER AUTHENTICATION.
    // TODO: To Give Certificate To Auth user Login ...
    (dio!.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
  }

  static Future<Response> postLogOutUsesr({
    required String url,
    required Map<String, String>? data,
    String? token,
  }) async {
    dio!.options.headers = {
      'Authorization': token ?? '',
    };
    return await dio!.get(
      url,
      queryParameters: data,
    );
  }

  static Future<Response> getData({
    required String url,
    String lang = 'en',
    String? token,
  }) async {
    dio!.options.headers = {
      'lang': lang,
      'Content-Type': 'application/json',
      'Authorization': token ?? '',
    };

    return await dio!.get(
      url,
    );
  }

  static Future<Response> getCategory(
      {required String url,
      String lang = 'en',
      required Map<String, dynamic> data}) async {
    dio!.options.headers = {
      'lang': lang
    };

    return dio!.post(
      url,
      data: data,
    );
  }

  static Future<Response> postData({
    required String url,
    required Map<String, dynamic> data,
    Map<String, dynamic>? query,
    String lang = 'en',
    String? token,
  }) async {
    dio!.options.headers = {
      'lang': lang,
      'Content-Type': 'application/json',
      'Authorization': token ?? '',
      // 'Content-Type': 'application/json',
    };

    return dio!.post(
      url,
      queryParameters: query,
      data: data,
    );
  }
}
