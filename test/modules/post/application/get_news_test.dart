import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gbtech_blogging/modules/post/application/get_news.dart';
import 'package:gbtech_blogging/modules/post/domain/entities/post.dart';
import 'package:gbtech_blogging/modules/post/domain/repositories/post_repository.dart';
import 'package:mocktail/mocktail.dart';

class PostRepositoryMock extends Mock implements PostRepository {}

void main() {
  final repositoryMock = PostRepositoryMock();
  final getNews = GetNews(repository: repositoryMock);

  test('Deve retornar uma lista de Posts', () async {
    when(() => repositoryMock.getNews())
        .thenAnswer((invocation) async => const Right(<Post>[]));
    var result = await getNews();
    expect(result.fold(id, id), isA<List<Post>>());
  });
}
