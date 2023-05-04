import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project_app/controllers/auth_controller.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'balance_card.dart';
import 'loading_circle.dart';
import 'plus_button.dart';

class HomePage2 extends StatefulWidget {
  const HomePage2({Key? key}) : super(key: key);

  @override
  _HomePage2State createState() => _HomePage2State();
}

class _HomePage2State extends State<HomePage2> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  // collect user input
  final _textcontrollerAMOUNT = TextEditingController();
  final _textcontrollerDESC = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final user = FirebaseAuth.instance.currentUser!;
  bool _isIncome = false;
  late String category;
  late Future _fetchFuture;
  late double balance;
  double totalIngresos = 0;
  double totalGastos = 0;

  @override
  void initState() {
    super.initState();
    getAllTransactions();
    getTotalGasto();
    getTotalIngreso();
  }

  @override
  void dispose() {
    // dispose text controllers
    _textcontrollerAMOUNT.dispose();
    _textcontrollerDESC.dispose();
    super.dispose();
  }

  Future<List<QueryDocumentSnapshot>> getAllTransactions() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('transactions')
        .where('user_id', isEqualTo: user.uid)
        .get();
    return querySnapshot.docs;
  }

  Future<void> getTotalGasto() async {
    double total = 0;
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('transactions')
        .where('user_id', isEqualTo: user.uid)
        .where('category', isEqualTo: 'Gasto')
        .get();

    querySnapshot.docs.forEach((documentSnapshot) {
      total += double.parse(documentSnapshot.get('amount'));
    });

    setState(() {
      totalGastos = total;
    });
  }

  Future<void> getTotalIngreso() async {
    double total2 = 0;
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('transactions')
        .where('user_id', isEqualTo: user.uid)
        .where('category', isEqualTo: 'Ingreso')
        .orderBy('created_at', descending: true)
        .get();

    querySnapshot.docs.forEach((documentSnapshot) {
      total2 += double.parse(documentSnapshot.get('amount'));
    });
    setState(() {
      totalIngresos = total2;
    });
  }

  void updateTotals() async {
    await getTotalGasto();
    await getTotalIngreso();
    balance = totalIngresos - totalGastos;
  }

  Future<void> getTransactionData() async {
    String desc = '';
    String amount = '';
    String category = '';
  }

  Future<void> _addTransaction() async {
    if (_isIncome == true) {
      category = 'Ingreso';
    } else {
      category = 'Gasto';
    }

    try {
      await FirebaseFirestore.instance.collection('transactions').add({
        'category': category,
        'description': _textcontrollerDESC.text.trim(),
        'amount': _textcontrollerAMOUNT.text.trim(),
        'user_id': user.uid,
        'created_at': Timestamp.now(),
      });

      Get.snackbar(
        "Aviso",
        "Mensaje usuario",
        backgroundColor: Colors.greenAccent[700],
        snackPosition: SnackPosition.TOP,
        margin: const EdgeInsets.all(20),
        titleText: const Text(
          "Completado éxitosamente",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        messageText: const Text(
          "Transacción registrada",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      );
    } catch (e) {
      Get.snackbar(
        "Mensaje",
        "Ha ocurrido un error",
        backgroundColor: Colors.redAccent,
        snackPosition: SnackPosition.TOP,
        margin: const EdgeInsets.all(20),
        titleText: const Text(
          "Error al agregar la transacción",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        messageText: Text(
          e.toString(),
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      );
    }
  }

  Future<void> _deleteTransaction(docIndex) async {
    try {
      await FirebaseFirestore.instance
          .collection('transactions')
          .doc(docIndex)
          .delete();
      Get.snackbar(
        "Aviso",
        "Mensaje usuario",
        backgroundColor: Colors.greenAccent[700],
        snackPosition: SnackPosition.TOP,
        margin: const EdgeInsets.all(20),
        titleText: const Text(
          "Completado éxitosamente",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        messageText: const Text(
          "Transacción eliminada",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      );
    } catch (e) {
      Get.snackbar(
        "Mensaje",
        "Ha ocurrido un error",
        backgroundColor: Colors.redAccent,
        snackPosition: SnackPosition.TOP,
        margin: const EdgeInsets.all(20),
        titleText: const Text(
          "Error al eliminar la transacción",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        messageText: Text(
          e.toString(),
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      );
    }
  }

  // enter the new transaction into the spreadsheet
  // void _enterTransaction() {
  //   GoogleSheetsApi.insert(
  //     _textcontrollerITEM.text,
  //     _textcontrollerAMOUNT.text,
  //     _isIncome,
  //   );
  //   setState(() {});
  // }

  // new transaction
  void _newTransaction() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (BuildContext context, setState) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                title: Center(child: Text('N U E V O')),
                content: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text('Gasto'),
                          Switch(
                            value: _isIncome,
                            onChanged: (newValue) {
                              setState(() {
                                _isIncome = newValue;
                              });
                            },
                          ),
                          Text('Ingreso'),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Form(
                              key: _formKey,
                              child: TextFormField(
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  hintText: 'Monto',
                                ),
                                validator: (text) {
                                  if (text == null || text.isEmpty) {
                                    return 'Introduce un monto';
                                  }
                                  return null;
                                },
                                controller: _textcontrollerAMOUNT,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              maxLength: 25,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                hintText: 'Descripción',
                              ),
                              validator: (text) {
                                if (text == null || text.isEmpty) {
                                  return 'Introduce una descripción';
                                }
                                return null;
                              },
                              controller: _textcontrollerDESC,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                actions: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: 5, bottom: 15),
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.grey[600],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: MaterialButton(
                        child: Text('Cancelar',
                            style: TextStyle(color: Colors.white)),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 15, bottom: 15),
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color.fromARGB(255, 252, 49, 208),
                            Color.fromARGB(255, 172, 64, 194),
                            Color.fromARGB(255, 59, 114, 196),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: MaterialButton(
                        child: Text('Listo',
                            style: TextStyle(color: Colors.white)),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _addTransaction();
                            getAllTransactions();
                            updateTotals();
                            Navigator.of(context).pop();
                            _textcontrollerAMOUNT.clear();
                            _textcontrollerDESC.clear();
                          }
                        },
                      ),
                    ),
                  )
                ],
              );
            },
          );
        });
  }

  // wait for the data to be fetched from google sheets
  bool timerHasStarted = false;
  void startLoading() {
    timerHasStarted = true;
    Timer.periodic(Duration(seconds: 1), (timer) {
      // if (GoogleSheetsApi.loading == false) {
      //   setState(() {});
      //   timer.cancel();
      // }
    });
  }

  @override
  Widget build(BuildContext context) {
    // start loading until the data arrives
    // if (GoogleSheetsApi.loading == true && timerHasStarted == false) {
    //   startLoading();
    // }

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            TopNeuCard(
              balance: totalIngresos - totalGastos,
              income: totalIngresos,
              expense: totalGastos,
            ),
            Expanded(
              child: Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Expanded(
                      child: FutureBuilder(
                        future: getAllTransactions(),
                        builder: (BuildContext context,
                            AsyncSnapshot<List<QueryDocumentSnapshot>>
                                snapshot) {
                          if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else if (snapshot.connectionState ==
                              ConnectionState.done) {
                            List<QueryDocumentSnapshot> documents =
                                snapshot.data!;
                            return ListView.builder(
                              itemCount: documents.length,
                              itemBuilder: (BuildContext context, int index) {
                                QueryDocumentSnapshot document =
                                    documents[index];
                                // Return a widget that displays the data from the document
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 12.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Dismissible(
                                      key: Key('item'),
                                      direction: DismissDirection.endToStart,
                                      background: Container(
                                        alignment: Alignment.centerRight,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20.0),
                                        color: Colors.red,
                                        child: Icon(
                                          Icons.delete,
                                          color: Colors.white,
                                        ),
                                      ),
                                      onDismissed: (direction) {
                                        _deleteTransaction(document.id);
                                        getTotalGasto();
                                        getTotalIngreso();
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(15),
                                        color: Colors.grey[100],
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.all(5),
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: Colors.grey[500]),
                                                  child: Center(
                                                    child: Icon(
                                                      Icons
                                                          .attach_money_outlined,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                    document.get('description'),
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.grey[700],
                                                    )),
                                              ],
                                            ),
                                            Text(
                                              (document.get('category') ==
                                                          'Gasto'
                                                      ? '-'
                                                      : '+') +
                                                  '\$' +
                                                  document.get('amount'),
                                              style: TextStyle(
                                                //fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                                color:
                                                    document.get('category') ==
                                                            'Gasto'
                                                        ? Colors.red
                                                        : Colors.green,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                                //MyTransaction(
                                //   transactionName: document.get('description'),
                                //   money: document.get('amount'),
                                //   expenseOrIncome: document.get('category'),
                                //   document: document,
                                // );
                              },
                            );
                          } else {
                            return LoadingCircle();
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            PlusButton(
              function: _newTransaction,
            ),
          ],
        ),
      ),
    );
  }
}
