import 'package:cash_track/data/notifiers.dart';
import 'package:flutter/material.dart';

class TransactionCardWidget extends StatefulWidget {
  const TransactionCardWidget({
    super.key,
    required this.transactionName,
    required this.price,
  });

  final String transactionName;
  final double price;

  @override
  State<TransactionCardWidget> createState() => _TransactionCardWidgetState();
}

class _TransactionCardWidgetState extends State<TransactionCardWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 5.0),
      child: GestureDetector(
        child: Container(
          decoration: BoxDecoration(
            color: Theme.brightnessOf(context) == Brightness.dark
                ? const Color.fromARGB(255, 28, 28, 28)
                : Colors.white,
            borderRadius: BorderRadius.circular(16.0),
            boxShadow: [
              BoxShadow(
                color: const Color.fromARGB(52, 0, 0, 0),
                offset: Offset(0, 4),
                blurRadius: 10.0,
                spreadRadius: 1.0,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 20.0,
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.transactionName,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          '${widget.price > 0.0 ? '+' : '-'}R${widget.price.abs()}',
                          style: TextStyle(
                            color: widget.price > 0.0
                                ? Colors.green
                                : Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            // Find the transaction first
                            final transaction = transactionsListNotifier.value
                                .firstWhere(
                                  (tx) => tx['title'] == widget.transactionName,
                                  orElse: () => {}, // in case it's not found
                                );

                            if (transaction.isNotEmpty) {
                              // Subtract its price from balance
                              setBalance(
                                balanceNotifier.value -
                                    (transaction['price'] as double),
                              );

                              // Remove the transaction from the list
                              transactionsListNotifier
                                  .value = transactionsListNotifier.value
                                  .where(
                                    (tx) =>
                                        tx['title'] != widget.transactionName,
                                  )
                                  .toList();

                              // Save the updated list
                              saveTransactions();
                            }
                          },
                          icon: Icon(Icons.delete),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
