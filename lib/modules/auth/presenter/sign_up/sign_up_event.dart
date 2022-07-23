abstract class SignUpEvent {}

class SignUpSubmitPressed implements SignUpEvent {
  final String name;
  final String email;
  final String password;

  SignUpSubmitPressed(this.name, this.email, this.password);
}
