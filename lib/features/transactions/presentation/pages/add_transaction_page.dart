import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project_app/features/transactions/domain/entities/transaction_entity.dart';
import 'package:flutter_project_app/features/transactions/presentation/cubit/note/transaction_cubit.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddTransactionPage extends StatefulWidget {
  final String uid;
  const AddTransactionPage({Key? key, required this.uid}) : super(key: key);

  @override
  _AddTransactionPageState createState() => _AddTransactionPageState();
}

class _AddTransactionPageState extends State<AddTransactionPage> {
  final TextEditingController _transactionTextController =
      TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldStateKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    _transactionTextController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    _transactionTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldStateKey,
      appBar: AppBar(
        title: const Text("New note"),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${DateFormat("dd MMM hh:mm a").format(DateTime.now())} | ${_transactionTextController.text.length} Characters",
              style:
                  TextStyle(fontSize: 14, color: Colors.black.withOpacity(.5)),
            ),
            Expanded(
              child: Scrollbar(
                child: TextFormField(
                  controller: _transactionTextController,
                  maxLines: null,
                  decoration: const InputDecoration(
                      border: InputBorder.none, hintText: "start typing..."),
                ),
              ),
            ),
            InkWell(
              onTap: _submitNewTransaction,
              child: Container(
                height: 45,
                width: double.infinity,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 156, 34, 255),
                    borderRadius: BorderRadius.circular(8)),
                child: const Text(
                  "Save",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _submitNewTransaction() async {
    if (_transactionTextController.text.isEmpty) {
      // Mostrar mensaje de error si el campo de texto está vacío
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Type something")),
      );
      return;
    }

    var connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult == ConnectivityResult.none) {
      // No hay conexión a Internet, guardar los datos en SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String pendingDataJson = prefs.getString('pendingData') ?? '[]';
      List<Map<String, dynamic>> pendingData = List<Map<String, dynamic>>.from(
        jsonDecode(pendingDataJson)
            .map((item) => Map<String, dynamic>.from(item)),
      );

      pendingData.add({
        'transaction': _transactionTextController.text,
      });

      await prefs.setString('pendingData', jsonEncode(pendingData));

      _transactionTextController.clear();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
              'Data saved locally. It will be synchronized with Firestore when Internet connection is restored.'),
        ),
      );
    } else {
      // Hay conexión a Internet, guardar los datos directamente en Firestore
      TransactionEntity transaction = TransactionEntity(
        category: _transactionTextController.text,
        time: Timestamp.now(),
        uid: widget.uid,
      );

      BlocProvider.of<TransactionCubit>(context)
          .addTransaction(transaction: transaction);

      // Limpiar el campo de texto
      _transactionTextController.clear();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Data saved in Firestore.'),
        ),
      );
    }

    Future.delayed(const Duration(seconds: 1), () {
      Navigator.pop(context);
    });
  }
}
