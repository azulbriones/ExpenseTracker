import 'package:equatable/equatable.dart';
import 'package:flutter_project_app/features/transactions/domain/entities/transaction.dart';

abstract class TransactionsState extends Equatable {
  const TransactionsState();

  @override
  List<Object> get props => [];
}

class TransactionsInitial extends TransactionsState {}

class TransactionsLoadingState extends TransactionsState {}

class TransactionsLoadedState extends TransactionsState {
  final List<Transaction> transactions;

  const TransactionsLoadedState({required this.transactions});

  @override
  List<Object> get props => [transactions];
}

class TransactionsErrorState extends TransactionsState {
  final String message;

  const TransactionsErrorState({required this.message});

  @override
  List<Object> get props => [message];
}
