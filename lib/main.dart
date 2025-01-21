import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:v1_micro_finance/configs/routes/routes.dart';
import 'package:v1_micro_finance/configs/routes/routes_name.dart';
import 'package:v1_micro_finance/providers/navigation_provider.dart';
import 'package:v1_micro_finance/screens/bottom/about_us_screen.dart';
import 'package:v1_micro_finance/screens/bottom/home_screen.dart';
import 'package:v1_micro_finance/screens/dashboard/referrals_screen.dart';
import 'package:v1_micro_finance/screens/profile/profile.dart';
import 'package:v1_micro_finance/widgets/app_drawer.dart';
import 'package:v1_micro_finance/widgets/bottom_nav_bar.dart';

void main() {
  runApp(MicroFinance());
}

class MicroFinance extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => NavigationProvider(),
      child: MaterialApp(
        title: 'Finance App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.blue),
        home: MainScreen(), // The main layout with persistent navigation
        onGenerateRoute: Routes.generateRoute, // Handles deep linking
      ),
    );
  }
}

class MainScreen extends StatelessWidget {
  final List<Widget> _screens = [
    HomeScreen(),
    AboutUsScreen(),
    ReferralsScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final navigationProvider = Provider.of<NavigationProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Micro Finance App')),
      drawer: AppDrawer(), // Persistent Drawer
      body: Stack(
        children: List.generate(_screens.length, (index) {
          return Offstage(
            offstage: navigationProvider.currentIndex != index,
            child: Navigator(
              key: navigationProvider
                  .getNavigatorKey(index), // Fixed navigator keys
              onGenerateInitialRoutes: (_, __) => [
                MaterialPageRoute(builder: (_) => _screens[index]),
              ],
            ),
          );
        }),
      ),
      bottomNavigationBar: BottomNavBar(), // Persistent Bottom Navigation Bar
    );
  }
}
