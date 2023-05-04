import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_project_app/auth_controller.dart';
import 'package:get/get.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final usernameController = TextEditingController();
  String image = '';

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    usernameController.dispose();
    super.dispose();
  }

  Future signUp() async {
    // crear usuario
    if (passwordConfirmed()) {
      showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      );

      AuthController.instance.register(
        emailController.text.trim(),
        passwordController.text.trim(),
        usernameController.text.trim(),
        image,
      );
    } else {
      Get.snackbar(
        "Aviso",
        "Mensaje usuario",
        backgroundColor: Colors.amberAccent,
        snackPosition: SnackPosition.TOP,
        margin: const EdgeInsets.all(20),
        titleText: const Text(
          "Aviso",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        messageText: const Text(
          "Las contraseñas no coinciden",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      );
    }
  }

  bool passwordConfirmed() {
    if (passwordController.text.trim() ==
        confirmPasswordController.text.trim()) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    List images = ["g.png", "f.png"];

    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: LayoutBuilder(builder:
            (BuildContext context, BoxConstraints viewportConstraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: viewportConstraints.maxHeight,
              ),
              child: Column(
                children: [
                  Container(
                    width: w,
                    height: h * 0.3,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("img/signup.png"),
                          fit: BoxFit.cover),
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: h * 0.16,
                        ),
                        CircleAvatar(
                          radius: 60,
                          backgroundColor: Colors.white70,
                          backgroundImage: AssetImage("img/profile3.png"),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 20, right: 20),
                    width: w,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Hola!",
                          style: TextStyle(
                            fontSize: 56,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Crea tu cuenta y empieza",
                          style:
                              TextStyle(fontSize: 20, color: Colors.grey[500]),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 10,
                                spreadRadius: 7,
                                offset: Offset(1, 1),
                                color: Colors.grey.withOpacity(0.2),
                              ),
                            ],
                          ),
                          child: TextField(
                            controller: usernameController,
                            decoration: InputDecoration(
                              hintText: "Nombre de usuario",
                              prefixIcon: Icon(
                                Icons.person,
                                color: Colors.deepPurple,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(
                                  color: Colors.white,
                                  width: 1.0,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(
                                  color: Colors.white,
                                  width: 1.0,
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 10,
                                spreadRadius: 7,
                                offset: Offset(1, 1),
                                color: Colors.grey.withOpacity(0.2),
                              ),
                            ],
                          ),
                          child: TextField(
                            controller: emailController,
                            decoration: InputDecoration(
                                hintText: "Correo electrónico",
                                prefixIcon: Icon(
                                  Icons.email,
                                  color: Colors.deepPurple,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                    width: 1.0,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                    width: 1.0,
                                  ),
                                ),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30))),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 10,
                                spreadRadius: 7,
                                offset: Offset(1, 1),
                                color: Colors.grey.withOpacity(0.2),
                              ),
                            ],
                          ),
                          child: TextField(
                            obscureText: true,
                            controller: passwordController,
                            decoration: InputDecoration(
                                hintText: "Contraseña",
                                prefixIcon: Icon(
                                  Icons.password,
                                  color: Colors.deepPurple,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                    width: 1.0,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                    width: 1.0,
                                  ),
                                ),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30))),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 10,
                                spreadRadius: 7,
                                offset: Offset(1, 1),
                                color: Colors.grey.withOpacity(0.2),
                              ),
                            ],
                          ),
                          child: TextField(
                            obscureText: true,
                            controller: confirmPasswordController,
                            decoration: InputDecoration(
                                hintText: "Confirmar contraseña",
                                prefixIcon: Icon(
                                  Icons.password,
                                  color: Colors.deepPurple,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                    width: 1.0,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                    width: 1.0,
                                  ),
                                ),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30))),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  GestureDetector(
                    onTap: () {
                      signUp();
                    },
                    child: Container(
                      width: w * 0.5,
                      height: h * 0.08,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        image: DecorationImage(
                            image: AssetImage("img/loginbtn.png"),
                            fit: BoxFit.cover),
                      ),
                      child: Center(
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "Crear cuenta",
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              WidgetSpan(
                                child: Padding(
                                  padding: EdgeInsets.only(left: 5),
                                  child: Icon(
                                    Icons.person_add,
                                    size: 24,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  RichText(
                    text: TextSpan(
                      text: "¿Ya tienes una cuenta?",
                      style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: 18,
                      ),
                      children: [
                        TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => Get.back(),
                          text: " Iniciar sesión",
                          style: TextStyle(
                            color: Colors.blueAccent,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // SizedBox(
                  //   height: w * 0.1,
                  // ),
                  // Text(
                  //   "Puedes utilizar los siguientes métodos",
                  //   style: TextStyle(fontSize: 16, color: Colors.grey[500]),
                  // ),
                  // Wrap(
                  //   children: List<Widget>.generate(
                  //     2,
                  //     (index) {
                  //       return Padding(
                  //         padding: const EdgeInsets.all(10.0),
                  //         child: CircleAvatar(
                  //           radius: 30,
                  //           backgroundColor: Colors.grey[500],
                  //           child: CircleAvatar(
                  //             radius: 25,
                  //             backgroundImage:
                  //                 AssetImage("img/" + images[index]),
                  //           ),
                  //         ),
                  //       );
                  //     },
                  //   ),
                  // )
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
