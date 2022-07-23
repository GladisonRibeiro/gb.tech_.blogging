import 'package:flutter_modular/flutter_modular.dart';

import '../../auth/domain/services/auth_store.dart';

class AuthGuard extends RouteGuard {
  AuthGuard() : super(redirectTo: '/auth/');

  @override
  Future<bool> canActivate(String path, ModularRoute router) {
    return Future.value(Modular.get<AuthStore>().isLogged());
  }
}
