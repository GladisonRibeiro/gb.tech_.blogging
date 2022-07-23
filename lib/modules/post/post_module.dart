import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'application/delete_post.dart';
import 'application/get_news.dart';
import 'application/get_post.dart';
import 'application/get_posts.dart';
import 'application/publish_post.dart';
import 'application/update_post.dart';
import 'infra/repositories/post_repository_http.dart';
import 'presenter/home/home_page.dart';

class PostModule extends Module {
  @override
  List<Bind<Object>> get binds => [
        Bind.factory<Dio>((i) => Dio()),
        Bind((i) => PostRepositoryHttp(i())),
        Bind((i) => DeletePost(repository: i())),
        Bind((i) => GetNews(repository: i())),
        Bind((i) => GetPost(repository: i())),
        Bind((i) => GetPosts(repository: i())),
        Bind((i) => PublishPost(repository: i())),
        Bind((i) => UpdatePost(repository: i())),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) => const HomePage()),
      ];
}