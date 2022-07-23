import '../../domain/entities/user.dart';

abstract class AuthStore {
  User getCurrentUser();
  void setCurrentUser(User user);
  bool isLogged();
}
