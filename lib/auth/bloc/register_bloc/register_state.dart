part of 'register_bloc.dart';

@immutable
sealed class RegisterState extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

final class RegisterInitial extends RegisterState {}

final class RegisterLoadingState extends RegisterState {}

final class RegisterErrorState extends RegisterState {
  final String error;

  RegisterErrorState(this.error);

  @override
  // TODO: implement props
  List<Object?> get props => [error];
}

final class RegisterSuccessState extends RegisterState {}
