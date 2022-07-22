import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gbtech_blogging/modules/auth/domain/entities/credential.dart';
import 'package:gbtech_blogging/modules/auth/domain/entities/user.dart';
import 'package:gbtech_blogging/modules/auth/domain/exception/exception.dart';
import 'package:gbtech_blogging/modules/auth/infra/repositories/sign_up_repository_http.dart';
import 'package:mocktail/mocktail.dart';

class DioMock extends Mock implements Dio {}

void main() {
  final dio = DioMock();
  final signUpRepository = SignUpRepositoryHttp(dio);

  test('Deve realizar o signUp', () async {
    when(() => dio.post(
          signUpRepository.signUpUrl,
          data: any(named: 'data'),
        )).thenAnswer(
      (_) async => Response(
        data: {
          "id": 5,
        },
        statusCode: 201,
        requestOptions: RequestOptions(
          path: signUpRepository.signUpUrl,
        ),
      ),
    );

    var result = await signUpRepository.signUp(
      credential: Credential(
        email: 'gb.tech@blogging.io',
        password: 'abcd1234',
      ),
    );
    expect(result.fold(id, id), isA<User>());
  });

  test('Deve retornar HttpException caso retorne um status diferente de 200',
      () async {
    when(() => dio.post(
          signUpRepository.signUpUrl,
          data: any(named: 'data'),
        )).thenAnswer(
      (_) async => Response(
        data: null,
        statusCode: 500,
        requestOptions: RequestOptions(
          path: signUpRepository.signUpUrl,
        ),
      ),
    );

    var result = await signUpRepository.signUp(
      credential: Credential(
        email: 'gb.tech@blogging.io',
        password: 'abcd1234',
      ),
    );
    expect(result.fold(id, id), isA<HttpException>());
  });

  test('Deve retornar InvalidCredential caso ocorra um problema desconhecido',
      () async {
    when(() => dio.post(
          signUpRepository.signUpUrl,
          data: any(named: 'data'),
        )).thenThrow(Exception());

    var result = await signUpRepository.signUp(
      credential: Credential(
        email: 'gb.tech@blogging.io',
        password: 'abcd1234',
      ),
    );
    expect(result.fold(id, id), isA<InvalidCredential>());
  });
}
