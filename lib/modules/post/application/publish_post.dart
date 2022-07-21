import 'package:dartz/dartz.dart';
import 'package:gbtech_blogging/modules/post/domain/exception/exception.dart';
import 'package:gbtech_blogging/modules/post/domain/repositories/post_repository.dart';

import '../../auth/domain/entities/user.dart';
import '../domain/entities/post.dart';

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
