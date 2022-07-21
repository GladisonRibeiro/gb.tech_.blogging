import 'package:flutter_test/flutter_test.dart';
import 'package:gbtech_blogging/modules/auth/domain/entities/credential.dart';
import 'package:gbtech_blogging/modules/auth/domain/exception/exception.dart';

void main() {
  test('Deve criar uma credential válida', () async {
    var credential =
        Credential(email: 'teste@gbtechblogging.io', password: '123456');
    expect(
      credential,
      isA<Credential>(),
    );
  });

  test(
      'Deve retormar um InvalidEmailException ao criar uma credential com e-mail inválido',
      () async {
    expect(
      () => Credential(email: 'teste@', password: '123456'),
      throwsA(isA<InvalidEmailException>()),
    );
  });

  test(
      'Deve retormar um InvalidPasswordException ao criar uma credential com uma senha inválida',
      () async {
    expect(
      () => Credential(email: 'teste@gbtechblogging.io', password: '12'),
      throwsA(isA<InvalidPasswordException>()),
    );
  });
}
