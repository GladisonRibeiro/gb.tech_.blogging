import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gbtech_blogging/modules/auth/application/sign_up.dart';
import 'package:gbtech_blogging/modules/auth/domain/entities/user.dart';
import 'package:gbtech_blogging/modules/auth/domain/exception/exception.dart';
import 'package:gbtech_blogging/modules/auth/presenter/sign_up/sign_up_bloc.dart';
import 'package:gbtech_blogging/modules/auth/presenter/sign_up/sign_up_event.dart';
import 'package:gbtech_blogging/modules/auth/presenter/sign_up/sign_up_state.dart';
import 'package:mocktail/mocktail.dart';

class SignUpMock extends Mock implements SignUp {}

void main() {
  final signUpUsecase = SignUpMock();
  final signUpBloc = SignUpBloc(signUpUsecase);

  test('Deve retornar os estados na ordem correta', () async {
    when(() => signUpUsecase(any(), any(), any())).thenAnswer(
      (_) async => Right(User(name: '', urlPicture: '', idUser: 0)),
    );
    expect(
      signUpBloc.stream,
      emitsInOrder([
        isA<SignUpLoading>(),
        isA<SignUpSuccess>(),
      ]),
    );
    signUpBloc
        .add(SignUpSubmitPressed('teste', 'gb.tech@blogging.io', 'abcd1234'));
  });

  test('Deve retornar error', () async {
    when(() => signUpUsecase(any(), any(), any())).thenAnswer(
      (_) async => Left(InvalidNameException()),
    );
    expect(
      signUpBloc.stream,
      emitsInOrder([
        isA<SignUpLoading>(),
        isA<SignUpError>(),
      ]),
    );
    signUpBloc.add(SignUpSubmitPressed('', '', ''));
  });
}
