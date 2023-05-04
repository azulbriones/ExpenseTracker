import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_project_app/login_page.dart';
import 'package:flutter_project_app/notverified_page.dart';
import 'package:flutter_project_app/welcome_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  late Rx<User?> _user;
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void onReady() {
    super.onReady();
    _user = Rx<User?>(auth.currentUser);
    _user.bindStream(auth.userChanges());
    ever(_user, _initialScreen);
  }

  _initialScreen(User? user) {
    if (user == null) {
      Get.offAll(() => LoginPage());
    } else if (user.emailVerified == true) {
      Get.offAll(() => WelcomePage());
    } else {
      Get.offAll(() => NotVerifiedPage());
    }
  }

  void register(String email, password, username, image) async {
    try {
      await auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then(
            (cred) => {
              cred.user!
                  .sendEmailVerification(), // Enviar correo de verificación
              FirebaseFirestore.instance
                  .collection('users')
                  .doc(cred.user!.uid)
                  .set({
                'email': email,
                'username': username,
                'image': image,
              })
            },
          );
    } catch (e) {
      Get.snackbar(
        "Mensaje",
        "Ha ocurrido un error",
        backgroundColor: Colors.redAccent,
        snackPosition: SnackPosition.TOP,
        margin: EdgeInsets.all(20),
        titleText: Text(
          "Error al crear la cuenta",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        messageText: Text(
          e.toString(),
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      );
    }
  }

  void login(String email, password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      print('error');
      Get.snackbar(
        "Mensaje",
        "Ha ocurrido un error",
        backgroundColor: Colors.redAccent,
        snackPosition: SnackPosition.TOP,
        margin: EdgeInsets.all(20),
        titleText: Text(
          "Error al iniciar sesión",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        messageText: Text(
          e.toString(),
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      );
    }
  }

  void logOut() async {
    await auth.signOut();
  }

  void verifyEmail() {
    User? user = FirebaseAuth.instance.currentUser;
    user!.sendEmailVerification();
  }
}
