import 'package:dartz/dartz.dart';

import '../entities/credential.dart';
import '../entities/user.dart';
import '../exception/exception.dart';

abstract class LoginRepository {
  Future<Either<AuthException, User>> login({required Credential credential});
}
