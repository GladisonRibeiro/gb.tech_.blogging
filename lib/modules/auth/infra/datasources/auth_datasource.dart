import '../../domain/entities/credential.dart';
import '../../domain/entities/user.dart';

abstract class AuthDatasorce {
  Future<User?> getUser(Credential credential);
  Future<User> addUser(Credential credential);
}
