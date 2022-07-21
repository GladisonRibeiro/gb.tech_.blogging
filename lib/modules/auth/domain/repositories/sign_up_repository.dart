import 'package:dartz/dartz.dart';

import '../entities/credential.dart';
import '../entities/user.dart';
import '../exception/exception.dart';

abstract class SignUpRepository {
  Future<Either<AuthException, User>> signUp({required Credential credential});
}
