import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project_app/features/users/presentation/blocs/auth/auth_cubit.dart';
import 'package:flutter_project_app/features/users/presentation/blocs/auth/auth_state.dart';
import 'package:flutter_project_app/features/users/presentation/blocs/login/login_cubit.dart';
import 'package:flutter_project_app/features/users/presentation/blocs/user/user_cubit.dart';
import 'package:flutter_project_app/features/users/presentation/pages/log_in_page.dart';
import 'package:flutter_project_app/features/users/presentation/pages/profile_page.dart';

import 'injection_container.dart' as di;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
          create: (_) => di.sl<AuthCubit>()..appStarted(),
        ),
        BlocProvider<LoginCubit>(
          create: (_) => di.sl<LoginCubit>(),
        ),
        BlocProvider<UserCubit>(
          create: (_) => di.sl<UserCubit>(),
        ),
        // BlocProvider<CommunicationCubit>(
        //   create: (_) => di.sl<CommunicationCubit>(),
        // )
      ],
      child: MaterialApp(
        title: 'Expense Tracker',
        debugShowCheckedModeBanner: false,
        routes: {
          "/": (context) {
            return BlocBuilder<AuthCubit, AuthState>(
              builder: (context, authState) {
                if (authState is Authenticated) {
                  return ProfilePage(uid: authState.uid);
                }
                if (authState is UnAuthenticated) {
                  return LogInPage();
                }
                return CircularProgressIndicator();
              },
            );
          }
        },
      ),
    );
  }
}
