import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:gbtech_blogging/modules/auth/domain/entities/credential.dart';
import 'package:gbtech_blogging/modules/auth/domain/entities/user.dart';
import 'package:gbtech_blogging/modules/auth/domain/exception/exception.dart';
import 'package:gbtech_blogging/modules/auth/domain/repositories/sign_up_repository.dart';

class SignUpRepositoryHttp implements SignUpRepository {
  final Dio dio;
  final signUpUrl =
      "https://my-json-server.typicode.com/gladisonribeiro/gladisonribeiro.github.io/users";

  SignUpRepositoryHttp(this.dio);

  Map<String, dynamic> credentialtoMap(Credential userCredential) {
    return <String, dynamic>{
      'name': userCredential.name,
      'email': userCredential.email,
      'password': base64.encode(utf8.encode(userCredential.password)),
    };
  }

  @override
  Future<Either<AuthException, User>> signUp({
    required Credential credential,
  }) async {
    try {
      final credentialMap = credentialtoMap(credential);
      final response = await dio.post(signUpUrl, data: credentialMap);
      if (response.statusCode == 201) {
        final idUser = response.data["id"] as int;
        return Right(User(
          idUser: idUser,
          name: credential.name ?? '',
          urlPicture: '',
        ));
      } else {
        return Left(HttpException());
      }
    } catch (e) {
      return Left(InvalidCredential());
    }
  }
}
