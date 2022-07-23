import '../../../auth/domain/entities/user.dart';

abstract class PostsEvent {}

class PostsLoad implements PostsEvent {}

class PostsChangePost implements PostsEvent {
  final User? currentUser;
  final int idPost;
  final String message;

  PostsChangePost({
    required this.currentUser,
    required this.idPost,
    required this.message,
  });
}

class PostsCreatePost implements PostsEvent {
  final User? currentUser;
  final String message;

  PostsCreatePost({
    required this.currentUser,
    required this.message,
  });
}

class PostsRemovePost implements PostsEvent {
  final User? currentUser;
  final int idPost;

  PostsRemovePost({
    required this.currentUser,
    required this.idPost,
  });
}
