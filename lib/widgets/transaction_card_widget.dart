import 'package:cash_track/constants/box_shadow_decoration.dart';
import 'package:cash_track/data/global.dart';
import 'package:cash_track/widgets/bottom_sheet_widget.dart';
import 'package:cash_track/widgets/button_widget.dart';
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
    return Material(
      color: Colors.transparent, // important for InkWell ripple
      child: InkWell(
        onTap: () {
          showModalBottomSheet(
            showDragHandle: true,
            useSafeArea: true,
            isScrollControlled: true,
            context: context,
            builder: (context) {
              return BottomSheetWidget(
                title: 'Edit Transaction',
                content: Padding(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                  ),
                  child: EditTransaction(
                    transactionName: widget.transactionName,
                  ),
                ),
              );
            },
          );
        },
        child: Ink(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                width: 1.0,
                color: isDarkMode(context)
                    ? const Color.fromARGB(255, 89, 89, 89)
                    : const Color.fromARGB(255, 201, 201, 201),
              ),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 20.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.transactionName,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  '${widget.price > 0.0 ? '+' : '-'}R${widget.price.abs()}',
                  style: TextStyle(
                    color: widget.price > 0.0 ? Colors.green : Colors.red,
                    fontWeight: FontWeight.w500,
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class EditTransaction extends StatefulWidget {
  const EditTransaction({super.key, required this.transactionName});

  final String transactionName;

  @override
  State<EditTransaction> createState() => _EditTransactionState();
}

class _EditTransactionState extends State<EditTransaction> {
  TextEditingController transactionPriceTextController =
      TextEditingController();
  TextEditingController transactionNameTextController = TextEditingController();

  Map<String, dynamic> getTransaction() {
    return transactionsListNotifier.value.firstWhere(
      (tx) => tx['title'] == widget.transactionName,
      orElse: () => {},
    );
  }

  @override
  void initState() {
    super.initState();
    final transaction = getTransaction();
    transactionNameTextController.text = transaction['title'];
    transactionPriceTextController.text = transaction['price'].toString();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: 12.0),
        TextField(
          controller: transactionNameTextController,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            hintText: 'Transaction name',
          ),
        ),
        SizedBox(height: 12.0),
        TextField(
          controller: transactionPriceTextController,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            hintText: 'Transaction price',
          ),
        ),
        SizedBox(height: 12.0),
        ButtonWidget(
          buttonDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0),
            color: isDarkMode(context) ? Colors.white : Colors.black,
            boxShadow: [BoxShadowStyles.defualtBoxShadow],
          ),
          onTapped: () {
            if (transactionNameTextController.text.isEmpty ||
                transactionPriceTextController.text.isEmpty) {
              return;
            }

            final newTitle = transactionNameTextController.text;
            final newPrice = double.parse(transactionPriceTextController.text);

            final oldList = transactionsListNotifier.value;

            final updatedList = oldList.map((tx) {
              if (tx['title'] == widget.transactionName) {
                return {'title': newTitle, 'price': newPrice};
              }
              return tx;
            }).toList();

            // Fix balance properly
            final oldTransaction = oldList.firstWhere(
              (tx) => tx['title'] == widget.transactionName,
            );

            setBalance(
              balanceNotifier.value -
                  (oldTransaction['price'] as double) +
                  newPrice,
            );

            transactionsListNotifier.value = updatedList;
            saveTransactions();
            Navigator.pop(context);
          },

          content: Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                'Done',
                style: TextStyle(
                  color: isDarkMode(context) ? Colors.black : Colors.white,
                ),
              ),
            ),
          ),
        ),
        Divider(height: 24),
        ButtonWidget(
          buttonDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0),
            color: const Color.fromARGB(255, 187, 0, 0),
            boxShadow: [BoxShadowStyles.defualtBoxShadow],
          ),
          onTapped: () {
            final transaction = getTransaction();

            if (transaction.isNotEmpty) {
              setBalance(
                balanceNotifier.value - (transaction['price'] as double),
              );

              transactionsListNotifier.value = transactionsListNotifier.value
                  .where((tx) => tx['title'] != widget.transactionName)
                  .toList();

              saveTransactions();
            }
            Navigator.pop(context);
          },
          content: Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text('Delete', style: TextStyle(color: Colors.white)),
            ),
          ),
        ),
      ],
    );
  }
}
