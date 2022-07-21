import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gbtech_blogging/modules/auth/domain/entities/user.dart';
import 'package:gbtech_blogging/modules/post/application/publish_post.dart';
import 'package:gbtech_blogging/modules/post/domain/entities/post.dart';
import 'package:gbtech_blogging/modules/post/domain/exception/exception.dart';
import 'package:gbtech_blogging/modules/post/domain/repositories/post_repository.dart';
import 'package:mocktail/mocktail.dart';

class PostRepositoryMock extends Mock implements PostRepository {}

void main() {
  final repositoryMock = PostRepositoryMock();
  final publishPost = PublishPost(repository: repositoryMock);

  setUpAll(() {
    registerFallbackValue(
      Post(message: 'message', userName: 'teste', idUser: 0),
    );
  });

  test('Deve publicar um Post', () async {
    when(() => repositoryMock.publishPost(any())).thenAnswer(
      (invocation) async => Right(
        Post(message: 'message', userName: 'teste', idUser: 0),
      ),
    );
    var result = await publishPost(
      currentUser: User(name: '', urlPicture: '', idUser: 0),
      message: 'message',
    );
    expect(result.fold(id, id), isA<Post>());
  });

  test(
      'Deve retornar um InvalidMessageException ao publicar um Post com uma mensagem inválida',
      () async {
    expect(
      () => Post(
        userName: 'teste',
        message: '',
        idUser: 0,
      ),
      throwsA(isA<InvalidMessageException>()),
    );

    when(() => repositoryMock.publishPost(any())).thenAnswer(
      (invocation) async => Left(
        InvalidMessageException(),
      ),
    );
    var result = await publishPost(
      currentUser: User(name: '', urlPicture: '', idUser: 0),
      message: '',
    );
    expect(result.fold(id, id), isA<InvalidMessageException>());
  });
}
