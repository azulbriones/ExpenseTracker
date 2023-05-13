import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project_app/features/users/domain/usecases/get_users_use_case.dart';
import 'package:flutter_project_app/features/users/presentation/blocs/user/user_state.dart';

class UserCubit extends Cubit<UserState> {
  final GetUsersUseCase usersUseCase;
  UserCubit({required this.usersUseCase}) : super(UserInitial());

  Future<void> getUsers() async {
    try {
      final user = usersUseCase.call();
      user.listen((users) {
        emit(UserLoaded(users: users));
      });
    } on SocketException catch (_) {}
  }
}
