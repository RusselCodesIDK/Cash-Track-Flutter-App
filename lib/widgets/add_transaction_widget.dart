import 'package:cash_track/constants/box_shadow_decoration.dart';
import 'package:cash_track/data/global.dart';
import 'package:cash_track/widgets/button_widget.dart';
import 'package:flutter/material.dart';

class AddTransactionWidget extends StatefulWidget {
  const AddTransactionWidget({super.key, required this.add});

  final bool add;

  @override
  State<AddTransactionWidget> createState() => _AddTransactionWidgetState();
}

class _AddTransactionWidgetState extends State<AddTransactionWidget> {
  TextEditingController nameTextController = TextEditingController();
  TextEditingController priceTextController = TextEditingController();

  String errorMessage = '';

  void onDonePressed() async {
    if (nameTextController.text == '' || priceTextController.text == '') {
      errorMessage = 'please fill in inputs!.';
    } else {
      double price = widget.add == false
          ? -double.parse(priceTextController.text)
          : double.parse(priceTextController.text);

      Navigator.pop(context);
      errorMessage = '';

      transactionsListNotifier.value = [
        {'title': nameTextController.text, 'price': price},
        ...transactionsListNotifier.value,
      ];

      //set and save balance data
      setBalance(balanceNotifier.value = balanceNotifier.value + price);
      saveTransactions();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          errorMessage,
          style: TextStyle(color: Colors.red, fontWeight: FontWeight.w700),
        ),
        SizedBox(height: 20.0),
        TextField(
          controller: nameTextController,
          decoration: InputDecoration(
            hintText: 'Transaction name',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
          ),
        ),
        SizedBox(height: 24.0),
        TextField(
          controller: priceTextController,
          keyboardType: TextInputType.numberWithOptions(),
          decoration: InputDecoration(
            hintText: 'Amount(ZAR)',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
          ),
        ),
        SizedBox(height: 24.0),
        ButtonWidget(
          buttonDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0),
            color: isDarkMode(context) ? Colors.white : Colors.black,
            boxShadow: [BoxShadowStyles.defualtBoxShadow],
          ),
          onTapped: () {
            onDonePressed();
            setState(() {});
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
      ],
    );
  }
}
