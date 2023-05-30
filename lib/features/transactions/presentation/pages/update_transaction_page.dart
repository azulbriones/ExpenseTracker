import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project_app/features/transactions/domain/entities/transaction_entity.dart';
import 'package:flutter_project_app/features/transactions/presentation/cubit/note/transaction_cubit.dart';

class UpdateTransactionPage extends StatefulWidget {
  final TransactionEntity transactionEntity;
  const UpdateTransactionPage({Key? key, required this.transactionEntity})
      : super(key: key);

  @override
  _UpdateTransactionPageState createState() => _UpdateTransactionPageState();
}

class _UpdateTransactionPageState extends State<UpdateTransactionPage> {
  TextEditingController? _transactionTextController;

  @override
  void initState() {
    _transactionTextController =
        TextEditingController(text: widget.transactionEntity.category);
    _transactionTextController!.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    _transactionTextController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update Note"),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text(
            //   "${DateFormat("dd MMM hh:mm a").format(DateTime.now())} | ${_transactionTextController!.text.length} Characters",
            //   style:
            //       TextStyle(fontSize: 14, color: Colors.black.withOpacity(.5)),
            // ),
            Expanded(
              child: Scrollbar(
                child: TextFormField(
                  controller: _transactionTextController,
                  maxLines: null,
                  decoration: const InputDecoration(
                      border: InputBorder.none, hintText: "start your note"),
                ),
              ),
            ),
            InkWell(
              onTap: _submitUpdateNote,
              child: Container(
                height: 45,
                width: double.infinity,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.deepOrange,
                    borderRadius: BorderRadius.circular(8)),
                child: const Text(
                  "Update",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _submitUpdateNote() {
    BlocProvider.of<TransactionCubit>(context).updateTransaction(
      transaction: TransactionEntity(
        description: _transactionTextController!.text,
        transactionId: widget.transactionEntity.transactionId,
        time: Timestamp.now(),
        uid: widget.transactionEntity.uid,
      ),
    );

    Future.delayed(const Duration(seconds: 1), () {
      Navigator.pop(context);
    });
  }
}
