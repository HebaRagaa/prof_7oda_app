

import 'package:dio/dio.dart';
import 'dio_factory.dart';

class DioHelper {
  static Future<Response> get(
      String path, {
        Map<String, dynamic>? query,
      }) async {
    final dio = await DioFactory.getDio();

    return await dio.get(
      path,
      queryParameters: query,
    );
  }

  static Future<Response> post(
      String path, {
        dynamic data,
        Map<String, dynamic>? query,
      }) async {
    final dio = await DioFactory.getDio();

    return await dio.post(
      path,
      data: data,
      queryParameters: query,
    );
  }

  static Future<Response> put(
      String path, {
        dynamic data,
      }) async {
    final dio = await DioFactory.getDio();

    return await dio.put(
      path,
      data: data,
    );
  }

  static Future<Response> delete(
      String path, {
        dynamic data,
      }) async {
    final dio = await DioFactory.getDio();

    return await dio.delete(
      path,
      data: data,
    );
  }
}


