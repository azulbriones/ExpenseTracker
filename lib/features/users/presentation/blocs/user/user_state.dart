import 'package:equatable/equatable.dart';
import 'package:flutter_project_app/features/users/domain/entities/users_entity.dart';

abstract class UserState extends Equatable {
  const UserState();
}

class UserInitial extends UserState {
  @override
  List<Object> get props => [];
}

class UserLoaded extends UserState {
  final List<UsersEntity> users;

  UserLoaded({required this.users});
  @override
  // TODO: implement props
  List<Object> get props => [users];
}

class UserLoading extends UserState {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}
