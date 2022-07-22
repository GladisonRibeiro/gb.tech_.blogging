import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gbtech_blogging/modules/auth/domain/entities/credential.dart';
import 'package:gbtech_blogging/modules/auth/domain/entities/user.dart';
import 'package:gbtech_blogging/modules/auth/domain/exception/exception.dart';
import 'package:gbtech_blogging/modules/auth/infra/repositories/login_repository_http.dart';
import 'package:mocktail/mocktail.dart';

class DioMock extends Mock implements Dio {}

void main() {
  final dio = DioMock();
  final loginRepository = LoginRepositoryHttp(dio);

  test('Deve realizar o login', () async {
    when(() => dio.get("${loginRepository.loginUrl}?email=gb.tech@blogging.io"))
        .thenAnswer(
      (_) async => Response(
        data: [
          {
            "id": 4,
            "profile_picture": "",
            "name": "gb.tech_",
            "email": "gb.tech@blogging.io",
            "password": "YWJjZDEyMzQ="
          }
        ],
        statusCode: 200,
        requestOptions: RequestOptions(
          path: loginRepository.loginUrl,
        ),
      ),
    );

    var result = await loginRepository.login(
      credential: Credential(
        email: 'gb.tech@blogging.io',
        password: 'abcd1234',
      ),
    );
    expect(result.fold(id, id), isA<User>());
  });

  test('Deve retornar InvalidCredential ao passar credenciais inválidas',
      () async {
    when(() => dio.get("${loginRepository.loginUrl}?email=gb.tech@blogging.io"))
        .thenAnswer(
      (_) async => Response(
        data: [
          {
            "id": 4,
            "profile_picture": "",
            "name": "gb.tech_",
            "email": "gb.tech@blogging.io",
            "password": "YWJjZDEyMzJ="
          }
        ],
        statusCode: 200,
        requestOptions: RequestOptions(
          path: loginRepository.loginUrl,
        ),
      ),
    );

    var result = await loginRepository.login(
      credential: Credential(
        email: 'gb.tech@blogging.io',
        password: 'abcd12',
      ),
    );
    expect(result.fold(id, id), isA<InvalidCredential>());
  });

  test(
      'Deve retornar InvalidCredential ao passar credenciais de um usuário inexistente',
      () async {
    when(() => dio.get("${loginRepository.loginUrl}?email=gb.tech@blogging.io"))
        .thenAnswer(
      (_) async => Response(
        data: [],
        statusCode: 200,
        requestOptions: RequestOptions(
          path: loginRepository.loginUrl,
        ),
      ),
    );
    var result = await loginRepository.login(
      credential: Credential(
        email: 'gb.tech.123@blogging.io',
        password: 'abcd1234',
      ),
    );
    expect(result.fold(id, id), isA<InvalidCredential>());
  });

  test('Deve retornar HttpException caso ocorra um problema na rede', () async {
    when(() => dio.get("${loginRepository.loginUrl}?email=gb.tech@blogging.io"))
        .thenAnswer(
      (_) async => Response(
        data: null,
        statusCode: 500,
        requestOptions: RequestOptions(
          path: loginRepository.loginUrl,
        ),
      ),
    );
    var result = await loginRepository.login(
      credential: Credential(
        email: 'gb.tech@blogging.io',
        password: 'abcd1234',
      ),
    );
    expect(result.fold(id, id), isA<HttpException>());
  });
}
