import 'package:bloc/bloc.dart';

import '../../application/login.dart';
import '../../domain/services/auth_store.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final Login loginUsecase;
  final AuthStore? authStore;

  LoginBloc(this.loginUsecase, [this.authStore]) : super(LoginStart()) {
    on<LoginSubmitPressed>((event, emit) async {
      emit(LoginLoading());
      await Future.delayed(const Duration(seconds: 1));
      final result = await loginUsecase(event.email, event.password);
      result.fold((l) {
        emit(LoginError(l));
      }, (r) {
        if (authStore != null) {
          authStore!.setCurrentUser(r);
        }
        emit(LoginSuccess(r));
      });
    });
  }
}
