import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gbtech_blogging/modules/auth/domain/entities/user.dart';
import 'package:gbtech_blogging/modules/post/application/delete_post.dart';
import 'package:gbtech_blogging/modules/post/domain/entities/post.dart';
import 'package:gbtech_blogging/modules/post/domain/exception/exception.dart';
import 'package:gbtech_blogging/modules/post/domain/repositories/post_repository.dart';
import 'package:mocktail/mocktail.dart';

class PostRepositoryMock extends Mock implements PostRepository {}

void main() {
  final repositoryMock = PostRepositoryMock();
  final deletePost = DeletePost(repository: repositoryMock);
  final user = User(name: 'teste', urlPicture: '', idUser: 1);

  setUpAll(() {
    when(() => repositoryMock.getPost(any())).thenAnswer(
      (invocation) async => Right(
        Post(idPost: 1, message: 'message', userName: 'teste', idUser: 1),
      ),
    );
  });

  test('Deve deletar um post', () async {
    when(() => repositoryMock.deletePost(any())).thenAnswer(
      (invocation) async => const Right(true),
    );
    var resultDeletePost = await deletePost(currentUser: user, idPost: 1);
    expect(resultDeletePost.fold(id, id), equals(true));
  });

  test(
      'Deve retornar um InvalidUserRole ao tentar deletar um post de outro usuário',
      () async {
    when(() => repositoryMock.getPost(any())).thenAnswer(
      (invocation) async => Right(
        Post(idPost: 1, message: 'message', userName: 'teste', idUser: 0),
      ),
    );
    var resultDeletePost = await deletePost(currentUser: user, idPost: 1);
    expect(resultDeletePost.fold(id, id), isA<InvalidUserRole>());
  });

  test(
      'Deve retornar um NotFoundException ao tentar deletar um post inexistente',
      () async {
    when(() => repositoryMock.getPost(any())).thenAnswer(
      (invocation) async => Left(NotFoundException()),
    );
    var resultDeletePost = await deletePost(currentUser: user, idPost: 1);
    expect(resultDeletePost.fold(id, id), isA<NotFoundException>());
  });
}
