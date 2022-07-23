import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SharedModule extends Module {
  @override
  List<Bind<Object>> get binds => [
        Bind.factory<Dio>((i) => Dio(), export: true),
      ];
}
