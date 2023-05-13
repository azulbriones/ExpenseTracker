import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_project_app/features/users/data/models/users_model.dart';

abstract class FirebaseRemoteDatasources {
  Future<void> signUp(String email, String password);
  Future<void> signIn(String email, String password);
  Future<void> signOut();
  Future<bool> isSignIn();
  Future<String> getCurrentUid();
  Future<void> getCreateCurrentUser(
      String email, String username, String image);
  Stream<List<UserModel>> getUsers();
}

class FirebaseRemoteDataSourcesImpl implements FirebaseRemoteDatasources {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _userCollection = FirebaseFirestore.instance.collection('users');

  @override
  Future<String> getCurrentUid() async => _auth.currentUser!.uid;

  @override
  Future<bool> isSignIn() async => _auth.currentUser?.uid != null;

  @override
  Future<void> signIn(String email, String password) async {
    _auth.signInWithEmailAndPassword(email: email, password: password);
  }

  @override
  Future<void> signUp(String email, String password) async {
    await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  @override
  Future<void> getCreateCurrentUser(
      String email, String username, String image) async {
    _userCollection.doc(_auth.currentUser!.uid).get().then((user) {
      if (!user.exists) {
        final newUser = UserModel(
                username: username, email: email, uid: _auth.currentUser!.uid)
            .toDocument();
        _userCollection.doc(_auth.currentUser!.uid).set(newUser);
        return;
      } else {
        print("User Alreay exists");
        return;
      }
    });
  }

  @override
  Future<void> signOut() async {
    await _auth.signOut();
  }

  @override
  Stream<List<UserModel>> getUsers() {
    // TODO: implement getUsers
    return _userCollection.snapshots().map(
          (querySnapShot) => querySnapShot.docs
              .map((docSnapshot) => UserModel.fromSnapshot(docSnapshot))
              .toList(),
        );
  }
}
