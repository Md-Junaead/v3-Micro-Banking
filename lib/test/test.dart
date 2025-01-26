import 'package:flutter/material.dart';

// AppDrawer widget with added header for profile and username
class TestScreen extends StatelessWidget {
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
          // Drawer Header with Profile Picture and Username
          DrawerHeader(
            decoration: BoxDecoration(
              color: Color(0xFF06426D), // Same background color as the drawer
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center, // Center content
              children: [
                // Profile Picture (Circular, Size 50, fetched from API)
                CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(
                      'https://your-api-endpoint.com/profile-image'), // Replace with API URL to fetch profile picture
                  backgroundColor: Colors
                      .transparent, // Transparent background to maintain circular shape
                ),
                SizedBox(
                    height:
                        10), // Spacing between the profile picture and username
                // Username (Fetched via API, color white, size 22)
                Text(
                  'User Name', // Replace with the fetched username
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight:
                        FontWeight.bold, // Optional: To make the username bold
                  ),
                ),
              ],
            ),
          ),

          // Close button at the top right
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: Icon(Icons.close, color: Colors.white, size: 30),
                onPressed: () => Navigator.pop(context), // Close the drawer
              ),
            ),
          ),

          // Drawer items (List of navigation options)
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center, // Center content
                children: [
                  // Add Money option
                  ListTile(
                    leading: Icon(Icons.account_balance_wallet,
                        color: Colors.white, size: 25),
                    title: Text('Add Money',
                        style: TextStyle(color: Colors.white)),
                    onTap: () => _navigateToScreen(context, '/addMoney'),
                  ),
                  // Package Info option
                  ListTile(
                    leading: Icon(Icons.info, color: Colors.white, size: 25),
                    title: Text('Package Info',
                        style: TextStyle(color: Colors.white)),
                    onTap: () => _navigateToScreen(context, '/packageInfo'),
                  ),
                  // Statement option
                  ListTile(
                    leading: Icon(Icons.receipt, color: Colors.white, size: 25),
                    title: Text('Statement',
                        style: TextStyle(color: Colors.white)),
                    onTap: () => _navigateToScreen(context, '/statement'),
                  ),
                  // Withdraw ExpansionTile
                  ExpansionTile(
                    leading: Icon(Icons.arrow_drop_down,
                        color: Colors.white, size: 25),
                    title:
                        Text('Withdraw', style: TextStyle(color: Colors.white)),
                    children: [
                      // New Request option
                      ListTile(
                        leading: Icon(Icons.request_page,
                            color: Colors.white, size: 25),
                        title: Text('New Request',
                            style: TextStyle(color: Colors.white)),
                        onTap: () =>
                            _navigateToScreen(context, '/withdrawNewRequest'),
                      ),
                      // Status option
                      ListTile(
                        leading: Icon(Icons.query_stats,
                            color: Colors.white, size: 25),
                        title: Text('Status',
                            style: TextStyle(color: Colors.white)),
                        onTap: () =>
                            _navigateToScreen(context, '/withdrawStatus'),
                      ),
                    ],
                  ),
                  // Referral Link option
                  ListTile(
                    leading: Icon(Icons.link, color: Colors.white, size: 25),
                    title: Text('Referral Link',
                        style: TextStyle(color: Colors.white)),
                    onTap: () => _navigateToScreen(context, '/referralLink'),
                  ),
                  // Log Out option
                  ListTile(
                    leading:
                        Icon(Icons.exit_to_app, color: Colors.white, size: 25),
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
