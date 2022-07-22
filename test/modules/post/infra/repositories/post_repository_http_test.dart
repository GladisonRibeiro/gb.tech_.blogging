import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gbtech_blogging/modules/post/domain/entities/post.dart';
import 'package:gbtech_blogging/modules/post/domain/exception/exception.dart';
import 'package:gbtech_blogging/modules/post/infra/repositories/post_repository_http.dart';
import 'package:mocktail/mocktail.dart';

import '../../utils/utils.dart';

class DioMock extends Mock implements Dio {}

void main() {
  final dio = DioMock();
  final postRepository = PostRepositoryHttp(dio);

  setUpAll(() {
    when(() => dio.get(postRepository.postUrl)).thenAnswer(
      (_) async => Response(
        data: jsonDecode(postsJson),
        statusCode: 200,
        requestOptions: RequestOptions(
          path: postRepository.postUrl,
        ),
      ),
    );
  });

  test('Deve retornar um post com base no map', () async {
    var post = postRepository.postFromMap(postMap);
    expect(post, isA<Post>());
    expect(post.idPost, equals(1));
    expect(post.updateDate, equals(null));
    expect(post.idUser, equals(1));
    expect(post.userName, equals("Eliane"));
    expect(
      post.userUrlPicture,
      equals(
          "https://drive.google.com/uc?export=view&id=13uewAV-h9v1n51euXv8AuF_x01W-pgwl"),
    );
    expect(
      post.message,
      equals(
          "Bom dia!, Que a sua semana seja cheia de carinho, ao lado daqueles que fazem a diferença na nossa vida."),
    );
    expect(post.createdDate, equals(DateTime.tryParse("2022-07-18T06:04:33Z")));
  });

  test('Deve retornar um map com base no post', () async {
    var map = postRepository.postToMap(
      Post(
        idPost: 1,
        message:
            "Bom dia!, Que a sua semana seja cheia de carinho, ao lado daqueles que fazem a diferença na nossa vida.",
        userName: "Eliane",
        idUser: 1,
        userUrlPicture:
            "https://drive.google.com/uc?export=view&id=13uewAV-h9v1n51euXv8AuF_x01W-pgwl",
        createdAt: DateTime.tryParse("2022-07-18T06:04:33.000Z"),
        updateDate: null,
      ),
    );
    expect(map, isA<Map<String, dynamic>>());
    expect(map["id"], equals(1));
    expect(
      map["message"]["content"],
      equals(
          "Bom dia!, Que a sua semana seja cheia de carinho, ao lado daqueles que fazem a diferença na nossa vida."),
    );
    expect(map["user"]["name"], equals("Eliane"));
    expect(map["user"]["id"], equals(1));
    expect(
        map["user"]["profile_picture"],
        equals(
            "https://drive.google.com/uc?export=view&id=13uewAV-h9v1n51euXv8AuF_x01W-pgwl"));
    expect(map["message"]["created_at"], equals("2022-07-18T06:04:33.000Z"));
    expect(map["updateDate"], isNull);
  });

  group("deletePost", () {
    test("Deve deletar um post", () async {
      when(() => dio.delete("${postRepository.postUrl}/1")).thenAnswer(
        (_) async => Response(
          data: {},
          statusCode: 200,
          requestOptions: RequestOptions(
            path: "${postRepository.postUrl}/1",
          ),
        ),
      );
      var result = await postRepository.deletePost(1);
      expect(result.fold(id, id), equals(true));
    });

    test(
        "Deve retornar um HttpException quando o statusCode for diferente de 200",
        () async {
      when(() => dio.delete("${postRepository.postUrl}/1")).thenAnswer(
        (_) async => Response(
          data: {},
          statusCode: 500,
          requestOptions: RequestOptions(
            path: "${postRepository.postUrl}/1",
          ),
        ),
      );
      var result = await postRepository.deletePost(1);
      expect(result.fold(id, id), isA<HttpException>());
    });

    test(
        "Deve retornar um NotFoundException quando ocorrer uma exception não tratada",
        () async {
      when(() => dio.delete("${postRepository.postUrl}/1"))
          .thenThrow(Exception());
      var result = await postRepository.deletePost(1);
      expect(result.fold(id, id), isA<NotFoundException>());
    });
  });

  group("getNews", () {
    test("Deve retornar uma lista de Novidades", () async {
      when(() => dio.get(postRepository.newsUrl)).thenAnswer(
        (_) async => Response(
          data: jsonDecode(newsJson),
          statusCode: 200,
          requestOptions: RequestOptions(
            path: postRepository.postUrl,
          ),
        ),
      );
      var result = await postRepository.getNews();
      expect(result.fold(id, id), isA<List<Post>>());
    });

    test(
        "Deve retornar um HttpException quando o statusCode for diferente de 200",
        () async {
      when(() => dio.get(postRepository.newsUrl)).thenAnswer(
        (_) async => Response(
          data: jsonDecode(newsJson),
          statusCode: 500,
          requestOptions: RequestOptions(
            path: postRepository.newsUrl,
          ),
        ),
      );
      var result = await postRepository.getNews();
      expect(result.fold(id, id), isA<HttpException>());
    });

    test(
        "Deve retornar um NotFoundException quando ocorrer uma exception não tratada",
        () async {
      when(() => dio.get(postRepository.newsUrl)).thenThrow(Exception());
      var result = await postRepository.getNews();
      expect(result.fold(id, id), isA<NotFoundException>());
    });
  });

  group("getPost", () {
    test("Deve retornar um Post", () async {
      when(() => dio.get("${postRepository.postUrl}/1")).thenAnswer(
        (_) async => Response(
          data: {
            "id": 1,
            "update_date": null,
            "user": {
              "id": 1,
              "name": "Eliane",
              "profile_picture":
                  "https://drive.google.com/uc?export=view&id=13uewAV-h9v1n51euXv8AuF_x01W-pgwl"
            },
            "message": {
              "content":
                  "Bom dia!, Que a sua semana seja cheia de carinho, ao lado daqueles que fazem a diferença na nossa vida.",
              "created_at": "2022-07-18T06:04:33Z"
            }
          },
          statusCode: 200,
          requestOptions: RequestOptions(
            path: "${postRepository.postUrl}/1",
          ),
        ),
      );
      var result = await postRepository.getPost(1);
      expect(result.fold(id, id), isA<Post>());
    });

    test(
        "Deve retornar um HttpException quando o statusCode for diferente de 200",
        () async {
      when(() => dio.get("${postRepository.postUrl}/1")).thenAnswer(
        (_) async => Response(
          data: jsonDecode(postsJson),
          statusCode: 500,
          requestOptions: RequestOptions(
            path: postRepository.postUrl,
          ),
        ),
      );
      var result = await postRepository.getPost(1);
      expect(result.fold(id, id), isA<HttpException>());
    });

    test(
        "Deve retornar um NotFoundException quando ocorrer uma exception não tratada",
        () async {
      when(() => dio.get("${postRepository.postUrl}/1")).thenThrow(Exception());
      var result = await postRepository.getPost(1);
      expect(result.fold(id, id), isA<NotFoundException>());
    });
  });

  group("getPosts", () {
    test("Deve retornar uma lista de Posts", () async {
      when(() => dio.get(postRepository.postUrl)).thenAnswer(
        (_) async => Response(
          data: jsonDecode(postsJson),
          statusCode: 200,
          requestOptions: RequestOptions(
            path: postRepository.postUrl,
          ),
        ),
      );
      var result = await postRepository.getPosts();
      expect(result.fold(id, id), isA<List<Post>>());
    });

    test(
        "Deve retornar um HttpException quando o statusCode for diferente de 200",
        () async {
      when(() => dio.get(postRepository.postUrl)).thenAnswer(
        (_) async => Response(
          data: jsonDecode(postsJson),
          statusCode: 500,
          requestOptions: RequestOptions(
            path: postRepository.postUrl,
          ),
        ),
      );
      var result = await postRepository.getPosts();
      expect(result.fold(id, id), isA<HttpException>());
    });

    test(
        "Deve retornar um NotFoundException quando ocorrer uma exception não tratada",
        () async {
      when(() => dio.get(postRepository.postUrl)).thenThrow(Exception());
      var result = await postRepository.getPosts();
      expect(result.fold(id, id), isA<NotFoundException>());
    });
  });

  group("publishPost", () {
    test("Deve publicar um Post", () async {
      when(() => dio.post(postRepository.postUrl)).thenAnswer(
        (_) async => Response(
          data: postMap,
          statusCode: 201,
          requestOptions: RequestOptions(
            path: postRepository.postUrl,
          ),
        ),
      );
      var result =
          await postRepository.publishPost(postRepository.postFromMap(postMap));
      expect(result.fold(id, id), isA<Post>());
    });

    test(
        "Deve retornar um HttpException quando o statusCode for diferente de 200",
        () async {
      when(() => dio.post(postRepository.postUrl)).thenAnswer(
        (_) async => Response(
          data: postMap,
          statusCode: 500,
          requestOptions: RequestOptions(
            path: postRepository.postUrl,
          ),
        ),
      );
      var result =
          await postRepository.publishPost(postRepository.postFromMap(postMap));
      expect(result.fold(id, id), isA<HttpException>());
    });

    test(
        "Deve retornar um NotFoundException quando ocorrer uma exception não tratada",
        () async {
      when(() => dio.post(postRepository.postUrl)).thenThrow(Exception());
      var result =
          await postRepository.publishPost(postRepository.postFromMap(postMap));
      expect(result.fold(id, id), isA<NotFoundException>());
    });
  });

  group("updatePost", () {
    test("Deve atualizar um Post", () async {
      when(() => dio.put("${postRepository.postUrl}/1")).thenAnswer(
        (_) async => Response(
          data: postMap,
          statusCode: 200,
          requestOptions: RequestOptions(
            path: "${postRepository.postUrl}/1",
          ),
        ),
      );
      var result =
          await postRepository.updatePost(postRepository.postFromMap(postMap));
      expect(result.fold(id, id), isA<Post>());
    });

    test(
        "Deve retornar um HttpException quando o statusCode for diferente de 200",
        () async {
      when(() => dio.put("${postRepository.postUrl}/1")).thenAnswer(
        (_) async => Response(
          data: postMap,
          statusCode: 500,
          requestOptions: RequestOptions(
            path: "${postRepository.postUrl}/1",
          ),
        ),
      );
      var result =
          await postRepository.updatePost(postRepository.postFromMap(postMap));
      expect(result.fold(id, id), isA<HttpException>());
    });

    test(
        "Deve retornar um NotFoundException quando ocorrer uma exception não tratada",
        () async {
      when(() => dio.put("${postRepository.postUrl}/1")).thenThrow(Exception());
      var result =
          await postRepository.updatePost(postRepository.postFromMap(postMap));
      expect(result.fold(id, id), isA<NotFoundException>());
    });
  });
}
