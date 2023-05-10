import 'package:flutter_project_app/features/transactions/domain/entities/transaction.dart';
import 'package:flutter_project_app/features/transactions/domain/repositories/transaction_repository.dart';

class GetTransactions {
  final TransactionRepository repository;

  GetTransactions(this.repository);

  Future<List<Transaction>> execute() async {
    return await repository.getTransactions();
  }
}
