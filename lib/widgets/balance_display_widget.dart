import 'package:cash_track/constants/box_shadow_decoration.dart';
import 'package:cash_track/data/notifiers.dart';
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
              child: ChangeBalanceModalWidget(),
            );
          },
        );
      },
      child: Ink(
        width: double.infinity,
        height: 300.0,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: <Color>[Colors.red, Colors.deepPurple],
          ),
          borderRadius: BorderRadius.circular(32.0),
          boxShadow: [BoxShadowStyles.defualtBoxShadow],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Balance', style: TextStyle(color: Colors.white)),
            SizedBox(height: 6),

            ValueListenableBuilder(
              valueListenable: balanceNotifier,
              builder: (context, value, child) => Text(
                'R ${formatMoney(value)}',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
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
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          Text(
            'Set Balance',
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
          ),
          SizedBox(height: 24),
          TextField(
            controller: balanceTextController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'new balance(ZAR)',
            ),
          ),
          SizedBox(height: 24.0),
          ButtonWidget(
            title: 'Done',
            onTapped: () {
              if (balanceTextController.text.isNotEmpty) {
                setBalance(double.parse(balanceTextController.text));
              }
            },
          ),
          SizedBox(height: 24.0),
        ],
      ),
    );
  }
}
