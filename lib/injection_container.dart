import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_project_app/features/transactions/data/datasources/transaction_firebase_data_source.dart';
import 'package:flutter_project_app/features/transactions/data/datasources/transaction_firebase_data_source_impl.dart';
import 'package:flutter_project_app/features/transactions/data/repositories/transaction_firebase_repository_impl.dart';
import 'package:flutter_project_app/features/transactions/domain/repositories/transaction_firebase_repository.dart';
import 'package:flutter_project_app/features/transactions/domain/usecases/add_new_transaction_usecase.dart';
import 'package:flutter_project_app/features/transactions/domain/usecases/delete_note_usecase.dart';
import 'package:flutter_project_app/features/transactions/domain/usecases/get_notes_usecase.dart';
import 'package:flutter_project_app/features/transactions/domain/usecases/update_note_usecase.dart';
import 'package:flutter_project_app/features/transactions/presentation/cubit/note/transaction_cubit.dart';
import 'package:flutter_project_app/features/users/data/datasources/user_firebase_data_source.dart';
import 'package:flutter_project_app/features/users/data/datasources/user_firebase_data_source_impl.dart';
import 'package:flutter_project_app/features/users/data/repositories/firebase_repository_Impl.dart';
import 'package:flutter_project_app/features/users/domain/repositories/user_firebase_repository.dart';
import 'package:flutter_project_app/features/users/domain/usecases/get_create_current_user_use_case.dart';
import 'package:flutter_project_app/features/users/domain/usecases/get_current_uid_use_case.dart';
import 'package:flutter_project_app/features/users/domain/usecases/is_sign_in_use_case.dart';
import 'package:flutter_project_app/features/users/domain/usecases/sign_in_use_case.dart';
import 'package:flutter_project_app/features/users/domain/usecases/sign_out_use_case.dart';
import 'package:flutter_project_app/features/users/domain/usecases/sign_up_use_case.dart';
import 'package:flutter_project_app/features/users/presentation/cubits/auth/auth_cubit.dart';
import 'package:flutter_project_app/features/users/presentation/cubits/user/user_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

GetIt sl = GetIt.instance;

Future<void> init() async {
  //Cubit/Bloc
  sl.registerFactory<AuthCubit>(() => AuthCubit(
      isSignInUseCase: sl.call(),
      signOutUseCase: sl.call(),
      getCurrentUidUseCase: sl.call()));
  sl.registerFactory<UserCubit>(() => UserCubit(
        getCreateCurrentUserUseCase: sl.call(),
        signInUseCase: sl.call(),
        signUpUseCase: sl.call(),
      ));
  sl.registerFactory<TransactionCubit>(() => TransactionCubit(
        updateTransactionUseCase: sl.call(),
        getTransactionUseCase: sl.call(),
        deleteTransactionUseCase: sl.call(),
        addNewTransactionUseCase: sl.call(),
      ));

  //useCase
  sl.registerLazySingleton<AddNewTransactionUseCase>(
      () => AddNewTransactionUseCase(repository: sl.call()));
  sl.registerLazySingleton<DeleteTransactionUseCase>(
      () => DeleteTransactionUseCase(repository: sl.call()));
  sl.registerLazySingleton<GetCreateCurrentUserUseCase>(
      () => GetCreateCurrentUserUseCase(repository: sl.call()));
  sl.registerLazySingleton<GetCurrentUidUseCase>(
      () => GetCurrentUidUseCase(repository: sl.call()));
  sl.registerLazySingleton<GetTransactionUseCase>(
      () => GetTransactionUseCase(repository: sl.call()));
  sl.registerLazySingleton<IsSignInUseCase>(
      () => IsSignInUseCase(repository: sl.call()));
  sl.registerLazySingleton<SignInUseCase>(
      () => SignInUseCase(repository: sl.call()));
  sl.registerLazySingleton<SignOutUseCase>(
      () => SignOutUseCase(repository: sl.call()));
  sl.registerLazySingleton<SignUpUseCase>(
      () => SignUpUseCase(repository: sl.call()));
  sl.registerLazySingleton<UpdateTransactionUseCase>(
      () => UpdateTransactionUseCase(repository: sl.call()));

  //repository
  sl.registerLazySingleton<TransactionFirebaseRepository>(() =>
      TransactionFirebaseRepositoryImpl(transactionDataSource: sl.call()));
  sl.registerLazySingleton<UserFirebaseRepository>(
      () => UserFirebaseRepositoryImpl(userFirebaseDataSource: sl.call()));

  //data source
  sl.registerLazySingleton<TransactionFirebaseDataSource>(() =>
      TransactionFirebaseDataSourceImpl(auth: sl.call(), firestore: sl.call()));
  sl.registerLazySingleton<UserFirebaseDataSource>(
      () => UserFirebaseDataSourceImpl(auth: sl.call(), firestore: sl.call()));

  //External
  final auth = FirebaseAuth.instance;
  final fireStore = FirebaseFirestore.instance;
  final sharedPreferences = await SharedPreferences.getInstance();
  final connectivity = Connectivity();

  sl.registerLazySingleton(() => auth);
  sl.registerLazySingleton(() => fireStore);

  sl.registerLazySingleton(() => sharedPreferences);

  sl.registerLazySingleton(() => connectivity);
}
