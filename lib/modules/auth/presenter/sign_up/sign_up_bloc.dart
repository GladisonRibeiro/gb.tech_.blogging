import 'package:bloc/bloc.dart';

import '../../application/sign_up.dart';
import '../../domain/services/auth_store.dart';
import 'sign_up_event.dart';
import 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final SignUp signUpUsecase;
  final AuthStore? authStore;

  SignUpBloc(this.signUpUsecase, [this.authStore]) : super(SignUpStart()) {
    on<SignUpSubmitPressed>((event, emit) async {
      emit(SignUpLoading());
      await Future.delayed(const Duration(seconds: 1));
      final result =
          await signUpUsecase(event.email, event.password, event.name);
      emit(result.fold((l) => SignUpError(l), (r) {
        if (authStore != null) {
          authStore!.setCurrentUser(r);
        }
        return SignUpSuccess(r);
      }));
    });
  }
}
