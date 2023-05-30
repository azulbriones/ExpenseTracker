import 'package:flutter_project_app/features/transactions/domain/entities/transaction_entity.dart';
import 'package:flutter_project_app/features/transactions/domain/repositories/transaction_firebase_repository.dart';

class GetTransactionUseCase {
  final TransactionFirebaseRepository repository;

  GetTransactionUseCase({required this.repository});

  Stream<List<TransactionEntity>> call(String uid) {
    return repository.getTransactions(uid);
  }
}
