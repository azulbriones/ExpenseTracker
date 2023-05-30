import 'package:equatable/equatable.dart';
import 'package:flutter_project_app/features/transactions/domain/entities/transaction_entity.dart';

abstract class TransactionState extends Equatable {
  const TransactionState();
}

class TransactionInitial extends TransactionState {
  @override
  List<Object> get props => [];
}

class TransactionLoading extends TransactionState {
  @override
  List<Object> get props => [];
}

class TransactionFailure extends TransactionState {
  @override
  List<Object> get props => [];
}

class TransactionLoaded extends TransactionState {
  final List<TransactionEntity> transaction;

  const TransactionLoaded({required this.transaction});
  @override
  List<Object> get props => [transaction];
}
