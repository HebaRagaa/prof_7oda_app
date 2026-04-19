

import 'package:dio/dio.dart';

class ProductRemoteDataSource {
  final Dio dio;

  ProductRemoteDataSource(this.dio);

  Future<List<Map<String, dynamic>>> getProducts() async {
    final response = await dio.get('/products');

    return List<Map<String, dynamic>>.from(response.data['products']);
  }
}



