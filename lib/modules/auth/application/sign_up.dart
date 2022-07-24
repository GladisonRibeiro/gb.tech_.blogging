import 'package:dartz/dartz.dart';

import '../domain/entities/credential.dart';
import '../domain/entities/user.dart';
import '../domain/exception/exception.dart';
import '../domain/repositories/sign_up_repository.dart';

class SignUp {
  final SignUpRepository repository;

  const SignUp({required this.repository});

  Future<Either<AuthException, User>> call(
      String email, String password, String name) async {
    Credential credential;
    try {
      if (name.trim().isEmpty) {
        throw InvalidNameException();
      }
      credential = Credential(name: name, email: email, password: password);
    } on AuthException catch (e) {
      return Left(e);
    }
    return repository.signUp(credential: credential);
  }
}
