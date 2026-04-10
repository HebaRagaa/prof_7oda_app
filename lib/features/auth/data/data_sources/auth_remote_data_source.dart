

// auth/data/data_sources/auth_remote_data_source.dart

import 'package:dio/dio.dart';

class AuthRemoteDataSource {
  final Dio dio;

  AuthRemoteDataSource(this.dio);

  Future<Map<String, dynamic>> login(String phone, String password) async {
    final response = await dio.post(
      '/login',
      data: {
        "phone": phone,
        "password": password,
      },
    );

    return response.data;
  }
}


