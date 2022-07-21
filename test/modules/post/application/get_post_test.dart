import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gbtech_blogging/modules/post/application/get_post.dart';
import 'package:gbtech_blogging/modules/post/domain/entities/post.dart';
import 'package:gbtech_blogging/modules/post/domain/exception/exception.dart';
import 'package:gbtech_blogging/modules/post/domain/repositories/post_repository.dart';
import 'package:mocktail/mocktail.dart';

class PostRepositoryMock extends Mock implements PostRepository {}

void main() {
  final repositoryMock = PostRepositoryMock();
  final getPost = GetPost(repository: repositoryMock);

  test('Deve retornar um Post', () async {
    when(() => repositoryMock.getPost(any())).thenAnswer(
      (invocation) async => Right(Post(userName: 'teste', message: 'message')),
    );
    var result = await getPost(1);
    expect(result.fold(id, id), isA<Post>());
  });

  test('Deve retornar um NotFoundException caso não encontre o post', () async {
    when(() => repositoryMock.getPost(any())).thenAnswer(
      (invocation) async => Left(NotFoundException()),
    );
    var result = await getPost(0);
    expect(result.fold(id, id), isA<NotFoundException>());
  });
}
