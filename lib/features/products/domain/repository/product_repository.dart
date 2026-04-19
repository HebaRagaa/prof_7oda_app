

import 'package:prof_7oda_app/features/products/domain/entities/product_entity.dart';

abstract class ProductRepository {
  Future<List<ProductEntity>> getProducts();
}


