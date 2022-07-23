import 'package:bloc/bloc.dart';

import '../../application/login.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final Login loginUsecase;

  LoginBloc(this.loginUsecase) : super(LoginStart()) {
    on<LoginSubmitPressed>((event, emit) async {
      emit(LoginLoading());
      await Future.delayed(const Duration(seconds: 1));
      final result = await loginUsecase(event.email, event.password);
      emit(result.fold((l) => LoginError(l), (r) => LoginSuccess(r)));
    });
  }
}
