import 'package:flutter_project_app/features/transactions/domain/entities/transaction.dart';

abstract class TransactionRepository {
  Future<List<Transaction>> getTransactions();
  Future<Transaction> getTransactionById(String id);
  Future<void> addTransaction(
      {required int amount,
      required String category,
      required String description});
  // Future<void> updateTransaction(Transaction transaction);
  // Future<void> deleteTransaction(String id);
}
