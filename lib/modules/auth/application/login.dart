import 'package:dartz/dartz.dart';

import '../domain/entities/credential.dart';
import '../domain/entities/user.dart';
import '../domain/exception/exception.dart';
import '../domain/repositories/login_repository.dart';

class Login {
  final LoginRepository repository;

  const Login({required this.repository});

  Future<Either<AuthException, User>> call(
      String email, String password) async {
    Credential credential;
    try {
      credential = Credential(email: email, password: password);
    } on AuthException catch (e) {
      return Left(e);
    }
    return repository.login(credential: credential);
  }
}
