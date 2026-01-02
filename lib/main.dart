import 'package:cash_track/data/notifiers.dart';
import 'package:cash_track/pages/welcome_page.dart';
import 'package:flutter/material.dart';

void main() {
  return runApp(
    ValueListenableBuilder(
      valueListenable: isDarkModeNotifier,
      builder: (context, value, child) {
        return MaterialApp(
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.white,
              brightness: value == true ? Brightness.dark : Brightness.light,
            ),
          ),
          home: Scaffold(body: WelcomePage()),
        );
      },
    ),
  );
}
