import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project_app/features/users/domain/usecases/get_current_uid_use_case.dart';
import 'package:flutter_project_app/features/users/domain/usecases/is_sign_in_use_case.dart';
import 'package:flutter_project_app/features/users/domain/usecases/sign_out_use_case.dart';
import 'package:flutter_project_app/features/users/presentation/cubits/auth/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final GetCurrentUidUseCase getCurrentUidUseCase;
  final IsSignInUseCase isSignInUseCase;
  final SignOutUseCase signOutUseCase;
  AuthCubit(
      {required this.isSignInUseCase,
      required this.signOutUseCase,
      required this.getCurrentUidUseCase})
      : super(AuthInitial());

  Future<void> appStarted() async {
    try {
      final isSignIn = await isSignInUseCase.call();
      if (isSignIn) {
        final uid = await getCurrentUidUseCase.call();
        emit(Authenticated(uid: uid));
      } else {
        emit(UnAuthenticated());
      }
    } on SocketException catch (_) {
      emit(UnAuthenticated());
    }
  }

  Future<void> loggedIn() async {
    try {
      final uid = await getCurrentUidUseCase.call();
      emit(Authenticated(uid: uid));
    } on SocketException catch (_) {
      emit(UnAuthenticated());
    }
  }

  Future<void> loggedOut() async {
    try {
      await signOutUseCase.call();
      emit(UnAuthenticated());
    } on SocketException catch (_) {
      emit(UnAuthenticated());
    }
  }
}
