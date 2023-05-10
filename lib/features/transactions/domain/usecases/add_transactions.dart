import 'package:flutter_project_app/features/transactions/domain/entities/transaction.dart';
import 'package:flutter_project_app/features/transactions/domain/repositories/transaction_repository.dart';

class AddTransactions {
  final TransactionRepository repository;

  AddTransactions(this.repository);

  Future<void> execute(Transaction transaction) async {
    return await repository.addTransaction(
        amount: 0, category: '', description: '');
  }
}
