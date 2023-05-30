import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project_app/features/transactions/presentation/cubit/note/transaction_cubit.dart';
import 'package:flutter_project_app/features/users/presentation/cubits/auth/auth_cubit.dart';
import 'package:flutter_project_app/features/users/presentation/cubits/auth/auth_state.dart';
import 'package:flutter_project_app/features/users/presentation/cubits/user/user_cubit.dart';
import 'package:flutter_project_app/features/users/presentation/pages/profile_page.dart';
import 'package:flutter_project_app/features/users/presentation/pages/sign_in_page.dart';
import 'package:flutter_project_app/on_generate_route.dart';
import 'injection_container.dart' as di;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
            create: (_) => di.sl<AuthCubit>()..appStarted()),
        BlocProvider<UserCubit>(create: (_) => di.sl<UserCubit>()),
        BlocProvider<TransactionCubit>(
            create: (_) => di.sl<TransactionCubit>()),
      ],
      child: MaterialApp(
        title: 'Expense Tracker',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        onGenerateRoute: OnGenerateRoute.route,
        routes: {
          "/": (context) {
            return BlocBuilder<AuthCubit, AuthState>(
              builder: (context, authState) {
                if (authState is Authenticated) {
                  return ProfilePage(
                    uid: authState.uid,
                  );
                }
                if (authState is UnAuthenticated) {
                  return const SignInPage();
                }

                return const CircularProgressIndicator();
              },
            );
          }
        },
      ),
    );
  }
}
