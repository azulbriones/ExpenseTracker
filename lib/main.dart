import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project_app/features/transactions/data/datasources/transaction_firestore_datasource.dart';
import 'package:flutter_project_app/features/transactions/data/repositories/transaction_repository_impl.dart';
import 'package:flutter_project_app/features/transactions/domain/usecases/get_transactions.dart';
import 'package:flutter_project_app/features/transactions/presentation/blocs/transaction_bloc.dart';
import 'package:flutter_project_app/features/transactions/presentation/pages/main_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => TransactionsBloc(
            TransactionRepositoryImpl(
              TransactionFirestoreDataSourceImpl(
                firestore: FirebaseFirestore.instance,
              ),
            ),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MainPage(),
      ),
    );
  }
}
