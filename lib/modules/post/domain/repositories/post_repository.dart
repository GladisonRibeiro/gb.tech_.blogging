import 'package:dartz/dartz.dart';

import '../entities/post.dart';
import '../exception/exception.dart';

abstract class PostRepository {
  Future<Either<PostException, List<Post>>> getNews();
  Future<Either<PostException, List<Post>>> getPosts();
}
