import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gratitude_app/auth/auth_repo/register_repo.dart';
import 'package:meta/meta.dart';

part 'register_event.dart';

part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(RegisterInitial()) {
    on<OnClickRegisterEvent>(onClickRegisterEvent);
  }

  FutureOr<void> onClickRegisterEvent(
      OnClickRegisterEvent event, Emitter<RegisterState> emit) async {
    RegisterRepo repo = RegisterRepo();
    emit(RegisterLoadingState());
    final result =
        await repo.register(event.name!, event.email!, event.password!);

    if (result == true) {
      emit(RegisterSuccessState());
    } else {
      emit(RegisterErrorState("Something Wrong"));
    }
  }
}
