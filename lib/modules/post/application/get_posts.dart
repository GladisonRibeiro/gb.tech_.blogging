import 'package:dartz/dartz.dart';

import '../domain/entities/post.dart';
import '../domain/exception/exception.dart';
import '../domain/repositories/post_repository.dart';

class GetPosts {
  final PostRepository repository;

  GetPosts({required this.repository});

  Future<Either<PostException, List<Post>>> call() {
    return repository.getPosts();
  }
}
