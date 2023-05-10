import 'package:equatable/equatable.dart';

abstract class TransactionsState extends Equatable {
  @override
  List<Object> get props => [];
}

class TransactionsInitial extends TransactionsState {}

class TransactionsLoadingState extends TransactionsState {}

class TransactionsLoadedState extends TransactionsState {
  final List transactions;

  TransactionsLoadedState({required this.transactions});

  @override
  List<Object> get props => [transactions];
}

class TransactionsErrorState extends TransactionsState {
  final String message;

  TransactionsErrorState({required this.message});

  @override
  List<Object> get props => [message];
}
