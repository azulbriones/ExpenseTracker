import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project_app/features/users/domain/entities/user_entity.dart';
import 'package:flutter_project_app/features/users/domain/usecases/get_create_current_user_use_case.dart';
import 'package:flutter_project_app/features/users/domain/usecases/sign_in_use_case.dart';
import 'package:flutter_project_app/features/users/domain/usecases/sign_up_use_case.dart';
import 'package:flutter_project_app/features/users/presentation/cubits/user/user_state.dart';

class UserCubit extends Cubit<UserState> {
  final SignInUseCase signInUseCase;
  final SignUpUseCase signUpUseCase;
  final GetCreateCurrentUserUseCase getCreateCurrentUserUseCase;
  UserCubit(
      {required this.signUpUseCase,
      required this.signInUseCase,
      required this.getCreateCurrentUserUseCase})
      : super(UserInitial());

  Future<void> submitSignIn({required UserEntity user}) async {
    emit(UserLoading());
    try {
      await signInUseCase.call(user);
      emit(UserSuccess());
    } on SocketException catch (_) {
      emit(UserFailure());
    } catch (_) {
      emit(UserFailure());
    }
  }

  Future<void> submitSignUp({required UserEntity user}) async {
    emit(UserLoading());
    try {
      await signUpUseCase.call(user);
      await getCreateCurrentUserUseCase.call(user);

      emit(UserSuccess());
    } on SocketException catch (_) {
      emit(UserFailure());
    } catch (_) {
      emit(UserFailure());
    }
  }
}
