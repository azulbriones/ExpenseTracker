import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_project_app/features/transactions/data/datasources/transaction_firebase_data_source.dart';
import 'package:flutter_project_app/features/transactions/domain/entities/transaction_entity.dart';
import 'package:flutter_project_app/features/transactions/domain/repositories/transaction_firebase_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TransactionFirebaseRepositoryImpl extends TransactionFirebaseRepository {
  final TransactionFirebaseDataSource transactionDataSource;

  TransactionFirebaseRepositoryImpl({required this.transactionDataSource});

  @override
  Future<void> addNewTransaction(TransactionEntity transaction) async =>
      transactionDataSource.addNewTransaction(transaction);

  @override
  Future<void> deleteTransaction(TransactionEntity transaction) async =>
      transactionDataSource.deleteTransaction(transaction);

  @override
  Stream<List<TransactionEntity>> getTransactions(String uid) =>
      transactionDataSource.getTransactions(uid);

  @override
  Future<void> updateTransaction(TransactionEntity transaction) async =>
      transactionDataSource.updateTransaction(transaction);

  Future<void> syncDataWithFirestore() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult != ConnectivityResult.none) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? pendingDataJson = prefs.getString('pendingData');

      if (pendingDataJson != null) {
        List<Map<String, dynamic>> pendingData =
            List<Map<String, dynamic>>.from(jsonDecode(pendingDataJson).map(
          (item) => Map<String, dynamic>.from(item),
        ));

        for (var data in pendingData) {
          await transactionDataSource.addNewTransaction(
            //TransactionEntity(transaction: data['note']),
            TransactionEntity(
                description: data['description'], category: data['category']),
          );
        }

        prefs.remove('pendingData');
      }
    }
  }
}
