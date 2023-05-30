import 'package:flutter_project_app/features/transactions/domain/entities/transaction_entity.dart';

abstract class TransactionFirebaseRepository {
  Future<void> addNewTransaction(TransactionEntity transaction);
  Future<void> updateTransaction(TransactionEntity transaction);
  Future<void> deleteTransaction(TransactionEntity transaction);
  Stream<List<TransactionEntity>> getTransactions(String uid);
}
