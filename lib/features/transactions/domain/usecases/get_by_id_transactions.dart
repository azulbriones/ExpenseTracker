import 'package:flutter_project_app/features/transactions/domain/entities/transaction.dart';
import 'package:flutter_project_app/features/transactions/domain/repositories/transaction_repository.dart';

class GetTransactionsById {
  final TransactionRepository repository;

  GetTransactionsById(this.repository);

  Future<Transaction> execute(String id) async {
    return await repository.getTransactionById(id);
  }
}
