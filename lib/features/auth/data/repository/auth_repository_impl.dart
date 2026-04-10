

// auth/data/repositories/auth_repository_impl.dart

import 'package:prof_7oda_app/features/auth/domain/repository/auth_repository.dart';

import '../../domain/entities/user_entity.dart';
import '../data_sources/auth_remote_data_source.dart';
import '../models/user_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<UserEntity> login(String phone, String password) async {
    final data = await remoteDataSource.login(phone, password);

    return UserModel.fromJson(data);
  }
}


