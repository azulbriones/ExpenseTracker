import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project_app/features/users/domain/usecases/get_create_current_user.dart';
import 'package:flutter_project_app/features/users/domain/usecases/sign_out_usecase.dart';
import 'package:flutter_project_app/features/users/domain/usecases/signin_usecase.dart';
import 'package:flutter_project_app/features/users/domain/usecases/signup_usecase.dart';
import 'package:flutter_project_app/features/users/presentation/blocs/login/login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final SignUpUseCase signUpUseCase;
  final SignInUseCase signInUseCase;
  final GetCreateCurrentUser getCreateCurrentUser;
  final SignOutUseCase signOutUseCase;
  LoginCubit(
      {required this.signInUseCase,
      required this.signUpUseCase,
      required this.getCreateCurrentUser,
      required this.signOutUseCase})
      : super(LoginInitial());

  Future<void> submitLogin(
      {required String email, required String password}) async {
    emit(LoginLoading());
    try {
      await signInUseCase.call(email, password);
      emit(LoginSuccess());
    } on SocketException catch (e) {
      emit(LoginFailure(e.message));
    } catch (_) {
      emit(LoginFailure("firebase exception"));
    }
  }

  Future<void> submitRegistration(
      {required String email,
      required String password,
      required String username}) async {
    emit(LoginLoading());
    try {
      await signUpUseCase.call(email, password);
      await getCreateCurrentUser.call(email, username, "");
      emit(LoginSuccess());
    } on SocketException catch (e) {
      emit(LoginFailure(e.message));
    } catch (_) {
      emit(LoginFailure("firebase exception"));
    }
  }

  Future<void> submitSignOut() async {
    try {
      await signOutUseCase.call();
    } on SocketException catch (_) {}
  }
}
