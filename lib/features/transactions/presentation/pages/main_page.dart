import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project_app/features/transactions/domain/entities/transaction.dart';
import 'package:flutter_project_app/features/transactions/domain/usecases/get_transactions.dart';
import 'package:flutter_project_app/features/transactions/presentation/blocs/transaction_bloc.dart';
import 'package:flutter_project_app/features/transactions/presentation/blocs/transaction_event.dart';

class TransactionPage extends StatefulWidget {
  const TransactionPage({Key? key}) : super(key: key);

  @override
  _TransactionPageState createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  late final GetTransactions getTransactions;

  @override
  void initState() {
    super.initState();
    getTransactions = <GetTransactions>();
    context.read<TransactionsBloc>().add(GetTransactionsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transactions'),
      ),
      body: BlocBuilder<TransactionsBloc, TransactionState>(
        builder: (context, state) {
          if (state is LoadingTransactionState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is LoadedTransactionState) {
            return SingleChildScrollView(
              child: Column(
                children: state.transactions.map((Transaction transaction) {
                  return Container(
                    margin: const EdgeInsets.all(5),
                    padding: const EdgeInsets.all(5),
                    color: Colors.black12,
                    child: ListTile(
                      leading: Text(transaction.id),
                      title: Text(transaction.title),
                      subtitle: Text(transaction.amount.toString()),
                    ),
                  );
                }).toList(),
              ),
            );
          } else if (state is ErrorTransactionState) {
            return Center(
              child: Text(
                state.message,
                style: const TextStyle(color: Colors.red),
              ),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
