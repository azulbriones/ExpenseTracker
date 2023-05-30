import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project_app/features/transactions/domain/entities/transaction_entity.dart';
import 'package:flutter_project_app/features/transactions/domain/usecases/add_new_transaction_usecase.dart';
import 'package:flutter_project_app/features/transactions/domain/usecases/delete_note_usecase.dart';
import 'package:flutter_project_app/features/transactions/domain/usecases/get_notes_usecase.dart';
import 'package:flutter_project_app/features/transactions/domain/usecases/update_note_usecase.dart';
import 'package:flutter_project_app/features/transactions/presentation/cubit/note/transaction_state.dart';

class TransactionCubit extends Cubit<TransactionState> {
  final UpdateTransactionUseCase updateTransactionUseCase;
  final DeleteTransactionUseCase deleteTransactionUseCase;
  final GetTransactionUseCase getTransactionUseCase;
  final AddNewTransactionUseCase addNewTransactionUseCase;
  TransactionCubit(
      {required this.getTransactionUseCase,
      required this.deleteTransactionUseCase,
      required this.updateTransactionUseCase,
      required this.addNewTransactionUseCase})
      : super(TransactionInitial());

  Future<void> addTransaction({required TransactionEntity transaction}) async {
    try {
      await addNewTransactionUseCase.call(transaction);
    } on SocketException catch (_) {
      emit(TransactionFailure());
    } catch (_) {
      emit(TransactionFailure());
    }
  }

  Future<void> deleteTransaction(
      {required TransactionEntity transaction}) async {
    try {
      await deleteTransactionUseCase.call(transaction);
    } on SocketException catch (_) {
      emit(TransactionFailure());
    } catch (_) {
      emit(TransactionFailure());
    }
  }

  Future<void> updateTransaction(
      {required TransactionEntity transaction}) async {
    try {
      await updateTransactionUseCase.call(transaction);
    } on SocketException catch (_) {
      emit(TransactionFailure());
    } catch (_) {
      emit(TransactionFailure());
    }
  }

  Future<void> getTransactions({required String uid}) async {
    emit(TransactionLoading());
    try {
      getTransactionUseCase.call(uid).listen((transaction) {
        emit(TransactionLoaded(transaction: transaction));
      });
    } on SocketException catch (_) {
      emit(TransactionFailure());
    } catch (_) {
      emit(TransactionFailure());
    }
  }
}
