import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gbtech_blogging/modules/auth/domain/entities/user.dart';
import 'package:gbtech_blogging/modules/post/application/update_post.dart';
import 'package:gbtech_blogging/modules/post/domain/entities/post.dart';
import 'package:gbtech_blogging/modules/post/domain/exception/exception.dart';
import 'package:gbtech_blogging/modules/post/domain/repositories/post_repository.dart';
import 'package:mocktail/mocktail.dart';

class PostRepositoryMock extends Mock implements PostRepository {}

void main() {
  final repositoryMock = PostRepositoryMock();
  final updatePost = UpdatePost(repository: repositoryMock);
  final user = User(name: 'teste', urlPicture: '', idUser: 1);
  final post =
      Post(idPost: 1, message: 'message', userName: 'teste', idUser: 1);

  setUpAll(() {
    registerFallbackValue(post);
  });

  test('Deve atualizar um post', () async {
    when(() => repositoryMock.getPost(any())).thenAnswer(
      (invocation) async => Right(
        post,
      ),
    );
    when(() => repositoryMock.updatePost(any())).thenAnswer(
      (invocation) async => Right(Post(
          idPost: 0, message: 'message update', userName: 'teste', idUser: 1)),
    );
    var resultUpdatedPost = await updatePost(
      currentUser: user,
      idPost: 0,
      message: 'message update',
    );
    expect(resultUpdatedPost.fold(id, id), isA<Post>());
  });

  test(
      'Deve retornar um InvalidPostMessageException ao tentar atualizar um Post com uma mensagem inválida',
      () async {
    var resultUpdatedPost = await updatePost(
      currentUser: user,
      idPost: 0,
      message: '   ',
    );
    expect(resultUpdatedPost.fold(id, id), isA<InvalidMessageException>());
  });

  test(
      'Deve retornar um InvalidUserRole ao tentar atualizar um post de outro usuário',
      () async {
    when(() => repositoryMock.getPost(any())).thenAnswer(
      (invocation) async => Right(
        Post(idPost: 1, message: 'message', userName: 'teste', idUser: 1),
      ),
    );
    when(() => repositoryMock.updatePost(any())).thenAnswer(
      (invocation) async => Right(post),
    );
    var resultUpdatedPost = await updatePost(
      currentUser: User(name: 'teste', urlPicture: '', idUser: 0),
      idPost: 0,
      message: 'message update',
    );
    expect(resultUpdatedPost.fold(id, id), isA<InvalidUserRole>());
  });

  test(
      'Deve retornar um NotFoundException ao tentar atualizar um post inexistente',
      () async {
    when(() => repositoryMock.getPost(any())).thenAnswer(
      (invocation) async => Left(NotFoundException()),
    );
    when(() => repositoryMock.updatePost(any())).thenAnswer(
      (invocation) async => Right(post),
    );
    var resultUpdatedPost = await updatePost(
      currentUser: User(name: 'teste', urlPicture: '', idUser: 0),
      idPost: 0,
      message: 'message update',
    );
    expect(resultUpdatedPost.fold(id, id), isA<NotFoundException>());
  });
}
