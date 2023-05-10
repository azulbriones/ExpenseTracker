import 'package:bloc/bloc.dart';
import 'package:flutter_project_app/features/transactions/domain/repositories/transaction_repository.dart';
import 'package:flutter_project_app/features/transactions/presentation/blocs/transaction_event.dart';
import 'package:flutter_project_app/features/transactions/presentation/blocs/transaction_state.dart';
import 'package:flutter_project_app/features/transactions/presentation/pages/main_page.dart';

class TransactionsBloc extends Bloc<TransactionsEvent, TransactionsState> {
  final TransactionRepository _transactionRepository;

  TransactionsBloc(this._transactionRepository) : super(TransactionsInitial());

  Stream<TransactionsState> mapEventToState(
    TransactionsEvent event,
  ) async* {
    if (event is LoadTransactionsEvent) {
      yield TransactionsLoadingState();
      try {
        final transactions = await _transactionRepository.getTransactions();
        yield TransactionsLoadedState(transactions: transactions);
      } catch (e) {
        yield TransactionsErrorState(message: e.toString());
      }
    } else if (event is AddTransactionEvent) {
      yield TransactionsLoadingState();
      try {
        await _transactionRepository.addTransaction(
          amount: event.amount,
          category: event.category,
          description: event.description,
        );
        final transactions = await _transactionRepository.getTransactions();
        yield TransactionsLoadedState(transactions: transactions);
      } catch (e) {
        yield TransactionsErrorState(message: e.toString());
      }
    }
  }
}

class LoadTransactionsEvent {}
