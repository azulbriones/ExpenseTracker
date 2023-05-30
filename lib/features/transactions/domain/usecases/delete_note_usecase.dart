import 'package:flutter_project_app/features/transactions/domain/entities/transaction_entity.dart';
import 'package:flutter_project_app/features/transactions/domain/repositories/transaction_firebase_repository.dart';

class DeleteTransactionUseCase {
  final TransactionFirebaseRepository repository;

  DeleteTransactionUseCase({required this.repository});

  Future<void> call(TransactionEntity transaction) async {
    return repository.deleteTransaction(transaction);
  }
}
