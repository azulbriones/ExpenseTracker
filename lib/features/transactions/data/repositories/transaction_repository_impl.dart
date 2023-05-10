import 'package:flutter_project_app/features/transactions/data/datasources/transaction_firestore_datasource.dart';
import 'package:flutter_project_app/features/transactions/data/models/transaction_model.dart';
import 'package:flutter_project_app/features/transactions/domain/entities/transaction.dart';
import 'package:flutter_project_app/features/transactions/domain/repositories/transaction_repository.dart';

class TransactionRepositoryImpl implements TransactionRepository {
  final TransactionFirestoreDataSource _firestoreDataSource;

  TransactionRepositoryImpl(this._firestoreDataSource);

  @override
  Future<List<Transaction>> getTransactions() async {
    final transactionModels = await _firestoreDataSource.getTransactions();
    return transactionModels
        .map((model) => Transaction.fromSnapshot(model))
        .toList();
  }

  @override
  Future<Transaction> getTransactionById(String id) async {
    final transactionDocument =
        await _firestoreDataSource.getTransactionById(id);
    return Transaction.fromSnapshot(transactionDocument);
  }

  @override
  Future<void> addTransaction({
    required int amount,
    required String category,
    required String description,
  }) async {
    return await _firestoreDataSource.addTransaction(
      TransactionModel(
        amount: amount,
        category: category,
        description: description,
        created_at: '',
        id: 0,
        user_id: 0,
      ),
    );
  }
}
