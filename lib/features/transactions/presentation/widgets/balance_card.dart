import 'package:flutter/material.dart';

class TopNeuCard extends StatefulWidget {
  final double balance;
  final double income;
  final double expense;

  const TopNeuCard({
    super.key,
    required this.balance,
    required this.expense,
    required this.income,
  });

  @override
  State<TopNeuCard> createState() => _TopNeuCardState();
}

class _TopNeuCardState extends State<TopNeuCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 25.0),
      child: Container(
        height: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.grey[300],
          boxShadow: [
            BoxShadow(
                color: Colors.grey.shade500,
                offset: const Offset(4.0, 4.0),
                blurRadius: 15.0,
                spreadRadius: 1.0),
            const BoxShadow(
                color: Colors.white,
                offset: Offset(-4.0, -4.0),
                blurRadius: 15.0,
                spreadRadius: 1.0),
          ],
        ),
        child: Center(
          child: Container(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  Color.fromARGB(255, 252, 49, 208),
                  Color.fromARGB(255, 172, 64, 194),
                  Color.fromARGB(255, 59, 114, 196),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text('B A L A N C E',
                    style: TextStyle(color: Colors.white, fontSize: 16)),
                Text(
                  '\$${widget.balance}',
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                      fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.grey[200],
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.arrow_upward,
                                color: Colors.green,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Ingresos',
                                  style: TextStyle(color: Colors.white)),
                              const SizedBox(
                                height: 5,
                              ),
                              Text('\$${widget.income}',
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)),
                            ],
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.grey[200],
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.arrow_downward,
                                color: Colors.red,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Gastos',
                                  style: TextStyle(color: Colors.white)),
                              const SizedBox(
                                height: 5,
                              ),
                              Text('\$${widget.expense}',
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
