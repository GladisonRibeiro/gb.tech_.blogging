import 'package:dartz/dartz.dart';

import '../../domain/entities/post.dart';
import '../../domain/exception/exception.dart';
import '../../domain/repositories/post_repository.dart';

class PostRepositoryMemory implements PostRepository {
  late final List<Post> _posts;

  PostRepositoryMemory() {
    _posts = [
      Post(
        idPost: 1,
        userName: "Eliane",
        userUrlPicture:
            "https://drive.google.com/uc?export=view&id=13uewAV-h9v1n51euXv8AuF_x01W-pgwl",
        message:
            "Bom dia!, Que a sua semana seja cheia de carinho, ao lado daqueles que fazem a diferença na nossa vida.",
        idUser: 1,
        createdAt: DateTime.tryParse("2022-07-24T06:04:33Z"),
      ),
      Post(
        idPost: 2,
        userName: "Guilherme",
        userUrlPicture:
            "https://drive.google.com/uc?export=view&id=1FXDLNNYSdtcBKbURSrc3dAA_YJCJ9ZuB",
        message: "Bom dia!",
        idUser: 2,
        createdAt: DateTime.tryParse("2022-07-24T07:54:33Z"),
      ),
      Post(
        idPost: 2,
        userName: "Guilherme",
        userUrlPicture:
            "https://drive.google.com/uc?export=view&id=1FXDLNNYSdtcBKbURSrc3dAA_YJCJ9ZuB",
        message: "Otima semana a todos",
        idUser: 2,
        createdAt: DateTime.tryParse("2022-07-24T07:56:00Z"),
      ),
      Post(
        idPost: 4,
        userName: "Eliza",
        userUrlPicture:
            "https://drive.google.com/uc?export=view&id=17V_4ZY-doIfvMRNf0qiAgq8_QVydpuI6",
        message: "Boa semana ;)",
        idUser: 3,
        createdAt: DateTime.tryParse("2022-07-24T10:31:35Z"),
      ),
    ];
  }

  @override
  Future<Either<PostException, bool>> deletePost(int idPost) async {
    final result = await getPost(idPost);
    return result.fold((l) => Left(l), (r) {
      _posts.removeWhere((element) => element.idPost == idPost);
      return const Right(true);
    });
  }

  @override
  Future<Either<PostException, List<Post>>> getNews() async {
    return const Right([]);
  }

  @override
  Future<Either<PostException, Post>> getPost(int idPost) async {
    return Right(_posts.firstWhere((element) => element.idPost == idPost));
  }

  @override
  Future<Either<PostException, List<Post>>> getPosts() async {
    return Right(_posts);
  }

  @override
  Future<Either<PostException, Post>> publishPost(Post post) async {
    final newPost = Post(
      idPost: DateTime.now().millisecondsSinceEpoch,
      userName: post.userName,
      message: post.message,
      idUser: post.idUser,
    );
    _posts.add(newPost);
    return Right(newPost);
  }

  @override
  Future<Either<PostException, Post>> updatePost(Post post) async {
    final result = await getPost(post.idPost!);
    return result.fold((l) => Left(l), (r) {
      final updatePost = Post(
        idPost: r.idPost,
        userName: r.userName,
        message: post.message,
        idUser: r.idUser,
        createdAt: r.createdDate,
        updateDate: DateTime.now(),
      );
      _posts.removeWhere((element) => element.idPost == post.idPost);
      _posts.add(updatePost);
      return Right(updatePost);
    });
  }
}
