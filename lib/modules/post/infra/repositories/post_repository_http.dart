import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../domain/entities/post.dart';
import '../../domain/exception/exception.dart';
import '../../domain/repositories/post_repository.dart';

class PostRepositoryHttp implements PostRepository {
  final Dio dio;
  final postUrl =
      'https://my-json-server.typicode.com/gladisonribeiro/gladisonribeiro.github.io/posts';
  final newsUrl = "https://gb-mobile-app-teste.s3.amazonaws.com/data.json";

  PostRepositoryHttp(this.dio);

  Post postFromMap(Map<String, dynamic> map) {
    return Post(
      userName: map["user"]["name"],
      message: map["message"]["content"],
      createdAt: DateTime.tryParse(map["message"]["created_at"]),
      userUrlPicture: map["user"]["profile_picture"],
      idPost: (map["id"] ?? 0) as int,
      idUser: (map["user"]["id"] ?? 0) as int,
      updateDate: DateTime.tryParse(map["update_date"] ?? ''),
    );
  }

  Map<String, dynamic> postToMap(Post post) {
    return <String, dynamic>{
      "id": post.idPost,
      'update_date': post.updateDate?.toIso8601String(),
      "user": {
        "id": post.idUser,
        "name": post.userName,
        "profile_picture": post.userUrlPicture
      },
      "message": {
        "content": post.message,
        "created_at": post.createdDate.toIso8601String(),
      }
    };
  }

  @override
  Future<Either<PostException, bool>> deletePost(int idPost) async {
    try {
      final response = await dio.delete("$postUrl/$idPost");
      if (response.statusCode == 200) {
        return const Right(true);
      } else {
        return Left(HttpException());
      }
    } catch (e) {
      return Left(NotFoundException());
    }
  }

  @override
  Future<Either<PostException, List<Post>>> getNews() async {
    try {
      final response = await dio.get(newsUrl);
      if (response.statusCode == 200) {
        final list = (response.data["news"] as List)
            .map((postMap) => postFromMap(postMap))
            .toList();
        return Right(list);
      } else {
        return Left(HttpException());
      }
    } catch (e) {
      return Left(NotFoundException());
    }
  }

  @override
  Future<Either<PostException, Post>> getPost(int idPost) async {
    try {
      final response = await dio.get("$postUrl/$idPost");
      if (response.statusCode == 200) {
        final post = postFromMap(response.data);
        return Right(post);
      } else {
        return Left(HttpException());
      }
    } catch (e) {
      return Left(NotFoundException());
    }
  }

  @override
  Future<Either<PostException, List<Post>>> getPosts() async {
    try {
      final response = await dio.get(postUrl);
      if (response.statusCode == 200) {
        final list = (response.data as List)
            .map((postMap) => postFromMap(postMap))
            .toList();
        return Right(list);
      } else {
        return Left(HttpException());
      }
    } catch (e) {
      return Left(NotFoundException());
    }
  }

  @override
  Future<Either<PostException, Post>> publishPost(Post post) async {
    try {
      final response = await dio.post(postUrl);
      if (response.statusCode == 201) {
        final idPost = response.data["id"] as int;
        final postMap = postToMap(post);
        postMap["id"] = idPost;
        return Right(postFromMap(postMap));
      } else {
        return Left(HttpException());
      }
    } catch (e) {
      return Left(NotFoundException());
    }
  }

  @override
  Future<Either<PostException, Post>> updatePost(Post post) async {
    try {
      final response = await dio.put("$postUrl/${post.idPost}");
      if (response.statusCode == 200) {
        final idPost = response.data["id"] as int;
        final postMap = postToMap(post);
        postMap["id"] = idPost;
        return Right(postFromMap(postMap));
      } else {
        return Left(HttpException());
      }
    } catch (e) {
      return Left(NotFoundException());
    }
  }
}
