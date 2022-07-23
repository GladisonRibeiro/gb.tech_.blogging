abstract class LoginEvent {}

class LoginSubmitPressed implements LoginEvent {
  final String email;
  final String password;

  LoginSubmitPressed(this.email, this.password);
}
