import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gbtech_blogging/modules/auth/application/sign_up.dart';
import 'package:gbtech_blogging/modules/auth/domain/entities/credential.dart';
import 'package:gbtech_blogging/modules/auth/domain/entities/user.dart';
import 'package:gbtech_blogging/modules/auth/domain/exception/exception.dart';
import 'package:gbtech_blogging/modules/auth/domain/repositories/sign_up_repository.dart';
import 'package:mocktail/mocktail.dart';

class SignUpRepositoryMock extends Mock implements SignUpRepository {}

class CredentialMock extends Mock implements Credential {}

void main() {
  final repositoryMock = SignUpRepositoryMock();
  final signUp = SignUp(repository: repositoryMock);

  setUpAll(() {
    registerFallbackValue(CredentialMock());
  });

  test('Deve realizar o cadastro', () async {
    when(() => repositoryMock.signUp(credential: any(named: 'credential')))
        .thenAnswer(
      (invocation) async => Right(
        User(name: 'name', urlPicture: 'urlPicture', idUser: 0),
      ),
    );
    var result = await signUp('teste@gbtechblogging.io', '123', 'teste');
    expect(result.fold(id, id), isA<User>());
  });

  test('Deve retormar um InvalidNameException ao passar um nome inválido',
      () async {
    var result = await signUp('teste@gbtechblogging.io', '123', '   ');
    expect(result.fold(id, id), isA<InvalidNameException>());
  });

  test('Deve retormar um InvalidEmailException ao passar um e-mail inválido',
      () async {
    var result = await signUp('teste@', '123', 'teste');
    expect(result.fold(id, id), isA<InvalidEmailException>());
  });

  test(
      'Deve retormar um InvalidPasswordException ao passar um e-mail válido e uma senha inválida',
      () async {
    var result = await signUp('teste@gbtechblogging.io', '12', 'teste');
    expect(result.fold(id, id), isA<InvalidPasswordException>());
  });

  test(
      'Deve retormar um InvalidEmailException ao passar e-mail e senha inválidos',
      () async {
    var result = await signUp('teste@', '12', 'teste');
    expect(result.fold(id, id), isA<InvalidEmailException>());
  });
}
