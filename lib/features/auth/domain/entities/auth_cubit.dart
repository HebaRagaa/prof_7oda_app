// auth/presentation/cubit/auth_cubit.dart

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/login_usecase.dart';
import '../../domain/entities/user_entity.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final LoginUseCase loginUseCase;

  AuthCubit(this.loginUseCase) : super(AuthInitial());

  void login(String phone, String password) async {
    emit(AuthLoading());

    try {
      print("📤 Sending login request...");

      final user = await loginUseCase(phone, password);
      print("✅ Response: $user");

      emit(AuthSuccess(user));
    } catch (e) {
      print("❌ Error: $e");

      emit(AuthError(e.toString()));
    }
  }
}



