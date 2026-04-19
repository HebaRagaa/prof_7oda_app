

import '../../domain/entities/product_entity.dart';
import '../../domain/repository/product_repository.dart';
import '../data_source/product_remote_data_source.dart';
import '../models/product_model.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;

  ProductRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<ProductEntity>> getProducts() async {
    final data = await remoteDataSource.getProducts();

    return data.map((e) => ProductModel.fromJson(e)).toList();
  }
}


