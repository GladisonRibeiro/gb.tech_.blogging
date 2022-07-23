import 'dart:convert';

import 'package:dartz/dartz.dart' as dartz;
import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gbtech_blogging/modules/post/application/get_posts.dart';
import 'package:gbtech_blogging/modules/post/domain/entities/post.dart';
import 'package:gbtech_blogging/modules/post/infra/repositories/post_repository_http.dart';
import 'package:gbtech_blogging/modules/post/post_module.dart';
import 'package:mocktail/mocktail.dart';
import 'package:modular_test/modular_test.dart';

import 'utils/utils.dart';

class DioMock extends Mock implements Dio {}

class ModularNavigateMock extends Mock implements IModularNavigator {}

void main() {
  final dio = DioMock();
  final navigate = ModularNavigateMock();
  Modular.navigatorDelegate = navigate;

  initModule(PostModule(), replaceBinds: [
    Bind.instance<Dio>(dio),
  ]);

  test('Deve listar Posts', () async {
    final getPosts = Modular.get<GetPosts>();
    final postRepository = Modular.get<PostRepositoryHttp>();
    when(() => dio.get(postRepository.postUrl)).thenAnswer(
      (_) async => Response(
        data: jsonDecode(postsJson),
        statusCode: 200,
        requestOptions: RequestOptions(
          path: postRepository.postUrl,
        ),
      ),
    );

    final result = await getPosts();
    expect(result.fold(dartz.id, dartz.id), isA<List<Post>>());
  });
}
