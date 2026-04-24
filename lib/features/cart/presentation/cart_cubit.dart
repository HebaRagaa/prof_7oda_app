

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prof_7oda_app/features/products/domain/entities/product_entity.dart';

class CartCubit extends Cubit<List<ProductEntity>> {
  CartCubit() : super([]);

  void addToCart(ProductEntity product) {
    final updated = List<ProductEntity>.from(state);
    updated.add(product);
    emit(updated);
  }

  void removeFromCart(ProductEntity product) {
    final updated = List<ProductEntity>.from(state);
    updated.remove(product);
    emit(updated);
  }
}


