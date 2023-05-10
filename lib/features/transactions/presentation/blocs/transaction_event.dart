import 'package:equatable/equatable.dart';

abstract class TransactionsEvent extends Equatable {
  const TransactionsEvent();

  @override
  List<Object> get props => [];
}

class GetTransactionsEvent extends TransactionsEvent {}

class AddTransactionEvent extends TransactionsEvent {
  final int amount;
  final String category;
  final String description;

  const AddTransactionEvent({
    required this.amount,
    required this.category,
    required this.description,
  });

  @override
  List<Object> get props => [amount, category, description];
}

class LoadTransactionsEvent extends TransactionsEvent {}
