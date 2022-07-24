import 'package:flutter_modular/flutter_modular.dart';
import 'package:modular_bloc_bind/modular_bloc_bind.dart';

import '../shared/shared_module.dart';
import 'application/login.dart';
import 'application/sign_up.dart';
import 'infra/datasources/auth_datasource_memory.dart';
import 'infra/repositories/login_repository_memory.dart';
import 'infra/repositories/sign_up_repository_memory.dart';
import 'presenter/login/login_bloc.dart';
import 'presenter/login/login_page.dart';
import 'presenter/sign_up/sign_up_bloc.dart';
import 'presenter/sign_up/sign_up_page.dart';

class AuthModule extends Module {
  @override
  List<Module> get imports => [SharedModule()];

  @override
  List<Bind<Object>> get binds => [
        Bind.singleton((i) => AuthDatasourceMemory()),
        Bind((i) => LoginRepositoryMemory(i())),
        Bind((i) => Login(repository: i())),
        Bind((i) => SignUpRepositoryMemory(i())),
        Bind((i) => SignUp(repository: i())),
        BlocBind.singleton((i) => LoginBloc(i(), i())),
        BlocBind.singleton((i) => SignUpBloc(i(), i())),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) => const LoginPage()),
        ChildRoute('/sign_up', child: (context, args) => const SignUpPage()),
      ];
}
