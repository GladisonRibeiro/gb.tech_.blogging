import 'package:dartz/dartz.dart';

import '../../auth/domain/entities/user.dart';
import '../domain/entities/post.dart';
import '../domain/exception/exception.dart';
import '../domain/repositories/post_repository.dart';

class PublishPost {
  final PostRepository repository;

  PublishPost({required this.repository});

  Future<Either<PostException, Post>> call({
    required User currentUser,
    required String message,
  }) async {
    final Post post;
    try {
      post = Post(userName: currentUser.name, message: message);
    } on PostException catch (e) {
      return Left(e);
    }
    return repository.publishPost(post);
  }
}
