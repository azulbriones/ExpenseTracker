import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project_app/features/users/domain/usecases/get_current_uid.dart';
import 'package:flutter_project_app/features/users/domain/usecases/is_signin.dart';
import 'package:flutter_project_app/features/users/presentation/blocs/auth/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final IsSignInUseCase isSignInUseCase;
  final GetCurrentUidUseCase getCurrentUidUseCase;
  AuthCubit({required this.isSignInUseCase, required this.getCurrentUidUseCase})
      : super(AuthInitial());

  Future<void> appStarted() async {
    try {
      final isSignIn = await isSignInUseCase.call();
      print("Sign $isSignIn");
      if (isSignIn == true) {
        final currentUid = await getCurrentUidUseCase.call();
        emit(Authenticated(uid: currentUid));
      } else {
        emit(UnAuthenticated());
      }
    } catch (_) {
      print("heelo appStarted catch");
      emit(UnAuthenticated());
    }
  }

  Future<void> loggedIn() async {
    final currentUid = await getCurrentUidUseCase.call();
    emit(Authenticated(uid: currentUid));
  }

  Future<void> loggedOut() async {
    emit(UnAuthenticated());
  }
}
