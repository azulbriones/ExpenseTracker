import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_project_app/features/transactions/data/datasources/transaction_firebase_data_source.dart';
import 'package:flutter_project_app/features/transactions/data/models/transaction_model.dart';
import 'package:flutter_project_app/features/transactions/domain/entities/transaction_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TransactionFirebaseDataSourceImpl
    implements TransactionFirebaseDataSource {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  TransactionFirebaseDataSourceImpl(
      {required this.auth, required this.firestore});

  @override
  Future<void> addNewTransaction(TransactionEntity transactionEntity) async {
    final transactionCollectionRef = firestore
        .collection("users")
        .doc(transactionEntity.uid)
        .collection("Transaction");

    final transactionId = transactionCollectionRef.doc().id;

    transactionCollectionRef.doc(transactionId).get().then((transaction) {
      final newTransaction = TransactionModel(
              uid: transactionEntity.uid,
              transactionId: transactionId,
              category: transactionEntity.category,
              time: transactionEntity.time,
              description: transactionEntity.description,
              amount: transactionEntity.amount)
          .toDocument();

      if (!transaction.exists) {
        transactionCollectionRef.doc(transactionId).set(newTransaction);
      }
      return;
    });
  }

  @override
  Future<void> deleteTransaction(TransactionEntity transactionEntity) async {
    final transactionCollectionRef = firestore
        .collection("users")
        .doc(transactionEntity.uid)
        .collection("Transaction");

    transactionCollectionRef
        .doc(transactionEntity.transactionId)
        .get()
        .then((transaction) {
      if (transaction.exists) {
        transactionCollectionRef.doc(transactionEntity.transactionId).delete();
      }
      return;
    });
  }

  @override
  Stream<List<TransactionEntity>> getTransactions(String uid) {
    final transactionCollectionRef =
        firestore.collection("users").doc(uid).collection("Transaction");

    return transactionCollectionRef.snapshots().map((querySnap) {
      return querySnap.docs
          .map((docSnap) => TransactionModel.fromSnapshot(docSnap))
          .toList();
    });
  }

  @override
  Future<void> updateTransaction(TransactionEntity transaction) async {
    Map<String, dynamic> transactionMap = {};
    final transactionCollectionRef = firestore
        .collection("users")
        .doc(transaction.uid)
        .collection("Transaction");

    if (transaction.category != null) {
      transactionMap['category'] = transaction.category;
    }
    if (transaction.time != null) transactionMap['time'] = transaction.time;

    transactionCollectionRef
        .doc(transaction.transactionId)
        .update(transactionMap);
  }

  Future<void> syncDataWithFirestore() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? pendingDataJson = prefs.getString('pendingData');

    if (pendingDataJson != null) {
      List<Map<String, dynamic>> pendingData = List<Map<String, dynamic>>.from(
        jsonDecode(pendingDataJson)
            .map((item) => Map<String, dynamic>.from(item)),
      );

      for (var data in pendingData) {
        await addNewTransaction(data['transaction']);
      }

      // Borrar los datos pendientes en SharedPreferences después de sincronizarlos con Firestore
      prefs.remove('pendingData');
    }
  }
}
