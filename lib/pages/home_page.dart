import 'package:cash_track/data/notifiers.dart';
import 'package:cash_track/widgets/add_transaction_widget.dart';
import 'package:cash_track/widgets/balance_display_widget.dart';
import 'package:cash_track/widgets/bottom_sheet_widget.dart';
import 'package:cash_track/widgets/button_widget.dart';
import 'package:cash_track/widgets/drawer_widget.dart';
import 'package:cash_track/widgets/transaction_card_widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(),
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: Text(
          'Cash Track',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  BalanceDisplayWidget(),

                  SizedBox(height: 24.0),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.history),
                          SizedBox(width: 10.0),
                          Text(
                            'History',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          ButtonWidget(
                            title: 'Deduct',
                            textColor:
                                Theme.brightnessOf(context) == Brightness.light
                                ? Colors.white
                                : Colors.black87,
                            onTapped: () {
                              showModalBottomSheet(
                                showDragHandle: true,
                                useSafeArea: true,
                                isScrollControlled: true,
                                context: context,
                                builder: (context) {
                                  return BottomSheetWidget(
                                    title: 'Deduct balance',
                                    content: Padding(
                                      padding: EdgeInsets.only(
                                        bottom: MediaQuery.of(
                                          context,
                                        ).viewInsets.bottom,
                                      ),
                                      child: AddTransactionWidget(add: false),
                                    ),
                                  );
                                },
                              );
                            },
                            buttonColor: Colors.red,
                            buttonPadding: 15.0,
                          ),
                          SizedBox(width: 10.0),
                          ButtonWidget(
                            textColor:
                                Theme.brightnessOf(context) == Brightness.light
                                ? Colors.white
                                : Colors.black87,
                            title: 'Increase',
                            onTapped: () {
                              showModalBottomSheet(
                                showDragHandle: true,
                                useSafeArea: true,
                                isScrollControlled: true,
                                context: context,
                                builder: (context) {
                                  return BottomSheetWidget(
                                    title: 'Increase balance',
                                    content: Padding(
                                      padding: EdgeInsets.only(
                                        bottom: MediaQuery.of(
                                          context,
                                        ).viewInsets.bottom,
                                      ),
                                      child: AddTransactionWidget(add: true),
                                    ),
                                  );
                                },
                              );
                            },
                            buttonColor: Colors.green,
                            buttonPadding: 15.0,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 24.0),
            Expanded(
              child: ValueListenableBuilder(
                valueListenable: transactionsListNotifier,

                builder: (context, value, child) {
                  // cast to proper type

                  if (value.isEmpty) {
                    return Center(
                      child: Text(
                        'No transactions yet',
                        style: TextStyle(color: Colors.grey, fontSize: 16),
                      ),
                    );
                  }

                  return ListView.builder(
                    itemCount: value.length,
                    itemBuilder: (context, index) {
                      final transaction = value[index];
                      return TransactionCardWidget(
                        transactionName: transaction['title'],
                        price: transaction['price'],
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
