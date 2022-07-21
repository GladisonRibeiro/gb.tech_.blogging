import 'package:dartz/dartz.dart';

import '../domain/entities/post.dart';
import '../domain/exception/exception.dart';
import '../domain/repositories/post_repository.dart';

class GetNews {
  final PostRepository repository;

  GetNews({required this.repository});

  Future<Either<PostException, List<Post>>> call() {
    return repository.getNews();
  }
}
