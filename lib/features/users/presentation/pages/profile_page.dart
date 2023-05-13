import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project_app/features/users/data/models/users_model.dart';
import 'package:flutter_project_app/features/users/presentation/blocs/user/user_cubit.dart';
import 'package:flutter_project_app/features/users/presentation/blocs/user/user_state.dart';

class ProfilePage extends StatefulWidget {
  final String uid;
  const ProfilePage({Key? key, required this.uid}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    BlocProvider.of<UserCubit>(context).getUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(builder: (_, state) {
      if (state is UserLoaded) {
        return _bodyWidget(state);
      }
      return _loadingWidget();
    });
  }

  Widget _loadingWidget() {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
              colors: [],
            )),
          ),
          Align(
            alignment: Alignment.center,
            child: CircularProgressIndicator(),
          ),
        ],
      ),
    );
  }

  Widget _bodyWidget(UserLoaded users) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    final user = users.users.firstWhere((user) => user.uid == widget.uid,
        orElse: () => UserModel(email: '', uid: '', username: ''));
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: w,
            height: h,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/signup.png"),
                  fit: BoxFit.cover),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: h * 0.16,
                ),
                Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.white70,
                      child: ClipOval(
                        child: user.image != '' && user.image.isNotEmpty
                            ? Image.network(
                                user.image,
                                width: 120,
                                height: 120,
                                fit: BoxFit.cover,
                                loadingBuilder: (BuildContext context,
                                    Widget child,
                                    ImageChunkEvent? loadingProgress) {
                                  if (loadingProgress == null) {
                                    return child;
                                  }
                                  return Center(
                                    child: CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          Color.fromARGB(255, 230, 37, 255)),
                                      value:
                                          loadingProgress.expectedTotalBytes !=
                                                  null
                                              ? loadingProgress
                                                      .cumulativeBytesLoaded /
                                                  loadingProgress
                                                      .expectedTotalBytes!
                                              : null,
                                    ),
                                  );
                                },
                              )
                            : Image.asset(
                                'assets/images/profile3.png',
                                width: 120,
                                height: 120,
                                fit: BoxFit.cover,
                              ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
