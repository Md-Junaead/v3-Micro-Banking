import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:v1_micro_finance/providers/navigation_provider.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final navigationProvider = Provider.of<NavigationProvider>(context);

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Color(0xFF06426D)),
            child: Text("Menu",
                style: TextStyle(color: Colors.white, fontSize: 24)),
          ),
          _buildDrawerItem(context, Icons.home, "Home", 0),
          _buildDrawerItem(context, Icons.info, "About Us", 1),
          _buildDrawerItem(context, Icons.monetization_on, "Loan / Dollar", 2),
          _buildDrawerItem(context, Icons.person, "Profile", 3),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(
      BuildContext context, IconData icon, String title, int index) {
    final navigationProvider =
        Provider.of<NavigationProvider>(context, listen: false);

    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: () {
        navigationProvider.updateIndex(index);
        Navigator.pop(context); // Close the drawer
      },
    );
  }
}
