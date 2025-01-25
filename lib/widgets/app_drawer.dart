import 'package:flutter/material.dart';

// Assuming you are using the `http` package to fetch data from an API.
// To add the http package to your project, include the following in your `pubspec.yaml`:
// dependencies:
//   http: ^0.14.0

class AppDrawer extends StatelessWidget {
  final String demoUsername =
      'Demo User'; // This should be replaced by actual data fetched from API

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Color(0xFF06426D), // Background color of the drawer
      child: SingleChildScrollView(
        // Makes the drawer scrollable
        child: Column(
          children: [
            // Cross Icon to close the drawer
            Padding(
              padding: EdgeInsets.only(right: 20, top: 20),
              child: Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: Icon(Icons.close, color: Colors.white),
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the drawer
                  },
                ),
              ),
            ),
            SizedBox(height: 20),

            // Drawer Header Section
            Container(
              padding: EdgeInsets.only(top: 20),
              child: Column(
                children: [
                  // Profile Image
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage(
                        'assets/images/image_one.jpeg'), // User image
                  ),
                  SizedBox(height: 10),
                  // Username Text
                  Text(
                    demoUsername, // Demo username, replace it with actual API data
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),

            // Menu Section
            _buildMenuItem(context, Icons.account_balance_wallet, 'Add Money',
                () {
              Navigator.pushNamed(
                  context, '/addMoney'); // Replace with actual navigation
            }),
            _buildMenuItem(context, Icons.info, 'Package Info', () {
              Navigator.pushNamed(
                  context, '/packageInfo'); // Replace with actual navigation
            }),
            _buildMenuItem(context, Icons.receipt, 'Statement', () {
              Navigator.pushNamed(
                  context, '/statement'); // Replace with actual navigation
            }),
            _buildSubMenu(context, Icons.arrow_drop_down, 'Withdraw', [
              _buildMenuItem(context, Icons.add, 'New Request', () {
                Navigator.pushNamed(context,
                    '/withdrawNewRequest'); // Replace with actual navigation
              }),
              _buildMenuItem(context, Icons.query_stats, 'Status', () {
                Navigator.pushNamed(context,
                    '/withdrawStatus'); // Replace with actual navigation
              }),
            ]),
            _buildMenuItem(context, Icons.link, 'Referral Link', () {
              Navigator.pushNamed(
                  context, '/referralLink'); // Replace with actual navigation
            }),
            _buildMenuItem(context, Icons.exit_to_app, 'Log Out', () {
              Navigator.pushNamed(
                  context, '/logout'); // Replace with actual navigation
            }),
          ],
        ),
      ),
    );
  }

  // Method to build each menu item
  Widget _buildMenuItem(
      BuildContext context, IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(
        title,
        style: TextStyle(color: Colors.white),
      ),
      onTap: onTap,
    );
  }

  // Method to build sub-menu with expandable options (for Withdraw)
  Widget _buildSubMenu(BuildContext context, IconData icon, String title,
      List<Widget> subMenuItems) {
    return ExpansionTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(title, style: TextStyle(color: Colors.white)),
      children: subMenuItems,
    );
  }
}
