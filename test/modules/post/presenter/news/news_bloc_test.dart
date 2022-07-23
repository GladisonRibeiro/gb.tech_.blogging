import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gbtech_blogging/modules/post/application/get_news.dart';
import 'package:gbtech_blogging/modules/post/domain/entities/post.dart';
import 'package:gbtech_blogging/modules/post/domain/exception/exception.dart';
import 'package:gbtech_blogging/modules/post/presenter/news/news_bloc.dart';
import 'package:gbtech_blogging/modules/post/presenter/news/news_event.dart';
import 'package:gbtech_blogging/modules/post/presenter/news/news_state.dart';
import 'package:mocktail/mocktail.dart';

class GetNewsMock extends Mock implements GetNews {}

void main() {
  final getNewsUsecase = GetNewsMock();
  final newsBloc = NewsBloc(getNewsUsecase);
  List<Post> posts = <Post>[];

  test('Deve retornar os estados na ordem correta', () async {
    when(() => getNewsUsecase.call()).thenAnswer(
      (_) async => Right(posts),
    );
    expect(
      newsBloc.stream,
      emitsInOrder([
        isA<NewsLoading>(),
        isA<NewsSuccess>(),
      ]),
    );
    newsBloc.add(NewsLoad());
  });

  test('Deve retornar error', () async {
    when(() => getNewsUsecase.call()).thenAnswer(
      (_) async => Left(NotFoundException()),
    );
    expect(
      newsBloc.stream,
      emitsInOrder([
        isA<NewsLoading>(),
        isA<NewsError>(),
      ]),
    );
    newsBloc.add(NewsLoad());
  });
}
