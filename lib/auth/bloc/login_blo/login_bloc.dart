import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gratitude_app/auth/auth_repo/login_repo.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<OnLoginEvent>(onLoginEvent);
  }

  FutureOr<void> onLoginEvent(
      OnLoginEvent event, Emitter<LoginState> emit) async {
    LoginRepo loginRepo = LoginRepo();
    emit(LoginLoadingState());
    final response = await loginRepo.login(event.email, event.password);
    if (response == true) {
      emit(LoginSuccessState());
    } else {
      emit(LoginErrorState());
    }
  }
}
