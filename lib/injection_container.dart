import 'package:flutter_project_app/features/users/data/datasources/firebase_remote_datasources.dart';
import 'package:flutter_project_app/features/users/data/repositories/firebase_repository_Impl.dart';
import 'package:flutter_project_app/features/users/domain/repositories/firebase_repository.dart';
import 'package:flutter_project_app/features/users/domain/usecases/get_create_current_user.dart';
import 'package:flutter_project_app/features/users/domain/usecases/get_current_uid.dart';
import 'package:flutter_project_app/features/users/domain/usecases/get_users_use_case.dart';
import 'package:flutter_project_app/features/users/domain/usecases/is_signin.dart';
import 'package:flutter_project_app/features/users/domain/usecases/sign_out_usecase.dart';
import 'package:flutter_project_app/features/users/domain/usecases/signin_usecase.dart';
import 'package:flutter_project_app/features/users/domain/usecases/signup_usecase.dart';
import 'package:flutter_project_app/features/users/presentation/blocs/auth/auth_cubit.dart';
import 'package:flutter_project_app/features/users/presentation/blocs/login/login_cubit.dart';
import 'package:flutter_project_app/features/users/presentation/blocs/user/user_cubit.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //Features bloc,
  sl.registerFactory<AuthCubit>(() =>
      AuthCubit(isSignInUseCase: sl.call(), getCurrentUidUseCase: sl.call()));
  sl.registerFactory<LoginCubit>(() => LoginCubit(
        signInUseCase: sl.call(),
        signUpUseCase: sl.call(),
        getCreateCurrentUser: sl.call(),
        signOutUseCase: sl.call(),
      ));
  sl.registerFactory<UserCubit>(() => UserCubit(usersUseCase: sl.call()));
  // sl.registerFactory<CommunicationCubit>(() => CommunicationCubit(
  //     getMessagesUseCase: sl.call(), sendTextMessageUseCase: sl.call()));
  //!useCase
  sl.registerLazySingleton<IsSignInUseCase>(() => IsSignInUseCase(sl.call()));
  sl.registerLazySingleton<GetCurrentUidUseCase>(
      () => GetCurrentUidUseCase(repository: sl.call()));
  sl.registerLazySingleton<GetCreateCurrentUser>(
      () => GetCreateCurrentUser(firebaseRepository: sl.call()));
  sl.registerLazySingleton<SignInUseCase>(
      () => SignInUseCase(repository: sl.call()));
  sl.registerLazySingleton<SignUpUseCase>(
      () => SignUpUseCase(repository: sl.call()));
  sl.registerLazySingleton<GetUsersUseCase>(
      () => GetUsersUseCase(repository: sl.call()));
  // sl.registerLazySingleton<GetMessagesUseCase>(
  //     () => GetMessagesUseCase(repository: sl.call()));
  // sl.registerLazySingleton<SendTextMessageUseCase>(
  //     () => SendTextMessageUseCase(repository: sl.call()));
  sl.registerLazySingleton<SignOutUseCase>(
      () => SignOutUseCase(repository: sl.call()));

  //repository
  sl.registerLazySingleton<FirebaseRepository>(
      () => FirebaseRepositoryImpl(firebaseRemoteDatasources: sl.call()));
  //dataSource
  sl.registerLazySingleton<FirebaseRemoteDatasources>(
      () => FirebaseRemoteDataSourcesImpl());
  //external
  //e.g final sharedPreference=await SharedPreferences.getInstance();
}
