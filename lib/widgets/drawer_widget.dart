import 'package:cash_track/data/global.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SafeArea(
          child: Column(
            children: [
              Center(child: CircleAvatar(radius: 50.0)),
              SizedBox(height: 30.0),
              Text(
                'User',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              Divider(height: 60.0),
              ListTile(
                onTap: () async {
                  final SharedPreferences prefs =
                      await SharedPreferences.getInstance();

                  isDarkModeNotifier.value = !isDarkModeNotifier.value;

                  await prefs.setBool(isDarkModeKey, isDarkModeNotifier.value);
                },

                title: Row(
                  children: [
                    ValueListenableBuilder(
                      valueListenable: isDarkModeNotifier,
                      builder: (context, value, child) {
                        return Icon(
                          value == true ? Icons.light_mode : Icons.dark_mode,
                        );
                      },
                    ),
                    SizedBox(width: 10.0),
                    Text('Switch Colour Scheme'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
