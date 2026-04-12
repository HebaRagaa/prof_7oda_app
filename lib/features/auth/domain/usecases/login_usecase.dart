

// auth/domain/usecases/login_usecase.dart

import 'package:prof_7oda_app/features/auth/domain/repository/auth_repository.dart';

import '../entities/user_entity.dart';

class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  Future<UserEntity> call(String username, String password) {
    return repository.login(username, password);
  }
}


