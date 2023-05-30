import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_project_app/features/users/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel(
      {final String? username,
      final String? email,
      final String? uid,
      final String? password,
      final String? image})
      : super(
            username: username,
            email: email,
            password: password!,
            uid: uid,
            image: image!);

  // factory UserModel.fromJson(Map<String, dynamic> json) {
  //   return UserModel(
  //     username: json['username'],
  //     image: json['image'],
  //     email: json['email'],
  //     uid: json['uid'],
  //   );
  // }
  factory UserModel.fromSnapshot(DocumentSnapshot documentSnapshot) {
    return UserModel(
      username: documentSnapshot.get('username'),
      uid: documentSnapshot.get('uid'),
      email: documentSnapshot.get('email'),
      image: documentSnapshot.get('image'),
    );
  }
  Map<String, dynamic> toDocument() {
    return {
      "username": username,
      "uid": uid,
      "email": email,
      "image": image,
    };
  }
}
