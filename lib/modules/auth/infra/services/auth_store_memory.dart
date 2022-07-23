import '../../domain/entities/user.dart';
import '../../domain/services/auth_store.dart';

class AuthStoreMemory extends AuthStore {
  User? _user;

  @override
  User getCurrentUser() {
    return _user ?? User(name: '', urlPicture: '', idUser: 0);
  }

  @override
  bool isLogged() {
    return getCurrentUser().idUser != 0;
  }

  @override
  void setCurrentUser(User user) {
    _user = user;
  }
}
