import 'package:cloud_firestore/cloud_firestore.dart';

class TransactionModel {
  final int id;
  final int amount;
  final String category;
  final String created_at;
  final String description;
  final int user_id;

  TransactionModel({
    required this.id,
    required this.amount,
    required this.category,
    required this.created_at,
    required this.description,
    required this.user_id,
  });

  factory TransactionModel.fromJson(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return TransactionModel(
      id: data['id'] as int,
      amount: data['amount'] as int,
      category: data['category'] as String,
      created_at: data['created_at'] as String,
      description: data['description'] as String,
      user_id: data['user_id'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'amount': amount,
      'category': category,
      'created_at': created_at,
      'description': description,
      'user_id': user_id,
    };
  }
}
