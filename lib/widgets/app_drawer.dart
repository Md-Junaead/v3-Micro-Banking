import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  // Function to navigate to a new screen
  void _navigateToScreen(BuildContext context, String screenName) {
    Navigator.pushReplacementNamed(context, screenName);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Color(0xFF06426D), // Drawer background color
      child: Column(
        children: [
          // Close button at the top right
          Padding(
            padding: EdgeInsets.only(top: 20),
            child: Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: Icon(Icons.close, color: Colors.white, size: 30),
                onPressed: () => Navigator.pop(context), // Close the drawer
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center, // Center content
                children: [
                  ListTile(
                    leading: Icon(Icons.account_balance_wallet,
                        color: Colors.white, size: 25), // Icon for Add Money
                    title: Text('Add Money',
                        style: TextStyle(color: Colors.white)),
                    onTap: () => _navigateToScreen(context, '/addMoney'),
                  ),
                  ListTile(
                    leading: Icon(Icons.info,
                        color: Colors.white, size: 25), // Icon for Package Info
                    title: Text('Package Info',
                        style: TextStyle(color: Colors.white)),
                    onTap: () => _navigateToScreen(context, '/packageInfo'),
                  ),
                  ListTile(
                    leading: Icon(Icons.receipt,
                        color: Colors.white, size: 25), // Icon for Statement
                    title: Text('Statement',
                        style: TextStyle(color: Colors.white)),
                    onTap: () => _navigateToScreen(context, '/statement'),
                  ),
                  ExpansionTile(
                    leading: Icon(Icons.arrow_drop_down,
                        color: Colors.white, size: 25), // Icon for Withdraw
                    title:
                        Text('Withdraw', style: TextStyle(color: Colors.white)),
                    children: [
                      ListTile(
                        leading: Icon(Icons.request_page,
                            color: Colors.white,
                            size: 25), // Icon for New request
                        title: Text('New Request',
                            style: TextStyle(color: Colors.white)),
                        onTap: () =>
                            _navigateToScreen(context, '/withdrawNewRequest'),
                      ),
                      ListTile(
                        leading: Icon(Icons.query_stats,
                            color: Colors.white, size: 25), // Icon for Status
                        title: Text('Status',
                            style: TextStyle(color: Colors.white)),
                        onTap: () =>
                            _navigateToScreen(context, '/withdrawStatus'),
                      ),
                    ],
                  ),
                  ListTile(
                    leading: Icon(Icons.link,
                        color: Colors.white,
                        size: 25), // Icon for Referral Link
                    title: Text('Referral Link',
                        style: TextStyle(color: Colors.white)),
                    onTap: () => _navigateToScreen(context, '/referralLink'),
                  ),
                  ListTile(
                    leading: Icon(Icons.exit_to_app,
                        color: Colors.white, size: 25), // Icon for Log out
                    title:
                        Text('Log Out', style: TextStyle(color: Colors.white)),
                    onTap: () => _navigateToScreen(context, '/logout'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
