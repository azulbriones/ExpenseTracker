import '../../data/models/transaction_model.dart';

class Transaction {
  final int id;
  final int amount;
  final String category;
  final String created_at;
  final String description;
  final int user_id;

  Transaction({
    required this.id,
    required this.amount,
    required this.category,
    required this.created_at,
    required this.description,
    required this.user_id,
  });

  factory Transaction.fromSnapshot(TransactionModel doc) {
    return Transaction(
      id: doc.id,
      amount: doc.amount,
      category: doc.category,
      created_at: doc.created_at,
      description: doc.description,
      user_id: doc.user_id,
    );
  }
}
