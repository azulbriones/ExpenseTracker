import 'package:equatable/equatable.dart';

class UsersEntity extends Equatable {
  final String username;
  final String email;
  final String uid;
  final String image;

  UsersEntity(this.username, this.email, this.uid, this.image);

  @override
  // TODO: implement props
  List<Object?> get props => [username, email, uid, image];
}
