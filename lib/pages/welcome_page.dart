import 'dart:convert';
import 'package:cash_track/constants/box_shadow_decoration.dart';
import 'package:cash_track/data/global.dart';
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
        padding: const EdgeInsets.fromLTRB(
          screenPadding,
          0.0,
          screenPadding,
          24.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 30.0),
                Text(
                  'Welcome to \nCash Track',
                  style: TextStyle(fontSize: 54, fontWeight: FontWeight.bold),
                ),

                Text(
                  'Track. Grow. Save',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.grey[400],
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),

            Column(
              children: [
                Lottie.asset('assets/lotties/money.json'),

                SizedBox(height: 50.0),

                ButtonWidget(
                  buttonDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.0),
                    color: isDarkMode(context) ? Colors.white : Colors.black,
                    boxShadow: [BoxShadowStyles.defualtBoxShadow],
                  ),
                  onTapped: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage()),
                    );
                  },
                  content: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        'Get Started',
                        style: TextStyle(
                          color: isDarkMode(context)
                              ? Colors.black
                              : Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 10.0),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
