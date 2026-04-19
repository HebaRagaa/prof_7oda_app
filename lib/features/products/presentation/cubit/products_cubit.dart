

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/product_entity.dart';
import '../../domain/usecases/get_products_usecase.dart';

part 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  final GetProductsUseCase getProductsUseCase;

  ProductsCubit(this.getProductsUseCase) : super(ProductsInitial());

  void getProducts() async {
    emit(ProductsLoading());

    try {
      final products = await getProductsUseCase();
      emit(ProductsSuccess(products));
    } catch (e) {
      emit(ProductsError(e.toString()));
    }
  }
}


