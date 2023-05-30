import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_project_app/features/users/data/datasources/user_firebase_data_source.dart';
import 'package:flutter_project_app/features/users/data/models/user_model.dart';
import 'package:flutter_project_app/features/users/domain/entities/user_entity.dart';

class UserFirebaseDataSourceImpl implements UserFirebaseDataSource {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  UserFirebaseDataSourceImpl({required this.auth, required this.firestore});

  @override
  Future<void> getCreateCurrentUser(UserEntity user) async {
    final userCollectionRef = firestore.collection("users");
    final uid = await getCurrentUId();
    userCollectionRef.doc(uid).get().then((value) {
      final newUser = UserModel(
        uid: uid,
        username: user.username,
        email: user.email,
        image: user.image,
      ).toDocument();
      if (!value.exists) {
        userCollectionRef.doc(uid).set(newUser);
      }
      return;
    });
  }

  @override
  Future<String> getCurrentUId() async => auth.currentUser!.uid;

  @override
  Future<bool> isSignIn() async => auth.currentUser?.uid != null;

  @override
  Future<void> signIn(UserEntity user) async => auth.signInWithEmailAndPassword(
      email: user.email!, password: user.password!);

  @override
  Future<void> signOut() async => auth.signOut();

  @override
  Future<void> signUp(UserEntity user) async =>
      auth.createUserWithEmailAndPassword(
          email: user.email!, password: user.password!);
}
