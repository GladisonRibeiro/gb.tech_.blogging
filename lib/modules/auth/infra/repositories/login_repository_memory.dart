import 'package:dartz/dartz.dart';

import '../../domain/entities/credential.dart';
import '../../domain/entities/user.dart';
import '../../domain/exception/exception.dart';
import '../../domain/repositories/login_repository.dart';
import '../datasources/auth_datasource.dart';

class LoginRepositoryMemory implements LoginRepository {
  final AuthDatasorce datasorce;

  LoginRepositoryMemory(this.datasorce);

  @override
  Future<Either<AuthException, User>> login({
    required Credential credential,
  }) async {
    final user = await datasorce.getUser(credential);
    if (user != null) {
      return Right(user);
    } else {
      return Left(InvalidCredential());
    }
  }
}
