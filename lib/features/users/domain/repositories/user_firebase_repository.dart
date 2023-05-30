import 'package:flutter_project_app/features/users/domain/entities/user_entity.dart';

abstract class UserFirebaseRepository {
  Future<void> signUp(UserEntity user);
  Future<void> signIn(UserEntity user);
  Future<bool> isSignIn();
  Future<void> signOut();
  Future<String> getCurrentUid();
  Future<void> getCreateCurrentUser(UserEntity user);
}
