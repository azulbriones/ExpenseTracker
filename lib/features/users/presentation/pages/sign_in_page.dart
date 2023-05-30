import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project_app/app_const.dart';
import 'package:flutter_project_app/features/transactions/presentation/pages/home_page.dart';
import 'package:flutter_project_app/features/users/domain/entities/user_entity.dart';
import 'package:flutter_project_app/features/users/presentation/cubits/auth/auth_cubit.dart';
import 'package:flutter_project_app/features/users/presentation/cubits/auth/auth_state.dart';
import 'package:flutter_project_app/features/users/presentation/cubits/user/user_cubit.dart';
import 'package:flutter_project_app/features/users/presentation/cubits/user/user_state.dart';
import 'package:flutter_project_app/features/users/presentation/pages/reset_password_page.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocConsumer<UserCubit, UserState>(
        builder: (context, userState) {
          if (userState is UserSuccess) {
            return BlocBuilder<AuthCubit, AuthState>(
              builder: (context, authState) {
                if (authState is Authenticated) {
                  return HomePage(
                    uid: authState.uid,
                  );
                } else {
                  return _bodyWidget();
                }
              },
            );
          }

          return _bodyWidget();
        },
        listener: (context, userState) {
          if (userState is UserSuccess) {
            BlocProvider.of<AuthCubit>(context).loggedIn();
          }
          if (userState is UserFailure) {
            //snackBarError(msg: "invalid email",scaffoldState: _scaffoldGlobalKey);
          }
        },
      ),
    );
  }

  Widget _bodyWidget() {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          minHeight: 1,
        ),
        child: Column(
          children: [
            Container(
              width: w,
              height: h * 0.3,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/loginimg.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20),
              width: w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Bienvenido",
                    style: TextStyle(fontSize: 56, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Inicia sesión con tu cuenta",
                    style: TextStyle(fontSize: 20, color: Colors.grey[500]),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 10,
                          spreadRadius: 7,
                          offset: const Offset(1, 1),
                          color: Colors.grey.withOpacity(0.2),
                        ),
                      ],
                    ),
                    child: TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        hintText: "Correo electrónico",
                        prefixIcon: const Icon(
                          Icons.email,
                          color: Colors.deepPurple,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(
                            color: Colors.white,
                            width: 1.0,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(
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
                  const SizedBox(
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
                          offset: const Offset(1, 1),
                          color: Colors.grey.withOpacity(0.2),
                        ),
                      ],
                    ),
                    child: TextField(
                      obscureText: true,
                      controller: _passwordController,
                      decoration: InputDecoration(
                        hintText: "Contraseña",
                        prefixIcon: const Icon(
                          Icons.password,
                          color: Colors.deepPurple,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(
                            color: Colors.white,
                            width: 1.0,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(
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
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return const ResetPasswordPage();
                              },
                            ),
                          );
                        },
                        child: Text(
                          "¿Olvidaste tu contraseña?",
                          style:
                              TextStyle(fontSize: 18, color: Colors.grey[500]),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 70,
            ),
            GestureDetector(
              onTap: () {
                submitSignIn();
              },
              child: Container(
                width: w * 0.5,
                height: h * 0.08,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  image: const DecorationImage(
                      image: AssetImage("assets/images/loginbtn.png"),
                      fit: BoxFit.cover),
                ),
                child: Center(
                  child: RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: "Iniciar sesión",
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
                              Icons.login,
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
              height: w * 0.1,
            ),
            RichText(
              text: TextSpan(
                text: "¿Aún no tienes una cuenta?",
                style: TextStyle(
                  color: Colors.grey[500],
                  fontSize: 18,
                ),
                children: [
                  TextSpan(
                    text: " Crear cuenta",
                    style: const TextStyle(
                      color: Colors.blueAccent,
                      fontSize: 18,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () => Navigator.pushNamedAndRemoveUntil(
                          context, PageConst.signUpPage, (route) => false),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void submitSignIn() {
    if (_emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty) {
      BlocProvider.of<UserCubit>(context).submitSignIn(
        user: UserEntity(
          email: _emailController.text,
          password: _passwordController.text,
        ),
      );
    }
  }
}
