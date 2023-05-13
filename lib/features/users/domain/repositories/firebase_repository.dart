import 'package:flutter_project_app/features/users/domain/entities/users_entity.dart';

abstract class FirebaseRepository {
  Future<void> signUp(String email, String password);
  Future<void> signIn(String email, String password);
  Future<bool> isSignIn();
  Future<void> signOut();
  Future<String> getCurrentUid();
  Future<void> getCreateCurrentUser(
      String email, String username, String image);
  Stream<List<UsersEntity>> getUsers();
}
