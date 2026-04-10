

// auth/domain/repositories/auth_repository.dart

import 'package:prof_7oda_app/features/auth/domain/entities/user_entity.dart';

abstract class AuthRepository {
  Future<UserEntity> login(String phone, String password);
}


