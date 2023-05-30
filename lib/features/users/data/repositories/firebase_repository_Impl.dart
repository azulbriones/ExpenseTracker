import 'package:flutter_project_app/features/users/data/datasources/user_firebase_data_source.dart';
import 'package:flutter_project_app/features/users/domain/entities/user_entity.dart';
import 'package:flutter_project_app/features/users/domain/repositories/user_firebase_repository.dart';

class UserFirebaseRepositoryImpl extends UserFirebaseRepository {
  final UserFirebaseDataSource userFirebaseDataSource;

  UserFirebaseRepositoryImpl({required this.userFirebaseDataSource});
  @override
  Future<void> getCreateCurrentUser(UserEntity user) async =>
      userFirebaseDataSource.getCreateCurrentUser(user);

  @override
  Future<String> getCurrentUid() async =>
      userFirebaseDataSource.getCurrentUId();

  @override
  Future<bool> isSignIn() async => userFirebaseDataSource.isSignIn();

  @override
  Future<void> signIn(UserEntity user) async =>
      userFirebaseDataSource.signIn(user);

  @override
  Future<void> signOut() async => userFirebaseDataSource.signOut();

  @override
  Future<void> signUp(UserEntity user) async =>
      userFirebaseDataSource.signUp(user);
}
