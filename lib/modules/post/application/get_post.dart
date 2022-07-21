import 'package:dartz/dartz.dart';

import '../domain/entities/post.dart';
import '../domain/exception/exception.dart';
import '../domain/repositories/post_repository.dart';

class GetPost {
  final PostRepository repository;

  GetPost({required this.repository});

  Future<Either<PostException, Post>> call(int idPost) {
    return repository.getPost(idPost);
  }
}
