import 'package:flutter_project_app/features/users/data/datasources/firebase_remote_datasources.dart';
import 'package:flutter_project_app/features/users/domain/entities/users_entity.dart';
import 'package:flutter_project_app/features/users/domain/repositories/firebase_repository.dart';

class FirebaseRepositoryImpl implements FirebaseRepository {
  final FirebaseRemoteDatasources firebaseRemoteDatasources;

  FirebaseRepositoryImpl({required this.firebaseRemoteDatasources});
  @override
  Future<String> getCurrentUid() async =>
      await firebaseRemoteDatasources.getCurrentUid();
  @override
  Future<bool> isSignIn() async => await firebaseRemoteDatasources.isSignIn();

  @override
  Future<void> signIn(String email, String password) async =>
      await firebaseRemoteDatasources.signIn(email, password);

  @override
  Future<void> signUp(String email, String password) async =>
      await firebaseRemoteDatasources.signUp(email, password);

  @override
  Future<void> getCreateCurrentUser(
      String email, String username, String image) async {
    return await firebaseRemoteDatasources.getCreateCurrentUser(
        email, username, image);
  }

  @override
  Stream<List<UsersEntity>> getUsers() {
    return firebaseRemoteDatasources.getUsers();
  }

  @override
  Future<void> signOut() => firebaseRemoteDatasources.signOut();
}
