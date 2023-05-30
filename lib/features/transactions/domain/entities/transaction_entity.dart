import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class TransactionEntity extends Equatable {
  final String? transactionId;
  final String? category;
  final Timestamp? time;
  final String? uid;
  final String? description;
  final Int? amount;

  TransactionEntity(
      {this.transactionId,
      this.category,
      this.time,
      this.uid,
      this.description,
      this.amount});

  @override
  // TODO: implement props
  List<Object?> get props =>
      [transactionId, category, time, uid, description, amount];

  Map<String, dynamic> toJson() {
    return {
      'transactionId': transactionId,
      'category': category,
      'time': time,
      'uid': uid,
      'description': description,
      'amount': amount
    };
  }

  factory TransactionEntity.fromJson(Map<String, dynamic> json) {
    return TransactionEntity(
        transactionId: json['transactionId'],
        category: json['category'],
        time: json['time'],
        uid: json['uid'],
        description: json['description'],
        amount: json['amount']);
  }
}
