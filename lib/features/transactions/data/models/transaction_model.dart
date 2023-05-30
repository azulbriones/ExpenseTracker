import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_project_app/features/transactions/domain/entities/transaction_entity.dart';

class TransactionModel extends TransactionEntity {
  TransactionModel({
    final String? transactionId,
    final String? category,
    final Timestamp? time,
    final String? uid,
    final String? description,
    final Int? amount,
  }) : super(
            uid: uid,
            time: time,
            transactionId: transactionId,
            category: category,
            description: description,
            amount: amount);
  factory TransactionModel.fromSnapshot(DocumentSnapshot documentSnapshot) {
    return TransactionModel(
        transactionId: documentSnapshot.get('transactionId'),
        category: documentSnapshot.get('category'),
        uid: documentSnapshot.get('uid'),
        time: documentSnapshot.get('time'),
        description: documentSnapshot.get('description'),
        amount: documentSnapshot.get('amount'));
  }

  Map<String, dynamic> toDocument() {
    return {
      "uid": uid,
      "time": time,
      "transactionId": transactionId,
      "category": category,
      "description": description,
      "amount": amount
    };
  }
}
