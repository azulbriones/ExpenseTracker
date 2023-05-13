import 'package:equatable/equatable.dart';

abstract class LoginState extends Equatable {
  const LoginState();
}

class LoginInitial extends LoginState {
  @override
  List<Object> get props => [];
}

class LoginLoading extends LoginState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class LoginFailure extends LoginState {
  final String errorMessage;

  LoginFailure(this.errorMessage);
  @override
  // TODO: implement props
  List<Object> get props => [errorMessage];
}

class LoginSuccess extends LoginState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}
