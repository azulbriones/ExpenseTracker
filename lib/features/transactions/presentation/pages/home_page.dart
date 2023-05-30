import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project_app/app_const.dart';
import 'package:flutter_project_app/features/transactions/presentation/cubit/note/transaction_cubit.dart';
import 'package:flutter_project_app/features/transactions/presentation/cubit/note/transaction_state.dart';
import 'package:flutter_project_app/features/users/presentation/cubits/auth/auth_cubit.dart';

class HomePage extends StatefulWidget {
  final String uid;
  const HomePage({Key? key, required this.uid}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    BlocProvider.of<TransactionCubit>(context).getTransactions(uid: widget.uid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "My Transactions ",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        actions: [
          IconButton(
              onPressed: () {
                BlocProvider.of<AuthCubit>(context).loggedOut();
              },
              icon: const Icon(Icons.exit_to_app)),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, PageConst.addTransactionPage,
              arguments: widget.uid);
        },
      ),
      body: BlocBuilder<TransactionCubit, TransactionState>(
        builder: (context, transactionState) {
          if (transactionState is TransactionLoaded) {
            return _bodyWidget(transactionState);
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget _noTransactionWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 80,
            //child: Image.asset('assets/images/notebook.png'),
          ),
          const SizedBox(
            height: 10,
          ),
          const Text("No notes here yet"),
        ],
      ),
    );
  }

  Widget _bodyWidget(TransactionLoaded transactionLoadedState) {
    return Column(
      children: [
        Expanded(
          child: transactionLoadedState.transaction.isEmpty
              ? _noTransactionWidget()
              : GridView.builder(
                  itemCount: transactionLoadedState.transaction.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, childAspectRatio: 1.2),
                  itemBuilder: (_, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                            context, PageConst.updateTransactionPage,
                            arguments:
                                transactionLoadedState.transaction[index]);
                      },
                      onLongPress: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text("Delete Note"),
                              content: const Text(
                                  "are you sure you want to delete this note."),
                              actions: [
                                TextButton(
                                  child: const Text("Delete"),
                                  onPressed: () {
                                    BlocProvider.of<TransactionCubit>(context)
                                        .deleteTransaction(
                                            transaction: transactionLoadedState
                                                .transaction[index]);
                                    Navigator.pop(context);
                                  },
                                ),
                                TextButton(
                                  child: const Text("No"),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(.2),
                                  blurRadius: 2,
                                  spreadRadius: 2,
                                  offset: const Offset(0, 1.5))
                            ]),
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.all(6),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${transactionLoadedState.transaction[index].description}",
                              maxLines: 6,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            // Text(
                            //     "${DateFormat("dd MMM yyy hh:mm a").format(transactionLoaded.transaction[index].time!.toDate())}")
                          ],
                        ),
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }
}
