import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:modular_bloc_bind/modular_bloc_bind.dart';

import '../shared/shared_module.dart';
import 'application/delete_post.dart';
import 'application/get_news.dart';
import 'application/get_post.dart';
import 'application/get_posts.dart';
import 'application/publish_post.dart';
import 'application/update_post.dart';
import 'guards/auth_guard.dart';
import 'infra/repositories/post_repository_http.dart';
import 'infra/repositories/post_repository_memory.dart';
import 'presenter/home/home_page.dart';
import 'presenter/news/news_bloc.dart';
import 'presenter/news/news_page.dart';
import 'presenter/posts/posts_bloc.dart';
import 'presenter/posts/posts_page.dart';

class PostModule extends Module {
  @override
  List<Module> get imports => [SharedModule()];

  @override
  List<Bind<Object>> get binds => [
        Bind((i) => PostRepositoryHttp(i())),
        Bind((i) => PostRepositoryMemory()),
        Bind((i) => GetNews(repository: i<PostRepositoryHttp>())),
        Bind((i) => DeletePost(repository: i<PostRepositoryMemory>())),
        Bind((i) => GetPost(repository: i<PostRepositoryMemory>())),
        Bind((i) => GetPosts(repository: i<PostRepositoryMemory>())),
        Bind((i) => PublishPost(repository: i<PostRepositoryMemory>())),
        Bind((i) => UpdatePost(repository: i<PostRepositoryMemory>())),
        BlocBind.singleton((i) => NewsBloc(i())),
        BlocBind.singleton((i) => PostsBloc(i(), i(), i(), i(), i(), i())),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          '/',
          child: (context, args) => const HomePage(),
          children: [
            ChildRoute(
              '/posts',
              child: (context, args) => const PostsPage(),
              transition: TransitionType.leftToRight,
            ),
            ChildRoute(
              '/news',
              child: (context, args) => const NewsPage(),
              transition: TransitionType.rightToLeft,
            ),
            RedirectRoute('/redirect', to: '/post/posts'),
          ],
          guards: [AuthGuard()],
        ),
        WildcardRoute(
          child: (context, args) => const Scaffold(
            body: Center(
              child: Text('Página não encontrada!'),
            ),
          ),
        ),
      ];
}
