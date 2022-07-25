import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gbtech_blogging/modules/auth/domain/entities/user.dart';
import 'package:gbtech_blogging/modules/auth/domain/services/auth_store.dart';
import 'package:gbtech_blogging/modules/post/application/delete_post.dart';
import 'package:gbtech_blogging/modules/post/application/get_post.dart';
import 'package:gbtech_blogging/modules/post/application/get_posts.dart';
import 'package:gbtech_blogging/modules/post/application/publish_post.dart';
import 'package:gbtech_blogging/modules/post/application/update_post.dart';
import 'package:gbtech_blogging/modules/post/domain/entities/post.dart';
import 'package:gbtech_blogging/modules/post/domain/exception/exception.dart';
import 'package:gbtech_blogging/modules/post/presenter/posts/posts_bloc.dart';
import 'package:gbtech_blogging/modules/post/presenter/posts/posts_event.dart';
import 'package:gbtech_blogging/modules/post/presenter/posts/posts_state.dart';
import 'package:mocktail/mocktail.dart';

class GetPostsMock extends Mock implements GetPosts {}

class GetPostMock extends Mock implements GetPost {}

class DeletePostMock extends Mock implements DeletePost {}

class PublishPostMock extends Mock implements PublishPost {}

class UpdatePostMock extends Mock implements UpdatePost {}

class AuthStoreMock extends Mock implements AuthStore {}

void main() {
  final getPostsUsecase = GetPostsMock();
  final getPostUsecase = GetPostMock();
  final deletePostUsecase = DeletePostMock();
  final publishPostUsecase = PublishPostMock();
  final updatePostUsecase = UpdatePostMock();
  final authStoreMock = AuthStoreMock();
  final post =
      Post(idPost: 1, message: 'message', userName: 'teste', idUser: 1);
  final user = User(name: 'name', urlPicture: 'urlPicture', idUser: 0);

  setUpAll(() {
    registerFallbackValue(post);
    registerFallbackValue(user);
  });

  final postsBloc = PostsBloc(
    getPostsUsecase,
    getPostUsecase,
    deletePostUsecase,
    publishPostUsecase,
    updatePostUsecase,
    authStoreMock,
  );

  void registerGetPosts() {
    when(() => getPostsUsecase()).thenAnswer(
      (_) async => const Right(<Post>[]),
    );
  }

  group('get posts', () {
    test('Deve retornar error ao buscar posts sem cache', () async {
      when(() => getPostsUsecase()).thenAnswer(
        (_) async => Left(NotFoundException()),
      );
      expect(
        postsBloc.stream,
        emitsInOrder([
          isA<PostsLoading>(),
          isA<PostsError>(),
        ]),
      );
      postsBloc.add(PostsLoad());
    });

    test('Deve retornar os estados na ordem correta ao buscar posts', () async {
      registerGetPosts();
      expect(
        postsBloc.stream,
        emitsInOrder([
          isA<PostsLoading>(),
          isA<PostsSuccess>(),
        ]),
      );
      postsBloc.add(PostsLoad());
    });
  });

  group('update post', () {
    test('Deve retornar os estados na ordem correta ao atualizar um post',
        () async {
      registerGetPosts();
      when(
        () => updatePostUsecase.call(
          currentUser: any(
            named: 'currentUser',
          ),
          idPost: any(named: 'idPost'),
          message: any(named: 'message'),
        ),
      ).thenAnswer(
        (_) async => Right(Post(userName: '', message: 'message', idUser: 0)),
      );
      expect(
        postsBloc.stream,
        emitsInOrder([
          isA<PostsUpdateLoading>(),
          isA<PostsUpdateSuccess>(),
          isA<PostsLoading>(),
          isA<PostsSuccess>(),
        ]),
      );
      postsBloc.add(
        PostsChangePost(
          currentUser: User(name: 'name', urlPicture: 'urlPicture', idUser: 0),
          idPost: 0,
          message: '',
        ),
      );
    });

    test('Deve retornar error ao atualizar um post', () async {
      when(() => updatePostUsecase(
            currentUser: any(
              named: 'currentUser',
            ),
            idPost: any(named: 'idPost'),
            message: any(named: 'message'),
          )).thenAnswer(
        (_) async => Left(NotFoundException()),
      );
      expect(
        postsBloc.stream,
        emitsInOrder([
          isA<PostsUpdateLoading>(),
          isA<PostsError>(),
        ]),
      );
      postsBloc.add(
        PostsChangePost(
          currentUser: User(name: 'name', urlPicture: 'urlPicture', idUser: 0),
          idPost: 0,
          message: '',
        ),
      );
    });
  });

  group('create post', () {
    test('Deve retornar os estados na ordem correta ao criar um post',
        () async {
      registerGetPosts();
      when(
        () => publishPostUsecase.call(
          currentUser: any(
            named: 'currentUser',
          ),
          message: any(named: 'message'),
        ),
      ).thenAnswer(
        (_) async => Right(Post(userName: '', message: 'message', idUser: 0)),
      );
      expect(
        postsBloc.stream,
        emitsInOrder([
          isA<PostsCreateLoading>(),
          isA<PostsCreateSuccess>(),
          isA<PostsLoading>(),
          isA<PostsSuccess>(),
        ]),
      );
      postsBloc.add(
        PostsCreatePost(
          currentUser: User(name: 'name', urlPicture: 'urlPicture', idUser: 0),
          message: '',
        ),
      );
    });

    test('Deve retornar error ao criar um post', () async {
      when(() => publishPostUsecase(
            currentUser: any(
              named: 'currentUser',
            ),
            message: any(named: 'message'),
          )).thenAnswer(
        (_) async => Left(NotFoundException()),
      );
      expect(
        postsBloc.stream,
        emitsInOrder([
          isA<PostsCreateLoading>(),
          isA<PostsError>(),
        ]),
      );
      postsBloc.add(
        PostsCreatePost(
          currentUser: User(name: 'name', urlPicture: 'urlPicture', idUser: 0),
          message: '',
        ),
      );
    });
  });

  group('delete post', () {
    test('Deve retornar os estados na ordem correta ao remover um post',
        () async {
      registerGetPosts();
      when(
        () => deletePostUsecase.call(
          currentUser: any(
            named: 'currentUser',
          ),
          idPost: any(named: 'idPost'),
        ),
      ).thenAnswer(
        (_) async => const Right(true),
      );
      expect(
        postsBloc.stream,
        emitsInOrder([
          isA<PostsDeleteLoading>(),
          isA<PostsDeleteSuccess>(),
          isA<PostsLoading>(),
          isA<PostsLoadSuccess>(),
        ]),
      );
      postsBloc.add(
        PostsRemovePost(
          currentUser: User(name: 'name', urlPicture: 'urlPicture', idUser: 0),
          idPost: 0,
        ),
      );
    });

    test('Deve retornar error ao criar um post', () async {
      when(
        () => deletePostUsecase.call(
          currentUser: any(
            named: 'currentUser',
          ),
          idPost: any(named: 'idPost'),
        ),
      ).thenAnswer(
        (_) async => Left(NotFoundException()),
      );
      expect(
        postsBloc.stream,
        emitsInOrder([
          isA<PostsDeleteLoading>(),
          isA<PostsError>(),
        ]),
      );
      postsBloc.add(
        PostsRemovePost(
          currentUser: User(name: 'name', urlPicture: 'urlPicture', idUser: 0),
          idPost: 0,
        ),
      );
    });
  });
}
