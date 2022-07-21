import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gbtech_blogging/modules/auth/application/login.dart';
import 'package:gbtech_blogging/modules/auth/domain/entities/credential.dart';
import 'package:gbtech_blogging/modules/auth/domain/entities/user.dart';
import 'package:gbtech_blogging/modules/auth/domain/exception/exception.dart';
import 'package:gbtech_blogging/modules/auth/domain/repositories/login_repository.dart';
import 'package:mocktail/mocktail.dart';

class LoginRepositoryMock extends Mock implements LoginRepository {}

class CredentialMock extends Mock implements Credential {}

void main() {
  final repositoryMock = LoginRepositoryMock();
  final login = Login(repository: repositoryMock);
  const validEmail = 'teste@gbtechblogging.io';

  setUpAll(() {
    registerFallbackValue(CredentialMock());
  });

  test('Deve realizar o login', () async {
    when(() => repositoryMock.login(credential: any(named: 'credential')))
        .thenAnswer(
      (invocation) async => Right(User(name: 'name', urlPicture: 'urlPicture')),
    );
    var result = await login(validEmail, '123');
    expect(result.fold(id, id), isA<User>());
  });

  test('Deve retormar um InvalidEmailException ao passar um e-mail inválido',
      () async {
    var result = await login('teste@', '123');
    expect(result.fold(id, id), isA<InvalidEmailException>());
  });

  test(
      'Deve retormar um InvalidPasswordException ao passar um e-mail válido e uma senha inválida',
      () async {
    var result = await login(validEmail, '12');
    expect(result.fold(id, id), isA<InvalidPasswordException>());
  });

  test(
      'Deve retormar um InvalidEmailException ao passar e-mail e senha inválidos',
      () async {
    var result = await login('teste@', '12');
    expect(result.fold(id, id), isA<InvalidEmailException>());
  });
}
