import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_project_app/features/transactions/data/models/transaction_model.dart';

abstract class TransactionFirestoreDataSource {
  Future<List<TransactionModel>> getTransactions();
  Future<TransactionModel> getTransactionById(String id);
  Future<void> addTransaction(TransactionModel transaction);
}

class TransactionFirestoreDataSourceImpl
    implements TransactionFirestoreDataSource {
  final FirebaseFirestore firestore;

  TransactionFirestoreDataSourceImpl({required this.firestore});

  @override
  Future<List<TransactionModel>> getTransactions() async {
    try {
      final querySnapshot = await firestore.collection('transactions').get();
      return querySnapshot.docs
          .map((doc) => TransactionModel.fromJson(doc))
          .toList();
    } catch (e) {
      throw Exception("Error al obtener las transacciones: $e");
    }
  }

  @override
  Future<TransactionModel> getTransactionById(String id) async {
    try {
      final docSnapshot =
          await firestore.collection('transactions').doc(id).get();
      return TransactionModel.fromJson(docSnapshot);
    } catch (e) {
      throw Exception("Error al obtener la transacción con ID $id: $e");
    }
  }

  @override
  Future<void> addTransaction(TransactionModel transaction) async {
    try {
      final transactionJson = transaction.toJson();
      await firestore.collection('transactions').add(transactionJson);
    } catch (e) {
      throw Exception("Error al agregar la transacción: $e");
    }
  }
}
