import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/navigation_provider.dart';

class BottomNavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final navigationProvider = Provider.of<NavigationProvider>(context);

    return BottomNavigationBar(
      currentIndex: navigationProvider.currentIndex,
      onTap: navigationProvider.updateIndex, // Updates selected index
      selectedItemColor: Colors.white, // Active icon color
      unselectedItemColor: Colors.black54, // Inactive icon color
      backgroundColor: Color(0xFF06426D), // Background color
      type: BottomNavigationBarType.fixed, // Prevents shifting animation
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.info), label: "About Us"),
        BottomNavigationBarItem(
            icon: Icon(Icons.monetization_on), label: "Loan / Dollar"),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
      ],
    );
  }
}
