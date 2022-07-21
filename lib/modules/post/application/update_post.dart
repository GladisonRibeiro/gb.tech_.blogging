import 'package:dartz/dartz.dart';

import '../../auth/domain/entities/user.dart';
import '../domain/entities/post.dart';
import '../domain/exception/exception.dart';
import '../domain/repositories/post_repository.dart';

class UpdatePost {
  final PostRepository repository;

  UpdatePost({required this.repository});

  Future<Either<PostException, Post>> call({
    required User currentUser,
    required int idPost,
    required String message,
  }) async {
    if (!Post.isValidMessage(message)) {
      return Left(InvalidMessageException());
    }

    final resultGetPost = await repository.getPost(idPost);
    return resultGetPost.fold(
      (exception) => Left(exception),
      (postSaved) {
        if (postSaved.idUser != currentUser.idUser) {
          return Left(InvalidUserRole());
        }
        Post post = Post(
          idPost: postSaved.idPost,
          userName: postSaved.userName,
          createdAt: postSaved.createdDate,
          idUser: postSaved.idUser,
          userUrlPicture: currentUser.urlPicture,
          updateDate: DateTime.now(),
          message: message,
        );
        return repository.updatePost(post);
      },
    );
  }
}
