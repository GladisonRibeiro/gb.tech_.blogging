import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:gbtech_blogging/modules/auth/domain/entities/credential.dart';
import 'package:gbtech_blogging/modules/auth/domain/entities/user.dart';
import 'package:gbtech_blogging/modules/auth/domain/exception/exception.dart';
import 'package:gbtech_blogging/modules/auth/domain/repositories/login_repository.dart';

class LoginRepositoryHttp implements LoginRepository {
  final Dio dio;
  final loginUrl =
      "https://my-json-server.typicode.com/gladisonribeiro/gladisonribeiro.github.io/users";

  LoginRepositoryHttp(this.dio);

  credentialFromMap(Map<String, dynamic> map) {
    return Credential(
      name: map['name'] != null ? map['name'] as String : null,
      email: map['email'] as String,
      password: map['password'] as String,
    );
  }

  @override
  Future<Either<AuthException, User>> login({
    required Credential credential,
  }) async {
    try {
      final response = await dio.get("$loginUrl?email=${credential.email}");
      if (response.statusCode == 200) {
        final passwordEncrypt = base64.encode(utf8.encode(credential.password));
        final listUser = (response.data as List).toList();
        final userMap = listUser.first;
        Credential userCredential = credentialFromMap(userMap);

        if (userCredential.password != passwordEncrypt) {
          return Left(InvalidCredential());
        }

        return Right(User(
          idUser: userMap["id"] ?? 0,
          name: userCredential.name ?? '',
          urlPicture: userMap["profile_picture"],
        ));
      } else {
        return Left(HttpException());
      }
    } catch (e) {
      return Left(InvalidCredential());
    }
  }
}
