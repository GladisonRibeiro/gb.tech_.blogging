import '../../domain/entities/post.dart';
import '../../domain/exception/exception.dart';

abstract class NewsState {}

class NewsSuccess implements NewsState {
  final List<Post> posts;

  NewsSuccess(this.posts);
}

class NewsStart implements NewsState {}

class NewsLoading implements NewsState {}

class NewsError implements NewsState {
  final PostException exception;

  NewsError(this.exception);
}
