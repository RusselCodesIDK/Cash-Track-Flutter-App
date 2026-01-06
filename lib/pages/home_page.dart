import 'package:cash_track/constants/box_shadow_decoration.dart';
import 'package:cash_track/data/global.dart';
import 'package:cash_track/widgets/balance_display_widget.dart';
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
              padding: const EdgeInsets.symmetric(horizontal: screenPadding),
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
                            'Activity',
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      Row(children: [SizedBox(width: 10.0)]),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 24.0),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: screenPadding),
                child: ClipRRect(
                  borderRadius: BorderRadiusGeometry.circular(16.0),
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [BoxShadowStyles.defualtBoxShadow],
                      color: isDarkMode(context)
                          ? const Color.fromARGB(115, 56, 56, 56)
                          : const Color.fromARGB(255, 228, 228, 228),
                    ),
                    child: ValueListenableBuilder(
                      valueListenable: transactionsListNotifier,

                      builder: (context, value, child) {
                        // cast to proper type

                        if (value.isEmpty) {
                          return Center(
                            child: Text(
                              'No transactions yet',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 16,
                              ),
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
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
