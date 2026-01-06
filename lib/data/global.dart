import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

ValueNotifier<bool> isDarkModeNotifier = ValueNotifier(false);
ValueNotifier<List<Map<String, dynamic>>> transactionsListNotifier =
    ValueNotifier([]);
ValueNotifier<double> balanceNotifier = ValueNotifier(0.0);

const String isDarkModeKey = 'isDarkMode';
const String balanceKey = 'BalanceAmount';
const String transactionsKey = 'transactions';

const double screenPadding = 15.0;
const double borderRad = 16.0;

void setBalance(double newBalance) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  balanceNotifier.value = newBalance;
  prefs.setDouble(balanceKey, balanceNotifier.value);
}

void saveTransactions() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString(transactionsKey, jsonEncode(transactionsListNotifier.value));
}

bool isDarkMode(context) {
  return Theme.brightnessOf(context) == Brightness.dark;
}
