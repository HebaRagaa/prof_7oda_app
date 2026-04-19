

import 'package:prof_7oda_app/features/products/domain/entities/product_entity.dart';
import 'package:prof_7oda_app/features/products/domain/repository/product_repository.dart';

class GetProductsUseCase {
  final ProductRepository repository;

  GetProductsUseCase(this.repository);

  Future<List<ProductEntity>> call() {
    return repository.getProducts();
  }
}


