import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prof_7oda_app/core/layout/main_screen.dart';
import 'package:prof_7oda_app/core/network/dio_factory.dart';
import 'package:prof_7oda_app/core/theme/app_theme.dart';
import 'package:prof_7oda_app/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:prof_7oda_app/features/auth/data/repository/auth_repository_impl.dart';
import 'package:prof_7oda_app/features/auth/domain/entities/auth_cubit.dart';
import 'package:prof_7oda_app/features/auth/domain/usecases/login_usecase.dart';
import 'package:prof_7oda_app/features/auth/presentation/screens/login_screen.dart';
import 'package:prof_7oda_app/features/cart/presentation/cart_cubit.dart';
import 'package:prof_7oda_app/features/products/data/data_source/product_remote_data_source.dart';
import 'package:prof_7oda_app/features/products/data/repository/product_repository_impl.dart';
import 'package:prof_7oda_app/features/products/domain/usecases/get_products_usecase.dart';
import 'package:prof_7oda_app/features/products/presentation/cubit/favorites_cubit.dart';
import 'package:prof_7oda_app/features/products/presentation/cubit/products_cubit.dart';

void main() {
  // 🔥 1. نعمل Dio
  final dio = DioFactory.getDio(); // 🔥 2. نعمل DataSource
  final remoteDataSource = AuthRemoteDataSource(dio);
  // 🔥 3. نعمل Repository
  final repository = AuthRepositoryImpl(remoteDataSource);
  // 🔥 4. نعمل UseCase
  final loginUseCase = LoginUseCase(repository);
  //products
  final productDataSource = ProductRemoteDataSource(dio);
  final productRepo = ProductRepositoryImpl(productDataSource);
  final getProductsUseCase = GetProductsUseCase(productRepo);

  runApp(MyApp(
      loginUseCase: loginUseCase,
      getProductsUseCase: getProductsUseCase
  ));
  // runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  final LoginUseCase loginUseCase;
  final GetProductsUseCase getProductsUseCase;

  const MyApp(
      {super.key, required this.loginUseCase, required this.getProductsUseCase});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,

      // 👇 هنا بقى المهم
      home: BlocProvider(
        create: (_) => AuthCubit(loginUseCase),
        child: LoginScreen(),
      ),

      routes: {
        '/products': (context) =>
            MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (_) =>
                  ProductsCubit(getProductsUseCase)
                    ..getProducts(),
                ),
                BlocProvider(
                  create: (_) => FavoritesCubit(),
                ),
                BlocProvider(
                  create: (_) => CartCubit(),
                ),
              ],
              child: MainScreen(),
            ),
      },
    );
  }
}
