import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_project_app/features/transactions/data/datasources/transaction_firestore_datasource.dart';
import 'package:flutter_project_app/features/transactions/data/repositories/transaction_repository_impl.dart';
import 'package:flutter_project_app/features/transactions/domain/usecases/get_transactions.dart';

class UsecaseConfig {
  late GetTransactions getTransactions;
  late TransactionRepositoryImpl transactionRepositoryImpl;
  late TransactionFirestoreDataSourceImpl
      firestoreDataSource; // usa la subclase concreta aquí

  UsecaseConfig() {
    firestoreDataSource = TransactionFirestoreDataSourceImpl(
      firestore: FirebaseFirestore.instance,
    );
    transactionRepositoryImpl = TransactionRepositoryImpl(firestoreDataSource);
    getTransactions = GetTransactions(transactionRepositoryImpl);
  }
}
