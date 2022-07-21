import 'package:dartz/dartz.dart';

import '../entities/post.dart';
import '../exception/exception.dart';

abstract class PostRepository {
  Future<Either<PostException, List<Post>>> getNews();
  Future<Either<PostException, List<Post>>> getPosts();
  Future<Either<PostException, Post>> publishPost(Post post);
  Future<Either<PostException, Post>> getPost(int idPost);
  Future<Either<PostException, Post>> updatePost(Post post);
  Future<Either<PostException, bool>> deletePost(int idPost);
}
