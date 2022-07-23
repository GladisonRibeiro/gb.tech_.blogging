import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'application/login.dart';
import 'application/sign_up.dart';
import 'infra/repositories/login_repository_http.dart';
import 'infra/repositories/sign_up_repository_http.dart';
import 'presenter/login/login_bloc.dart';
import 'presenter/login/login_page.dart';
import 'presenter/sign_up/sign_up_page.dart';

class AuthModule extends Module {
  @override
  List<Bind<Object>> get binds => [
        Bind.factory<Dio>((i) => Dio()),
        Bind((i) => LoginRepositoryHttp(i())),
        Bind((i) => Login(repository: i())),
        Bind((i) => SignUpRepositoryHttp(i())),
        Bind((i) => SignUp(repository: i())),
        Bind((i) => LoginBloc(i())),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) => const LoginPage()),
        ChildRoute('/sign_up', child: (context, args) => SignUpPage()),
      ];
}
