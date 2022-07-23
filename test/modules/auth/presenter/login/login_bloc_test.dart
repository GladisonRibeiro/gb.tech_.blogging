import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gbtech_blogging/modules/auth/application/login.dart';
import 'package:gbtech_blogging/modules/auth/domain/entities/user.dart';
import 'package:gbtech_blogging/modules/auth/domain/exception/exception.dart';
import 'package:gbtech_blogging/modules/auth/presenter/login/login_bloc.dart';
import 'package:gbtech_blogging/modules/auth/presenter/login/login_event.dart';
import 'package:gbtech_blogging/modules/auth/presenter/login/login_state.dart';
import 'package:mocktail/mocktail.dart';

class LoginMock extends Mock implements Login {}

void main() {
  final loginUsecase = LoginMock();
  final loginBloc = LoginBloc(loginUsecase);

  test('Deve retornar os estados na ordem correta', () async {
    when(() => loginUsecase.call(any(), any())).thenAnswer(
      (_) async => Right(User(name: '', urlPicture: '', idUser: 0)),
    );
    expect(
      loginBloc.stream,
      emitsInOrder([
        isA<LoginLoading>(),
        isA<LoginSuccess>(),
      ]),
    );
    loginBloc.add(LoginSubmitPressed('gb.tech@blogging.io', 'abcd1234'));
  });

  test('Deve retornar error', () async {
    when(() => loginUsecase.call(any(), any())).thenAnswer(
      (_) async => Left(InvalidCredential()),
    );
    expect(
      loginBloc.stream,
      emitsInOrder([
        isA<LoginLoading>(),
        isA<LoginError>(),
      ]),
    );
    loginBloc.add(LoginSubmitPressed('', ''));
  });
}
