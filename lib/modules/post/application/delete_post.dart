import 'package:dartz/dartz.dart';

import '../../auth/domain/entities/user.dart';
import '../domain/exception/exception.dart';
import '../domain/repositories/post_repository.dart';

class DeletePost {
  final PostRepository repository;

  DeletePost({required this.repository});

  Future<Either<PostException, bool>> call({
    required User currentUser,
    required int idPost,
  }) async {
    final resultGetPost = await repository.getPost(idPost);
    return resultGetPost.fold(
      (exception) => Left(exception),
      (postSaved) {
        if (postSaved.idUser != currentUser.idUser) {
          return Left(InvalidUserRole());
        }
        return repository.deletePost(idPost);
      },
    );
  }
}
