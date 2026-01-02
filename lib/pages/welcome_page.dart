import 'dart:convert';

import 'package:cash_track/data/notifiers.dart';
import 'package:cash_track/pages/home_page.dart';
import 'package:cash_track/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:lottie/lottie.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  // Load data
  void loadData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    loadThemeData(prefs);
    loadBalanceAndTransactionData(prefs);
  }

  void loadBalanceAndTransactionData(SharedPreferences prefs) {
    balanceNotifier.value = prefs.getDouble(balanceKey) ?? 0.0;

    final String? transactionsString = prefs.getString(transactionsKey);

    final List<Map<String, dynamic>> loadedTransactions =
        (transactionsString != null
        ? List<Map<String, dynamic>>.from(
            jsonDecode(
              transactionsString,
            ).map((e) => Map<String, dynamic>.from(e)),
          )
        : []);

    transactionsListNotifier.value = loadedTransactions;
  }

  void loadThemeData(SharedPreferences prefs) async {
    isDarkModeNotifier.value = prefs.getBool(isDarkModeKey) ?? false;
  }

  @override
  void initState() {
    loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Spacer(),
            Text(
              'Welcome to Cash Track',
              style: TextStyle(fontSize: 54, fontWeight: FontWeight.bold),
            ),
            Text(
              'Track. Grow. Save',
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.grey[400],
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 64),
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 350.0,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(24, 72, 255, 0),
                    borderRadius: BorderRadius.circular(32),
                  ),
                ),
                Lottie.asset('assets/lotties/money.json'),
              ],
            ),
            SizedBox(height: 100.0),
            ButtonWidget(
              title: 'Get Started',
              onTapped: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
