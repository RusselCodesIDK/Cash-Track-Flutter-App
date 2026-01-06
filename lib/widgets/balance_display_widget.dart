import 'package:cash_track/constants/box_shadow_decoration.dart';
import 'package:cash_track/data/global.dart';
import 'package:cash_track/widgets/add_transaction_widget.dart';
import 'package:cash_track/widgets/bottom_sheet_widget.dart';
import 'package:cash_track/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String formatMoney(double value) {
  final formatter = NumberFormat('#,##0.00');
  return formatter.format(value);
}

class BalanceDisplayWidget extends StatefulWidget {
  BalanceDisplayWidget({super.key});
  final double balance = balanceNotifier.value;

  @override
  State<BalanceDisplayWidget> createState() => _BalanceDisplayWidgetState();
}

class _BalanceDisplayWidgetState extends State<BalanceDisplayWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16.0),
      onTap: () {
        showModalBottomSheet(
          showDragHandle: true,
          isScrollControlled: true,
          useSafeArea: true,
          context: context,
          builder: (context) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: BottomSheetWidget(
                title: 'Set Balance',
                content: ChangeBalanceModalWidget(),
              ),
            );
          },
        );
      },
      child: Ink(
        width: double.infinity,
        height: 300.0,
        decoration: BoxDecoration(
          color: Colors.teal,
          borderRadius: BorderRadius.circular(32.0),
          boxShadow: [BoxShadowStyles.defualtBoxShadow],
        ),

        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 5.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,

            children: [
              Text('Balance', style: TextStyle(color: Colors.white)),

              ValueListenableBuilder(
                valueListenable: balanceNotifier,
                builder: (context, value, child) => Text(
                  'R ${formatMoney(value)}',
                  style: TextStyle(
                    fontSize: 38,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,

                children: [
                  ButtonWidget(
                    buttonDecoration: BoxDecoration(
                      border: BoxBorder.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    onTapped: () {
                      showModalBottomSheet(
                        showDragHandle: true,
                        useSafeArea: true,
                        isScrollControlled: true,
                        context: context,
                        builder: (context) {
                          return BottomSheetWidget(
                            title: 'Deduct Balance',
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
                    content: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20.0,
                        vertical: 10.0,
                      ),
                      child: Text(
                        'Deduct',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(width: 20.0),
                  ButtonWidget(
                    buttonDecoration: BoxDecoration(
                      border: BoxBorder.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    onTapped: () {
                      showModalBottomSheet(
                        showDragHandle: true,
                        useSafeArea: true,
                        isScrollControlled: true,
                        context: context,
                        builder: (context) {
                          return BottomSheetWidget(
                            title: 'Increase Balance',
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
                    content: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20.0,
                        vertical: 10.0,
                      ),
                      child: Text(
                        'Increase',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ChangeBalanceModalWidget extends StatefulWidget {
  const ChangeBalanceModalWidget({super.key});

  @override
  State<ChangeBalanceModalWidget> createState() =>
      _ChangeBalanceModalWidgetState();
}

class _ChangeBalanceModalWidgetState extends State<ChangeBalanceModalWidget> {
  TextEditingController balanceTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: 24.0),
        TextField(
          controller: balanceTextController,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            hintText: 'new balance',
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
            if (balanceTextController.text.isNotEmpty) {
              setBalance(double.parse(balanceTextController.text));
            }
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
      ],
    );
  }
}
