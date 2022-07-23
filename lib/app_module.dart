import 'package:flutter_modular/flutter_modular.dart';

import 'modules/auth/auth_module.dart';
import 'modules/auth/domain/services/auth_store.dart';
import 'modules/auth/infra/services/auth_store_memory.dart';
import 'modules/post/post_module.dart';
import 'splash_page.dart';

class AppModule extends Module {
  @override
  List<Bind<Object>> get binds => [
        Bind<AuthStore>((i) => AuthStoreMemory()),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          '/',
          child: (context, args) => const SplashPage(),
          transition: TransitionType.downToUp,
          duration: const Duration(milliseconds: 500),
        ),
        ModuleRoute('/auth', module: AuthModule()),
        ModuleRoute('/post', module: PostModule()),
      ];
}
