import 'package:bloc/bloc.dart';

import '../../application/sign_up.dart';
import 'sign_up_event.dart';
import 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final SignUp signUpUsecase;
  SignUpBloc(this.signUpUsecase) : super(SignUpStart()) {
    on<SignUpSubmitPressed>((event, emit) async {
      emit(SignUpLoading());
      await Future.delayed(const Duration(seconds: 1));
      final result =
          await signUpUsecase(event.email, event.password, event.name);
      emit(result.fold((l) => SignUpError(l), (r) => SignUpSuccess(r)));
    });
  }
}
