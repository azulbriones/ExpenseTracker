import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project_app/features/users/presentation/blocs/auth/auth_cubit.dart';
import 'package:flutter_project_app/features/users/presentation/blocs/login/login_cubit.dart';
import 'package:flutter_project_app/features/users/presentation/blocs/login/login_state.dart';
import 'package:flutter_project_app/features/users/presentation/pages/profile_page.dart';
import 'package:flutter_project_app/features/users/presentation/pages/sign_up_page.dart';
import 'package:flutter_project_app/features/users/presentation/widgets/loading_circle.dart';
import 'package:get/get.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({Key? key}) : super(key: key);

  @override
  _LogInPageState createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  bool isLoginPage = true;

  @override
  void initState() {
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      builder: (context, state) {
        if (state is LoginLoading) {
          return _loadingWidget();
        }
        return _bodyWidget();
      },
      listener: (context, state) {
        if (state is LoginSuccess) {
          BlocProvider.of<AuthCubit>(context).loggedIn();
        }
      },
    );
  }

  Widget _loadingWidget() {
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "WELCOME TO eTechVirale",
              style: TextStyle(
                  fontSize: 30,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              "Flutter is changing the app development world. if you want to improve your flutter skill then join our channel because we try to upload one video per week. eTechViral :- flutter and dart app development tutorials crafted to make you win jobs.",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black54, fontSize: 16),
            ),
            SizedBox(
              height: 15,
            ),
            _imageWidget(),
            SizedBox(
              height: 15,
            ),
            // _fromWidget(),
            // SizedBox(
            //   height: 15,
            // ),
            // _buttonWidget(),
            // SizedBox(
            //   height: 40,
            // ),
            // Align(
            //   alignment: Alignment.bottomCenter,
            //   child: LoadingCircle(),
            // ),
          ],
        ),
      ),
    );
  }

  Widget _bodyWidget() {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
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
                              image: AssetImage("assets/images/loginimg.png"),
                              fit: BoxFit.cover)),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 20, right: 20),
                      width: w,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Bienvenido",
                            style: TextStyle(
                              fontSize: 56,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Inicia sesión con tu cuenta",
                            style: TextStyle(
                                fontSize: 20, color: Colors.grey[500]),
                          ),
                          SizedBox(
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
                                  offset: Offset(1, 1),
                                  color: Colors.grey.withOpacity(0.2),
                                ),
                              ],
                            ),
                            child: TextField(
                              controller: _emailController,
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
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //     builder: (context) {
                                  //       return const ResetPassword();
                                  //     },
                                  //   ),
                                  // );
                                },
                                child: Text(
                                  "¿Olvidaste tu contraseña?",
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.grey[500]),
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
                        if (isLoginPage == true) {
                          _submitLogin();
                        } else {
                          _submitRegistration();
                        }
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
                              ..onTap = () => Get.to(() => const SignUpPage()),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _imageWidget() {
    return SizedBox(
      height: 60,
      width: 60,
      child: Image.asset("assets/images/loginimg.png"),
    );
  }

  Widget _fromWidget() {
    return Column(
      children: [
        isLoginPage == true
            ? Text(
                "",
                style: TextStyle(fontSize: 0),
              )
            : Container(
                height: 60,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(40)),
                  border: Border.all(color: Colors.grey, width: 1.0),
                ),
                child: TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: "User Name",
                    prefixIcon: Icon(Icons.person_outline),
                  ),
                ),
              ),
        isLoginPage == true
            ? Text(
                "",
                style: TextStyle(fontSize: 0),
              )
            : SizedBox(
                height: 20,
              ),
        Container(
          height: 60,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(40)),
            border: Border.all(color: Colors.grey, width: 1.0),
          ),
          child: TextField(
            controller: _emailController,
            decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: "Email Address",
              prefixIcon: Icon(Icons.alternate_email),
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Container(
          height: 60,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(40)),
            border: Border.all(color: Colors.grey, width: 1.0),
          ),
          child: TextField(
            controller: _passwordController,
            obscureText: true,
            decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: "Password",
              prefixIcon: Icon(Icons.lock_outline),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buttonWidget() {
    return InkWell(
      onTap: () {
        if (isLoginPage == true) {
          _submitLogin();
        } else {
          _submitRegistration();
        }
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        // width: widget.sizingInformation.screenSize.width,
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: Colors.indigo,
          borderRadius: BorderRadius.all(Radius.circular(50)),
        ),
        child: Text(
          isLoginPage == true ? "LOGIN" : "REGISTER",
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
      ),
    );
  }

  Widget _rowTextWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          isLoginPage == true ? "Don't have account?" : "Have an account?",
          style: TextStyle(fontSize: 16, color: Colors.indigo[400]),
        ),
        InkWell(
          onTap: () {
            setState(() {
              if (isLoginPage == true)
                isLoginPage = false;
              else
                isLoginPage = true;
            });
          },
          child: Text(
            isLoginPage == true ? " Sign Up" : " Sign In",
            style: TextStyle(
                fontSize: 16,
                color: Colors.indigo,
                fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  void _submitLogin() {
    if (_emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty) {
      BlocProvider.of<LoginCubit>(context).submitLogin(
        email: _emailController.text,
        password: _passwordController.text,
      );
    }
  }

  void _submitRegistration() {
    if (_emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty &&
        _nameController.text.isNotEmpty) {
      BlocProvider.of<LoginCubit>(context).submitRegistration(
        email: _emailController.text,
        password: _passwordController.text,
        username: _nameController.text,
      );
    }
  }
}
