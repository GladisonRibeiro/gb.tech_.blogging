import '../../domain/entities/user.dart';
import '../../domain/exception/exception.dart';

abstract class SignUpState {}

class SignUpSuccess implements SignUpState {
  final User user;

  SignUpSuccess(this.user);
}

class SignUpStart implements SignUpState {}

class SignUpLoading implements SignUpState {}

class SignUpError implements SignUpState {
  final AuthException exception;

  SignUpError(this.exception);
}
