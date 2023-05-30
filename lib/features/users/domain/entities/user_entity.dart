import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String? username;
  final String? email;
  final String? password;
  final String? uid;
  final String? image;

  const UserEntity(
      {this.username, this.email, this.password, this.uid, this.image});

  @override
  // TODO: implement props
  List<Object?> get props => [username, email, uid, image];
}
