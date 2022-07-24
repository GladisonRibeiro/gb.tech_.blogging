import 'package:dartz/dartz.dart';

import '../../domain/entities/credential.dart';
import '../../domain/entities/user.dart';
import '../../domain/exception/exception.dart';
import '../../domain/repositories/sign_up_repository.dart';
import '../datasources/auth_datasource.dart';

class SignUpRepositoryMemory implements SignUpRepository {
  final AuthDatasorce datasorce;

  SignUpRepositoryMemory(this.datasorce);

  @override
  Future<Either<AuthException, User>> signUp({
    required Credential credential,
  }) async {
    try {
      final user = await datasorce.addUser(credential);
      return Right(user);
    } catch (e) {
      return Left(InvalidCredential());
    }
  }
}
