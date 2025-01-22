//Home Page

import 'package:flutter/material.dart';
import 'package:v1_micro_finance/screens/dashboard/packages_screen.dart';

class TestScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (settings) {
        Widget page = HomeContent(); // Default home content
        if (settings.name == '/package') {
          page = PackagesScreen();
        }
        return MaterialPageRoute(builder: (_) => page);
      },
    );
  }
}

class HomeContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          Navigator.of(context).pushNamed('/package'); // Uses nested navigation
        },
        child: Text("Go to Package Screen"),
      ),
    );
  }
}
