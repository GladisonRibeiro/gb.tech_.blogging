import 'package:dartz/dartz.dart' as dartz;
import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gbtech_blogging/modules/auth/application/login.dart';
import 'package:gbtech_blogging/modules/auth/auth_module.dart';
import 'package:gbtech_blogging/modules/auth/domain/entities/user.dart';
import 'package:gbtech_blogging/modules/auth/infra/repositories/login_repository_http.dart';
import 'package:mocktail/mocktail.dart';
import 'package:modular_test/modular_test.dart';

class DioMock extends Mock implements Dio {}

class ModularNavigateMock extends Mock implements IModularNavigator {}

void main() {
  final dio = DioMock();
  final navigate = ModularNavigateMock();
  Modular.navigatorDelegate = navigate;

  initModule(AuthModule(), replaceBinds: [
    Bind.instance<Dio>(dio),
  ]);

  test('Deve realizar o login', () async {
    final login = Modular.get<Login>();
    final loginRepository = Modular.get<LoginRepositoryHttp>();
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

    final result = await login('gb.tech@blogging.io', 'abcd1234');
    expect(result.fold(dartz.id, dartz.id), isA<User>());
  });
}
