import 'package:flutter_project_app/features/users/domain/entities/user_entity.dart';

abstract class UserFirebaseDataSource {
  Future<bool> isSignIn();
  Future<void> signIn(UserEntity user);
  Future<void> signUp(UserEntity user);
  Future<void> signOut();
  Future<String> getCurrentUId();
  Future<void> getCreateCurrentUser(UserEntity user);
}
