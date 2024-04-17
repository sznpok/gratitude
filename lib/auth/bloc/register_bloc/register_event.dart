part of 'register_bloc.dart';

@immutable
sealed class RegisterEvent extends Equatable {}

class OnClickRegisterEvent extends RegisterEvent {
  final String? name;
  final String? email;
  final String? password;

  OnClickRegisterEvent({this.name, this.email, this.password});

  @override
  // TODO: implement props
  List<Object?> get props => [name, email, password];
}
