import '../../domain/entities/credential.dart';
import '../../domain/entities/user.dart';
import 'auth_datasource.dart';

class UserCredential {
  final int id;
  final String name;
  final String email;
  final String password;

  UserCredential(this.id, this.name, this.email, this.password);
}

class AuthDatasourceMemory implements AuthDatasorce {
  final List<UserCredential> _allUsers = [
    UserCredential(5, 'gb.tech_', 'gb.tech@blogging.io', 'abcd1234'),
  ];

  @override
  Future<User?> getUser(Credential credential) async {
    UserCredential? userCredential = _allUsers.firstWhere(
      (element) =>
          element.email == credential.email &&
          element.password == credential.password,
      orElse: () => UserCredential(0, '', '', ''),
    );
    if (userCredential.id == 0) return null;
    return User(
      name: userCredential.name,
      urlPicture: '',
      idUser: userCredential.id,
    );
  }

  @override
  Future<User> addUser(Credential credential) async {
    final newUser = UserCredential(
      DateTime.now().microsecondsSinceEpoch,
      credential.name!,
      credential.email,
      credential.password,
    );
    _allUsers.add(newUser);
    return User(
      name: newUser.name,
      urlPicture: '',
      idUser: newUser.id,
    );
  }
}
