import '../../domain/entities/user.dart';
import '../../domain/exception/exception.dart';

abstract class LoginState {}

class LoginSuccess implements LoginState {
  final User user;

  LoginSuccess(this.user);
}

class LoginStart implements LoginState {}

class LoginLoading implements LoginState {}

class LoginError implements LoginState {
  final AuthException exception;

  LoginError(this.exception);
}
