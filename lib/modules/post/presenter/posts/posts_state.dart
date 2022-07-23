import '../../domain/entities/post.dart';
import '../../domain/exception/exception.dart';

abstract class PostsState {}

class PostsSuccess extends PostsState {}

class PostsLoadSuccess implements PostsSuccess {
  final List<Post> posts;

  PostsLoadSuccess({required this.posts});
}

class PostsUpdateSuccess implements PostsSuccess {
  final Post post;

  PostsUpdateSuccess({required this.post});
}

class PostsCreateSuccess implements PostsSuccess {
  final Post post;

  PostsCreateSuccess({required this.post});
}

class PostsDeleteSuccess implements PostsSuccess {
  final bool status;

  PostsDeleteSuccess({required this.status});
}

class PostsStart extends PostsState {}

class PostsLoading implements PostsState {}

class PostsError implements PostsState {
  final PostException exception;

  PostsError(this.exception);
}
