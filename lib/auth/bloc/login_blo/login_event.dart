part of 'login_bloc.dart';

@immutable
sealed class LoginEvent extends Equatable {}

class OnLoginEvent extends LoginEvent {
  final String email;
  final String password;

  OnLoginEvent(this.email, this.password);

  @override
  // TODO: implement props
  List<Object?> get props => [email, password];
}
